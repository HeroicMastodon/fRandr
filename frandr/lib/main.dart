import 'package:flutter/material.dart';
import 'package:frandr/app.dart';

import 'package:frandr/displays/displays_state.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// config directory /home/garrick/scripts/screens/frandr/lib/test_config.json


import 'displays/configuration_repository/configuration_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton(await SharedPreferences.getInstance());
  GetIt.instance.registerSingleton(await DisplaysState().initialize());
  runApp(App());
  // await ConfigurationHelper.getConnectedDisplays();
}
