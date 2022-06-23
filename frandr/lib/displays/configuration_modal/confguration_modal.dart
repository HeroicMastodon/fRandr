import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frandr/displays/displays_state.dart';
import 'package:get_it/get_it.dart';

class ConfigurationModal extends HookWidget {
  ConfigurationModal({super.key});

  final state = GetIt.instance.get<DisplaysState>();

  @override
  Widget build(BuildContext context) {
    final activeConfigId = useState('');
    final configs = useValueListenable(state.configurations);
    final configDir = useValueListenable(state.configDirectory);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Configuration Directory',
                    ),
                    initialValue: configDir,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    for (final id in configs.keys)
                      GestureDetector(
                        onTap: () => activeConfigId.value = id,
                        child: Container(
                          decoration: BoxDecoration(
                              border: id == activeConfigId.value
                                  ? const Border(
                                      bottom: BorderSide(color: Colors.blue),
                                    )
                                  : null),
                          child: Text(configs[id]?.value.name ?? id),
                        ),
                      ),
                  ],
                ),
                ConfigurationView(activeConfigId.value),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ConfigurationView extends HookWidget {
  ConfigurationView(this.id, {super.key});

  final String id;
  final state = GetIt.instance.get<DisplaysState>();

  @override
  Widget build(BuildContext context) {
    final config = useValueListenable(
      state.configurations.value[id] ??
          ValueNotifier(
            null,
          ),
    );

    return config == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      initialValue: config.name,
                      onChanged: (value) {},
                    ),
                  ),
                  Text(' - $id'),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Selected Setup Command',
                      ),
                      initialValue: config.setup,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              for (final setup in config.setups.values)
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                ),
                                initialValue: setup.name,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'setup command',
                                ),
                                initialValue: setup.name,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
  }
}

showConfigurationModal(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => ConfigurationModal(),
  );
}
