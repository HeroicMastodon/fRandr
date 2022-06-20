#!/usr/bin/dart

import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';

class Arguments {
  int pauseDuration = 2;
  bool configureOnStart = true;
  bool forceCompositionPipeline = true;
  bool killOnConfigure = true;
  String configPath = "./monitors.json";
}

const pauseDurationArg = 'pause-duration';
const configureOnStartArg = 'configure-on-start';
const forceFullCompositionPipelineArg = 'force-composition-pipeline';
const killOnConfigureArg = 'kill-on-configure-arg';
const pathToConfigsArg = 'path-to-configs';

String getArgValue(ArgResults results, String name, String abbr) {
  var index = results.arguments.indexOf("--$name");
  if (index < 0) {
    index = results.arguments.indexOf("-$abbr");

    if (index < 0) {
      throw Error();
    }
  }
  return results.arguments[index + 1];
}

Arguments getArguments(List<String> args) {
  var parser = ArgParser();
  parser
    ..addOption(pauseDurationArg, abbr: 'p')
    ..addOption(configureOnStartArg, abbr: 's')
    ..addOption(forceFullCompositionPipelineArg, abbr: 'c')
    ..addOption(killOnConfigureArg, abbr: 'k')
    ..addOption(pathToConfigsArg, abbr: 'i');
  var results = parser.parse(args);
  var arguments = Arguments();
  print(results.arguments);

  if (results.wasParsed(pauseDurationArg)) {
    var value = getArgValue(results, pauseDurationArg, "p");
    arguments.pauseDuration = int.parse(value);
  }
  if (results.wasParsed(configureOnStartArg)) {
    var value = getArgValue(results, configureOnStartArg, "s");
    arguments.configureOnStart = value == 'false';
  }
  if (results.wasParsed(forceFullCompositionPipelineArg)) {
    var value = getArgValue(results, forceFullCompositionPipelineArg, "c");
    arguments.forceCompositionPipeline = value == 'false';
  }
  if (results.wasParsed(killOnConfigureArg)) {
    var value = getArgValue(results, killOnConfigureArg, "k");
    arguments.killOnConfigure = value == 'false';
  }
  if (results.wasParsed(pathToConfigsArg)) {
    var value = getArgValue(results, pathToConfigsArg, 'i');
    arguments.configPath = value;
  }

  return arguments;
}

Arguments arguments = Arguments();

Future configure(String hash, [bool kill = false]) async {
  final configs = await fetchConfigs();

  if (!configs.containsKey(hash)) {
    configs[hash] = Config(setup: '', monitors: []);
    await saveConfig(configs);
  }

  var config = configs[hash];

  if (config == null) return;

  if (config.setup.trim().isEmpty) {
    print('no config for current setup, using default');
    config = configs['default'];
  }

  if (config == null || config.setup.trim().isEmpty) {
    print('no default config found');
    throw Error();
  }

  configureMonitors(config, kill);
}

Future killIfNecessary() async {
  final pids = (await Process.run('sh', ['-c', 'ps -e | grep dart:mon']))
      .stdout
      .toString()
      .trim()
      .split("\n");

  if (pids.length > 1) {
    exit(0);
  }
}

main(List<String> args) async {
  killIfNecessary();
  arguments = getArguments(args);
  var currentHash = await generateMonitorHash();

  configure(currentHash);

  Timer.periodic(
    Duration(seconds: arguments.pauseDuration),
    (timer) async {
      print('polling');
      final polledHash = await generateMonitorHash();

      if (polledHash == currentHash) return;

      currentHash = polledHash;

      configure(currentHash);
      await Process.run(
          'sh', ['-c', "echo 'awesome.restart()' | awesome-client"],
          runInShell: true);
    },
  );
}

Future configureMonitors(Config config, [bool kill = false]) async {
  print('configuring...');
  final result =
      await Process.run('sh', ['-c', config.setup], runInShell: true);

  if (result.exitCode != 0) {
    print(result.exitCode);
    print(result.stdout);
    print(result.stderr);
    return;
  }

  if (arguments.forceCompositionPipeline) {
    await configureNvidia();
  }
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
  final file = File(arguments.configPath);
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
