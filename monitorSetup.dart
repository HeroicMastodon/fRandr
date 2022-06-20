#!/usr/bin/dart

import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

main() async {
  var currentHash = await generateMonitorHash();

  await Timer.periodic(
    Duration(seconds: 5),
    (timer) async {
      print('polling');
      final polledHash = await generateMonitorHash();

      if (polledHash == currentHash) return;

      currentHash = polledHash;

      final configs = await fetchConfigs();

      if (!configs.containsKey(currentHash)) {
        configs[currentHash] = Config(setup: '', monitors: []);
        await saveConfig(configs);
      }

      var config = configs[currentHash];

      if (config == null) return;

      if (config.setup.trim().isEmpty) {
        print('no config for current setup, using default');
        config = configs['default'];
      }

      if (config == null || config.setup.trim().isEmpty) {
        print('no default config found');
        throw Error();
      }

      configureMonitors(config);
    },
  );
}

Future configureMonitors(Config config) async {
  print('configuring...');
  final result =
      await Process.run('sh', ['-c', config.setup], runInShell: true);

  if (result.exitCode != 0) {
    print(result.exitCode);
    print(result.stdout);
    print(result.stderr);
    return;
  }

  await configureNvidia();
  await Process.run('sh', ['-c', "echo 'awesome.restart()' | awesome-client"]);
  exit(0);
}

class Config {
  Config({required this.setup, required this.monitors}) {}

  late String setup;
  late List<String> monitors;

  Config.fromJson(Map<String, dynamic> json) {
    setup = json['setup'];
    monitors = json['monitors'].cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['setup'] = this.setup;
    data['monitors'] = this.monitors;
    return data;
  }
}

Future<String> generateMonitorHash() async {
  final result = (await Process.run(
    "sh",
    [
      '-c',
      'edid_hash=""; for DEVICE in /sys/class/drm/card*-*; do [ -e "\${DEVICE}/status" ] && grep -q "^connected\$" "\${DEVICE}/status" || continue; edid_hash="\${edid_hash}"\$(md5sum "\${DEVICE}/edid" | awk \'{print \$1}\'); done; echo \$(echo "\$edid_hash" | md5sum | awk \'{print \$1}\');'
    ],
  ));

  final hash = result.stdout.toString().trim();

  return hash;
}

Future<Map<String, Config>> fetchConfigs() async {
  final file = File('./monitors.json');
  final Map<String, dynamic> config = jsonDecode(await file.readAsString());

  final configs = <String, Config>{};

  config.forEach((key, value) {
    if (value is Map<String, dynamic>) configs[key] = Config.fromJson(value);
  });

  return configs;
}

Future saveConfig(Map<String, Config> configs) async {
  final file = File('./monitors.json');
  final data = jsonEncode(configs);
  await file.writeAsString(data);
}

Future configureNvidia() async {
  final currentMetaMode = await getCurrentMetaMode();
  print(currentMetaMode);
  currentMetaMode.forceCompositionPipeline();
  print(currentMetaMode);
  await saveMetaMode(currentMetaMode);
}

Future saveMetaMode(MetaMode metaMode) async {
  final result = await Process.run(
    'nvidia-settings',
    ['--assign', 'CurrentMetaMode=${metaMode.modeString()}'],
  );

  if (result.exitCode != 0) {
    print(result.exitCode);
    print(result.stdout);
    print(result.stderr);
  }
}

Future<MetaMode> getCurrentMetaMode() async {
  final metaModeResult = await Process.run(
    'nvidia-settings',
    ['-q', 'CurrentMetaMode'],
  );
  final output = metaModeResult.stdout.toString().trim();
  final split = output.split('::');

  return MetaMode(
    attribute: split[0],
    modes: split.skip(1).toList(),
  );
}

class MetaMode {
  MetaMode({
    required this.attribute,
    required this.modes,
  });

  String attribute;
  List<String> modes;

  @override
  String toString() {
    return "$attribute${modeString()}";
  }

  String modeString() {
    return "${modes.join()}";
  }

  void forceCompositionPipeline() {
    modes = modes
        .map(
          (mode) => mode.replaceAll(
            '{',
            '{ForceCompositionPipeline=On, ForceFullCompositionPipeline=On,',
          ),
        )
        .toList();
  }
}
