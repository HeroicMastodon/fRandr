import 'dart:convert';
import 'dart:io';

import '../models.dart';

class ConfigurationRepository {
  static Future<Map<String, Configuration>> loadConfigurations(
    String configDir,
  ) async {
    final file = File(configDir);
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

class ConfigurationHelper {
  static Future<String> generateCurrentConfigurationHash() async {
    final result = await Process.run(
      'sh',
      [
        '-c',
        'edid_hash=""; for DEVICE in /sys/class/drm/card*-*; do [ -e "\${DEVICE}/status" ] && grep -q "^connected\$" "\${DEVICE}/status" || continue; edid_hash="\${edid_hash}"\$(md5sum "\${DEVICE}/edid" | awk \'{print \$1}\'); done; echo \$(echo "\$edid_hash" | md5sum | awk \'{print \$1}\');',
      ],
    );
    final hash = result.stdout.toString().trim();
    return hash;
  }
}
