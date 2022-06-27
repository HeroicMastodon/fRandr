import 'package:frandr/displays/models.dart';
import 'package:frandr/state_management/redux/reducers/actions.dart';
import 'package:redux/redux.dart';

final configurationsReducer =
TypedReducer<Map<String, Configuration>, Actions>(_reducer);

Map<String, Configuration> _reducer(Map<String, Configuration> configurations,
    Actions action) {
  return action.maybeWhen(
    orElse: () => configurations,
    moveDisplay: (index,
        selectedHash,
        draggableDetails,
        xPadding,
        yPadding,) =>
        configurations.map((key, config) {
          // check for current setup and skip if not selected config
          final setup = config.setups[config.selectedSetupId];
          if (setup == null) return MapEntry(key, config);

          // calculate new offset
          final offset = DisplayOffset(0, 0);

          final displays = [for (var i = 0; i < setup.displays.length; i++)
            if (i != index) setup.displays[i]
            else setup.displays[i].copyWith(offset: offset)
          ];

          return MapEntry(
            key,
            config.copyWith(
              setups: config.setups.map(
                    (key, value) =>
                value.id == config.selectedSetupId
                    ? MapEntry(key, value.copyWith(displays: displays))
                    : MapEntry(key, value),
              ),
            ),
          );
        }),
  );
}
