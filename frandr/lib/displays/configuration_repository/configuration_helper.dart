import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4;

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

  static Future<Map<String, bool>> getConnectedDisplays() async {
    final result = (await Process.run('xrandr', ['-q'])).stdout.toString();
    final lines = result.split('\n').skip(1).toList();

    for (var i = 0; i < lines.length; i++) {
      lines[i] = lines[i].trimRight();
    }

    final displayLines = lines
        .where((element) =>
            !element.startsWith(' ') &&
            !element.startsWith('\t') &&
            !element.startsWith('\n'))
        .toList();

    final displaySplit = displayLines.map((e) => e.split(' ')).where((e) => e.isNotEmpty);

    final displayMap = <String, bool>{};
    for (var display in displaySplit) {
      print(display);
      displayMap[display[0]] = display[1] == 'connected';
    }

    print(displayMap);

    return displayMap;
  }
}
