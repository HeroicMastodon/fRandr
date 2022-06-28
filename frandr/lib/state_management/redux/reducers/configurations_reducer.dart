import 'package:frandr/displays/models.dart';
import 'package:frandr/state_management/redux/helpers/calculate_coordinates.dart';
import 'package:frandr/state_management/redux/reducers/actions.dart';
import 'package:redux/redux.dart';

final configurationsReducer =
    TypedReducer<Map<String, Configuration>, Actions>(_reducer);

Map<String, Configuration> _reducer(
    Map<String, Configuration> configurations, Actions action) {
  return action.maybeWhen(
    orElse: () => configurations,
    initializeState: (settings, newConfigurations) {
      return newConfigurations;
    },
    moveDisplay: (
      setup,
      configuration,
      display,
      draggableDetails,
      xPadding,
      yPadding,
      aspectRatio,
      wiggleRoom,
    ) =>
        configurations.map(
      (key, config) {
        if (config != configuration) return MapEntry(key, config);

        final xOffset = (xPadding + draggableDetails.offset.dx) * aspectRatio;
        final yOffset = (yPadding + draggableDetails.offset.dy) * aspectRatio;

        // calculate new offset
        final offset = calculateDisplayCoordinates(
          xOffset,
          yOffset,
          display,
          setup,
          wiggleRoom,
        );

        final displays = setup.displays
            .map(
              (e) => e == display ? display.copyWith(offset: offset) : display,
            )
            .toList();

        return MapEntry(
          key,
          config.copyWith(
            setups: config.setups.map(
              (key, value) => value.id == config.selectedSetupId
                  ? MapEntry(key, value.copyWith(displays: displays))
                  : MapEntry(key, value),
            ),
          ),
        );
      },
    ),
    setDisplayIsActive: (isActive, setup, configuration, display) {
      return configurations;
    },
    setDisplayIsPrimary: (isPrimary, setup, configuration, display) {
      return configurations;
    },
    setDisplayOffset: (offset, setup, configuration, display) {
      return configurations;
    },
    setDisplayOrientation: (orientation, setup, configuration, display) {
      return configurations;
    },
    setDisplayRefresh: (refreshRate, setup, configuration, display) {
      return configurations;
    },
    setDisplayResolution: (resolution, setup, configuration, display) {
      return configurations;
    },
  );
}
