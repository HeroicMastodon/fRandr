import 'package:flutter/material.dart';
import 'package:frandr/app.dart';

import 'package:frandr/displays/displays_state.dart';
import 'package:frandr/displays/models.dart';
import 'package:frandr/state_management/redux/middleware/configuration_middleware.dart';
import 'package:frandr/state_management/redux/reducers/actions.dart';
import 'package:frandr/state_management/redux/reducers/app_reducer.dart';
import 'package:frandr/state_management/redux/state/state.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

// config directory /home/garrick/scripts/screens/frandr/lib/test_config.json

import 'displays/configuration_repository/configuration_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton(await SharedPreferences.getInstance());
  GetIt.instance.registerSingleton(await DisplaysState().initialize());
  // runApp(App());
  // await ConfigurationHelper.getConnectedDisplays();

  final store = Store<ReduxState>(
    appReducer,
    middleware: [...configurationMiddleware()],
    initialState: const ReduxState(
      settings: AppSettings(
        currentConfigurationHash: "Default",
      ),
      configurations: {
        "Default": Configuration(
          selectedSetupId: "1",
          configHash: "1",
          setups: {
            "1": Setup(
              id: "1",
              displays: [
                Display(resolution: Resolution(3440, 1440)),
                Display(resolution: Resolution(2560, 1440)),
              ],
            ),
          },
        ),
      },
    ),
  );

  print(store.state);
  print(store.state.displays);
  print(store.state.configuration);
  print(store.state.setup);


  store.dispatch(
    MoveDisplay(
      setup: store.state.setup ?? const Setup(id: "2"),
      draggableDetails: DraggableDetails(
        offset: const Offset(10, 10),
        velocity: const Velocity(
          pixelsPerSecond: Offset(0, 0),
        ),
      ),
      xOffsetPadding: 0,
      yOffsetPadding: 10,
      aspectRatio: 4,
      wiggleRoom: 25,
      configuration: store.state.configuration ?? const Configuration(),
      display: store.state.displays[0],
    ),
  );

  print(store.state);
  store.dispatch(const SaveConfiguration());
}
