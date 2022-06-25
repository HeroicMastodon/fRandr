import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models.dart';

class ConfigurationRepository {
  static final _sharedPrefs = GetIt.instance.get<SharedPreferences>();
  static const _configDirKey = 'configuration_directory';

  static set configurationDirectory(String value) =>
      _sharedPrefs.setString(_configDirKey, value);

  static String get configurationDirectory =>
      _sharedPrefs.getString(_configDirKey) ?? '';

  static Future<Map<String, Configuration>> loadConfigurations(
    String configDir,
  ) async {
    final file = File(configDir);

    if (!(await file.exists())) {
      return {};
    }

    final Map<String, dynamic> json = jsonDecode(await file.readAsString());
    final configs =
        json.map((key, value) => MapEntry(key, Configuration.fromJson(value)));

    return configs;
  }

  static Future saveConfigurations(
    Map<String, Configuration> configurations,
    String configDir,
  ) async {
    final file = File(configDir);
    final data = jsonEncode(configurations);
    await file.writeAsString(data);
  }
}


