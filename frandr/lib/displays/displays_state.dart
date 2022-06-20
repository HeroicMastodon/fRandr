import 'package:flutter/material.dart';

import 'models.dart';

class DisplaysState {
  final displays = <ValueNotifier<Display>>[
    ValueNotifier(const Display(
      resolution: Resolution(3440, 1440),
      offset: DisplayOffset(0, 0),
    )),
    ValueNotifier(const Display(
      resolution: Resolution(2560, 1440),
      offset: DisplayOffset(0, 0),
    )),
    ValueNotifier(const Display(
      resolution: Resolution(1440, 2560),
      offset: DisplayOffset(0, 0),
    )),
  ];
  final aspectRatio = ValueNotifier(8);
  final configDirectory = ValueNotifier("");
  final wiggleRoom = ValueNotifier(25);
  double verticalScrollOffset = 0;
  double horizontalScrollOffset = 0;

  void updateAspectRatio(int value) {
    for (var display in displays) {
      final offset = display.value.offset;
      final x = offset.x;
      final y = offset.y;
      display.value = display.value.copyWith.offset(
        x: x * aspectRatio.value ~/ value,
        y: y * aspectRatio.value ~/ value,
      );
    }
    aspectRatio.value = value;
  }

  void updateDisplayCoordinates(DraggableDetails draggableDetails, int index) {
    final displayState = displays.elementAt(index);
    var offsetX = draggableDetails.offset.dx + horizontalScrollOffset;
    final offsetY = draggableDetails.offset.dy - kToolbarHeight +
        verticalScrollOffset;

    final x =
    _calculateXForDisplayArea(offsetX, displayState.value, index);
    final y =
    _calculateYForDisplayArea(offsetY, displayState.value, index);
    final clampedX = clamp(x, 0, maxWidth).toInt();
    final clampedY = clamp(y, 0, maxHeight).toInt();

    displayState.value = displayState.value.copyWith(
      offset: DisplayOffset(clampedX, clampedY),
    );
  }

  num clamp(num val, num low, num high) {
    return val < low
        ? low
        : val > high
        ? high
        : val;
  }

  int _calculateXForDisplayArea(double x,
      Display display,
      int index,) {
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

  int _calculateYForDisplayArea(double y,
      Display display,
      int index,) {
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
  Display? _getLeftMeetsRightNeighbor(double x,
      int index,
      Display display,) {
    final index = displays.indexWhere((el) {
      if (el.value == display) return false;

      final width = el.value.resolution.width ~/ aspectRatio.value;
      final rightEdge = el.value.offset.x + width;
      return isInRange(x, rightEdge);
    });

    return index < 0 ? null : displays[index].value;
  }

  // get the neighbor whose left edge meets the display's left edge
  Display? _getLeftMeetsLeftNeighbor(double x,
      int index,
      Display display,) {
    final index = displays.indexWhere((el) {
      if (el.value == display) return false;

      final leftEdge = el.value.offset.x;
      return isInRange(x, leftEdge);
    });

    return index < 0 ? null : displays[index].value;
  }

  // get the neighbor whose right edge meets the display's right edge
  Display? _getRightMeetsRightNeighbor(double x,
      int index,
      Display display,) {
    final displayRightEdge = x + display.resolution.width / aspectRatio.value;
    final index = displays.indexWhere((el) {
      if (el.value == display) return false;

      final rightEdge =
          el.value.offset.x + el.value.resolution.width ~/ aspectRatio.value;
      return isInRange(displayRightEdge, rightEdge);
    });

    return index < 0 ? null : displays[index].value;
  }

  // get the neighbor whose left edge meets the display's right edge
  Display? _getRightMeetsLeftNeighbor(double x,
      int index,
      Display display,) {
    final index = displays.indexWhere((el) {
      if (el.value == display) return false;

      final leftEdge = el.value.offset.x;
      return isInRange(
        x + display.resolution.width / aspectRatio.value,
        leftEdge,
      );
    });

    return index < 0 ? null : displays[index].value;
  }

  Display? _getTopMeetsTopNeighbor(double y,
      int index,
      Display display,) {
    final index = displays.indexWhere((el) {
      if (el.value == display) return false;

      final topEdge = el.value.offset.y;
      return isInRange(y, topEdge);
    });

    return index < 0 ? null : displays[index].value;
  }

  Display? _getBottomMeetsTopNeighbor(double y,
      int index,
      Display display,) {
    final index = displays.indexWhere((el) {
      if (el.value == display) return false;

      final topEdge = el.value.offset.y;
      return isInRange(
          y + display.resolution.height / aspectRatio.value, topEdge);
    });

    return index < 0 ? null : displays[index].value;
  }

  Display? _getBottomMeetsBottomNeighbor(double y,
      int index,
      Display display,) {
    final index = displays.indexWhere((el) {
      if (el.value == display) return false;

      final bottomEdge =
          el.value.offset.y + el.value.resolution.height ~/ aspectRatio.value;
      return isInRange(
          y + display.resolution.height / aspectRatio.value, bottomEdge);
    });

    return index < 0 ? null : displays[index].value;
  }

  Display? _getTopMeetsBottomNeighbor(double y,
      int index,
      Display display,) {
    final index = displays.indexWhere((el) {
      if (el.value == display) return false;

      final bottomEdge =
          el.value.offset.y + el.value.resolution.height ~/ aspectRatio.value;
      return isInRange(y, bottomEdge);
    });

    return index < 0 ? null : displays[index].value;
  }

  bool isInRange(double offset, int edge) =>
      offset < edge + wiggleRoom.value && offset > edge - wiggleRoom.value;

  int get maxWidth =>
      displays.fold(
          0,
              (previousValue, element) =>
          previousValue + element.value.resolution.width ~/ aspectRatio.value);

  int get maxHeight =>
      displays.fold(
          0,
              (previousValue, element) =>
          previousValue + element.value.resolution.height ~/ aspectRatio.value);
}
