import 'package:flutter/material.dart';
import 'package:frandr/displays/configuration_repository/configuration_repository.dart';

import 'configuration_repository/configuration_helper.dart';
import 'models.dart';

class DisplaysState {
  final displays = ValueNotifier(<ValueNotifier<Display>>[]);
  final aspectRatio = ValueNotifier(8);
  final configDirectory = ValueNotifier("");
  final wiggleRoom = ValueNotifier(25);
  double verticalScrollOffset = 0;
  double horizontalScrollOffset = 0;
  final configurations =
      ValueNotifier<Map<String, ValueNotifier<Configuration>>>({});
  final currentSetupHash = ValueNotifier('');
  final selectedSetupId = ValueNotifier<String?>(null);

  Future<bool> get selectedHashMatchesActualHast async =>
      selectedSetupId.value ==
      await ConfigurationHelper.generateCurrentConfigurationHash();

  // TODO: load configuration and keep defaults if not found. Update UI to reflect missing configurations. Also add an ADD configuration button.

  Future<DisplaysState> initialize() async {
    configDirectory.value = ConfigurationRepository.configurationDirectory;
    configurations.value = (await ConfigurationRepository.loadConfigurations(
            configDirectory.value))
        .map((key, value) => MapEntry(key, ValueNotifier(value)));
    currentSetupHash.value =
        await ConfigurationHelper.generateCurrentConfigurationHash();
    await selectConfiguration();

    return this;
  }

  void syncConfigWithDisplays() {
    final config = configurations.value[currentSetupHash];
    if (config == null) return;
    final setups = config.value.setups;
    final setup = setups[selectedSetupId]?.copyWith(
      displays: displays.value.map((e) => e.value).toList(),
      aspectRatio: aspectRatio.value,
    );
    setups[selectedSetupId.value ?? ''] = setup ?? Setup(id: uuid());
    config.value = config.value.copyWith(setups: setups);
  }

  Future<void> selectConfiguration() async {
    if (currentSetupHash.value.isEmpty) return;

    var configuration = configurations.value[currentSetupHash.value]?.value;
    if (configuration != null) {
      selectedSetupId.value = configuration.selectedSetupId;
      final setup = configuration.setups[selectedSetupId.value ?? ''];

      if (setup == null) {
        displays.value = await mapConnectedDisplays();
        aspectRatio.value = 8;
        final setupId = uuid();
        configuration = configuration.copyWith(setups: {
          ...configuration.setups,
          setupId: Setup(
            id: setupId,
            aspectRatio: aspectRatio.value,
            displays: displays.value.map((e) => e.value).toList(),
          ),
        });
        selectedSetupId.value = setupId;
      } else {
        displays.value = setup.displays.map((e) => ValueNotifier(e)).toList();
        aspectRatio.value = setup.aspectRatio;
      }
    } else {
      configuration = const Configuration();
      configurations.value[currentSetupHash.value] =
          ValueNotifier(configuration);
      selectedSetupId.value = configuration.selectedSetupId;
      displays.value = await mapConnectedDisplays();
      aspectRatio.value = 8;
    }
  }

  void changeDisplayName(int index, String name) {
    final display = displays.value[index];
    display.value = display.value.copyWith(name: name);
    syncConfigWithDisplays();
  }

  Future<List<ValueNotifier<Display>>> mapConnectedDisplays() async {
    final connectedDisplays = await ConfigurationHelper.getConnectedDisplays();

    return connectedDisplays
        .map(
          (key, value) => MapEntry(
            key,
            ValueNotifier(Display(
              outputName: key,
              connected: value,
              active: true,
            )),
          ),
        )
        .values
        .toList();
  }

  void changeDisplayIsPrimary(int index, bool isPrimary) {
    if (isPrimary) {
      for (int i = 0; i < displays.value.length; i++) {
        final state = displays.value[i];
        final display = state.value;
        state.value = display.copyWith(primary: display.active && i == index);
      }

      syncConfigWithDisplays();
      return;
    }

    final state = displays.value[index];
    final display = state.value;
    state.value = display.copyWith(primary: false);

    final newPrimary = displays.value.firstWhere((e) => e.value.active);
    newPrimary.value = newPrimary.value.copyWith(primary: true);
    syncConfigWithDisplays();
  }

  void changeDisplayIsActive(int index, bool isActive) {
    final state = displays.value[index];
    if (isActive && !state.value.connected) return;

    state.value = state.value.copyWith(active: isActive);

    if (!isActive && displays.value.every((e) => !e.value.active)) {
      final newActive = displays.value.firstWhere((e) => e.value.connected);
      newActive.value = newActive.value.copyWith(active: true);
    }

    syncConfigWithDisplays();
  }

  void changeDisplayOrientation(int index, DisplayOrientation orientation) {
    final display = displays.value[index];
    display.value = display.value.copyWith(orientation: orientation);
    syncConfigWithDisplays();
  }

  void changeDisplayRefresh(int index, double refreshRate) {
    final display = displays.value[index];
    display.value = display.value.copyWith(refreshRate: refreshRate);
    syncConfigWithDisplays();
  }

  void changeDisplayResolution(int index, Resolution resolution) {
    final display = displays.value[index];
    display.value = display.value.copyWith(resolution: resolution);
    syncConfigWithDisplays();
  }

  void changeDisplayOffset(int index, DisplayOffset offset) {
    final display = displays.value[index];
    display.value = display.value.copyWith(offset: offset);
    syncConfigWithDisplays();
  }

  void updateAspectRatio(int value) {
    for (var display in displays.value) {
      final offset = display.value.offset;
      final x = offset.x;
      final y = offset.y;
      display.value = display.value.copyWith.offset(
        x: x * aspectRatio.value ~/ value,
        y: y * aspectRatio.value ~/ value,
      );
    }
    aspectRatio.value = value;
    syncConfigWithDisplays();
  }

  void updateDisplayCoordinates(DraggableDetails draggableDetails, int index) {
    final displayState = displays.value.elementAt(index);
    var offsetX = draggableDetails.offset.dx + horizontalScrollOffset;
    final offsetY =
        draggableDetails.offset.dy - kToolbarHeight + verticalScrollOffset;

    final x = _calculateXForDisplayArea(offsetX, displayState.value, index);
    final y = _calculateYForDisplayArea(offsetY, displayState.value, index);
    final clampedX = clamp(x, 0, maxWidth).toInt();
    final clampedY = clamp(y, 0, maxHeight).toInt();

    displayState.value = displayState.value.copyWith(
      offset: DisplayOffset(clampedX, clampedY),
    );
    syncConfigWithDisplays();
  }

  void changeConfigurationDirectory(String value) {
    configDirectory.value = value;
    ConfigurationRepository.configurationDirectory = value;
  }

  void saveConfigurations() async {
    await ConfigurationRepository.saveConfigurations(
      configurations.value.map((key, value) => MapEntry(key, value.value)),
      configDirectory.value,
    );
  }

  num clamp(num val, num low, num high) {
    return val < low
        ? low
        : val > high
            ? high
            : val;
  }

  int _calculateXForDisplayArea(
    double x,
    Display display,
    int index,
  ) {
    if (x < 0) return 0;

    var width = display.resolution.width ~/ aspectRatio.value;
    if (x + width > maxWidth) {
      return maxWidth - width;
    }

    final leftMeetsRight = _getLeftMeetsRightNeighbor(x, index, display);
    if (leftMeetsRight != null) {
      return leftMeetsRight.offset.x +
          leftMeetsRight.resolution.width ~/ aspectRatio.value;
    }

    final leftMeetsLeft = _getLeftMeetsLeftNeighbor(x, index, display);
    if (leftMeetsLeft != null) {
      return leftMeetsLeft.offset.x;
    }

    final rightMeetsLeft = _getRightMeetsLeftNeighbor(x, index, display);
    if (rightMeetsLeft != null) {
      return rightMeetsLeft.offset.x -
          display.resolution.width ~/ aspectRatio.value;
    }

    final rightMeetsRight = _getRightMeetsRightNeighbor(x, index, display);
    if (rightMeetsRight != null) {
      return rightMeetsRight.offset.x -
          display.resolution.width ~/ aspectRatio.value +
          rightMeetsRight.resolution.width ~/ aspectRatio.value;
    }

    return x.toInt();
  }

  int _calculateYForDisplayArea(
    double y,
    Display display,
    int index,
  ) {
    if (y < 0) return 0;

    var height = display.resolution.height ~/ aspectRatio.value;
    if (y + height > maxHeight) {
      return maxHeight - height;
    }

    final topMeetsTop = _getTopMeetsTopNeighbor(y, index, display);
    if (topMeetsTop != null) {
      return topMeetsTop.offset.y;
    }

    final bottomMeetsTop = _getBottomMeetsTopNeighbor(y, index, display);
    if (bottomMeetsTop != null) {
      return (bottomMeetsTop.offset.y -
          display.resolution.height ~/ aspectRatio.value);
    }

    final bottomMeetsBottom = _getBottomMeetsBottomNeighbor(y, index, display);
    if (bottomMeetsBottom != null) {
      return bottomMeetsBottom.offset.y -
          display.resolution.height ~/ aspectRatio.value +
          bottomMeetsBottom.resolution.height ~/ aspectRatio.value;
    }

    final topMeetsBottom = _getTopMeetsBottomNeighbor(y, index, display);
    if (topMeetsBottom != null) {
      return topMeetsBottom.offset.y +
          topMeetsBottom.resolution.height ~/ aspectRatio.value;
    }

    return y.toInt();
  }

  // get the neighbor whose right edge meets the display's left edge
  Display? _getLeftMeetsRightNeighbor(
    double x,
    int index,
    Display display,
  ) {
    final index = displays.value.indexWhere((el) {
      if (el.value == display) return false;

      final width = el.value.resolution.width ~/ aspectRatio.value;
      final rightEdge = el.value.offset.x + width;
      return isInRange(x, rightEdge);
    });

    return index < 0 ? null : displays.value[index].value;
  }

  // get the neighbor whose left edge meets the display's left edge
  Display? _getLeftMeetsLeftNeighbor(
    double x,
    int index,
    Display display,
  ) {
    final index = displays.value.indexWhere((el) {
      if (el.value == display) return false;

      final leftEdge = el.value.offset.x;
      return isInRange(x, leftEdge);
    });

    return index < 0 ? null : displays.value[index].value;
  }

  // get the neighbor whose right edge meets the display's right edge
  Display? _getRightMeetsRightNeighbor(
    double x,
    int index,
    Display display,
  ) {
    final displayRightEdge = x + display.resolution.width / aspectRatio.value;
    final index = displays.value.indexWhere((el) {
      if (el.value == display) return false;

      final rightEdge =
          el.value.offset.x + el.value.resolution.width ~/ aspectRatio.value;
      return isInRange(displayRightEdge, rightEdge);
    });

    return index < 0 ? null : displays.value[index].value;
  }

  // get the neighbor whose left edge meets the display's right edge
  Display? _getRightMeetsLeftNeighbor(
    double x,
    int index,
    Display display,
  ) {
    final index = displays.value.indexWhere((el) {
      if (el.value == display) return false;

      final leftEdge = el.value.offset.x;
      return isInRange(
        x + display.resolution.width / aspectRatio.value,
        leftEdge,
      );
    });

    return index < 0 ? null : displays.value[index].value;
  }

  Display? _getTopMeetsTopNeighbor(
    double y,
    int index,
    Display display,
  ) {
    final index = displays.value.indexWhere((el) {
      if (el.value == display) return false;

      final topEdge = el.value.offset.y;
      return isInRange(y, topEdge);
    });

    return index < 0 ? null : displays.value[index].value;
  }

  Display? _getBottomMeetsTopNeighbor(
    double y,
    int index,
    Display display,
  ) {
    final index = displays.value.indexWhere((el) {
      if (el.value == display) return false;

      final topEdge = el.value.offset.y;
      return isInRange(
          y + display.resolution.height / aspectRatio.value, topEdge);
    });

    return index < 0 ? null : displays.value[index].value;
  }

  Display? _getBottomMeetsBottomNeighbor(
    double y,
    int index,
    Display display,
  ) {
    final index = displays.value.indexWhere((el) {
      if (el.value == display) return false;

      final bottomEdge =
          el.value.offset.y + el.value.resolution.height ~/ aspectRatio.value;
      return isInRange(
          y + display.resolution.height / aspectRatio.value, bottomEdge);
    });

    return index < 0 ? null : displays.value[index].value;
  }

  Display? _getTopMeetsBottomNeighbor(
    double y,
    int index,
    Display display,
  ) {
    final index = displays.value.indexWhere((el) {
      if (el.value == display) return false;

      final bottomEdge =
          el.value.offset.y + el.value.resolution.height ~/ aspectRatio.value;
      return isInRange(y, bottomEdge);
    });

    return index < 0 ? null : displays.value[index].value;
  }

  bool isInRange(double offset, int edge) =>
      offset < edge + wiggleRoom.value && offset > edge - wiggleRoom.value;

  int get maxWidth => displays.value.fold(
      0,
      (previousValue, element) =>
          previousValue + element.value.resolution.width ~/ aspectRatio.value);

  int get maxHeight => displays.value.fold(
      0,
      (previousValue, element) =>
          previousValue + element.value.resolution.height ~/ aspectRatio.value);
}
