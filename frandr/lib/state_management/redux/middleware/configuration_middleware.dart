import 'package:frandr/displays/configuration_repository/configuration_repository.dart';
import 'package:frandr/state_management/redux/state/state.dart';
import 'package:redux/redux.dart';

import '../reducers/actions.dart';

List<Middleware<ReduxState>> configurationMiddleware() {
  return [
    TypedMiddleware<ReduxState, SaveConfiguration>(_saveConfiguration),
    TypedMiddleware<ReduxState, LoadConfiguration>(_loadConfiguration),
    TypedMiddleware<ReduxState, Initialize>(_initialize),
  ];
}

void _initialize(
  Store<ReduxState> store,
  Initialize action,
  NextDispatcher next,
) async {
  final configDirectory = store.state.settings.configDirectory.isEmpty
      ? ConfigurationRepository.configurationDirectory
      : store.state.settings.configDirectory;
  if (configDirectory.isEmpty) return;

  final configurations =
      await ConfigurationRepository.loadConfigurations(configDirectory);
  final settings = AppSettings(configDirectory: configDirectory);

  store.dispatch(InitializeState(
    settings: settings,
    configurations: configurations,
  ));
}

void _saveConfiguration(
  Store<ReduxState> store,
  SaveConfiguration action,
  NextDispatcher next,
) {}

void _loadConfiguration(
  Store<ReduxState> store,
  LoadConfiguration action,
  NextDispatcher next,
) async {
  final configurations = await ConfigurationRepository.loadConfigurations(
    store.state.settings.configDirectory,
  );

  store.dispatch(InitializeState(
    settings: store.state.settings,
    configurations: configurations,
  ));
}
