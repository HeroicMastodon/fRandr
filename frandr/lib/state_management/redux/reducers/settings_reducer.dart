import 'package:frandr/state_management/redux/reducers/actions.dart';
import 'package:frandr/state_management/redux/state/state.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

final settingsReducer = TypedReducer<AppSettings, Actions>(_reducer);

AppSettings _reducer(AppSettings settings, Actions action) {
  return action.maybeWhen(
    orElse: () => settings,
    initializeState: (newSettings, _) => newSettings,
    setAspectRatio: (aspectRatio) => settings.copyWith(
      aspectRatio: aspectRatio,
    ),
    setConfigurationDirectory: (directory) => settings.copyWith(
      configDirectory: directory,
    ),
  );
}
