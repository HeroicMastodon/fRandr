import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frandr/displays/configuration_modal/confguration_modal.dart';
import 'package:frandr/displays/configuration_repository/configuration_repository.dart';
import 'package:frandr/displays/displays_widget.dart';
import 'package:get_it/get_it.dart';

import 'displays/displays_state.dart';
import 'displays/outputs_modal/outputs_modal.dart';

class App extends HookWidget {
  App({super.key});

  final state = GetIt.I.get<DisplaysState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        toggleableActiveColor: Colors.blue,
        checkboxTheme: CheckboxThemeData(
          shape: CircleBorder()
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(29, 29, 29, 1.0),
        appBar: AppBar(
          title: Row(
            children: [
              OutputPopupButton(state: state),
              const SizedBox(
                width: 8,
              ),
              PopupMenuButton<int>(
                tooltip: "Change the aspect ratio of the editor",
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Text("Aspect Ratio"),
                ),
                onSelected: (value) {
                  state.updateAspectRatio(value);
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 4,
                      child: RatioPopupItem(4),
                    ),
                    PopupMenuItem(
                      value: 8,
                      child: RatioPopupItem(8),
                    ),
                    PopupMenuItem(
                      value: 16,
                      child: RatioPopupItem(16),
                    ),
                  ];
                },
              ),
              const ConfigurationButton(),
              Tooltip(
                message: "Save Configuration",
                child: IconButton(
                  splashRadius: 24,
                  onPressed: () {
                    state.saveConfigurations();
                  },
                  icon: const Icon(Icons.save),
                ),
              ),
              const Tooltip(
                message: "Apply current configuration",
                child: IconButton(
                  splashRadius: 24,
                  onPressed: null,
                  icon: Icon(Icons.check_circle_outline),
                ),
              ),
              Tooltip(
                message: "Load configuration",
                child: IconButton(
                  splashRadius: 24,
                  onPressed: () => state.initialize(),
                  icon: const Icon(Icons.sync),
                ),
              )
            ],
          ),
        ),
        body: DisplaysWidget(),
      ),
    );
  }
}

class ConfigurationButton extends StatelessWidget {
  const ConfigurationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Edit Configuration",
      child: IconButton(
        splashRadius: 24,
        onPressed: () async {
          await showConfigurationModal(context);
        },
        icon: const Icon(Icons.settings),
      ),
    );
  }
}

class OutputPopupButton extends StatelessWidget {
  const OutputPopupButton({
    Key? key,
    required this.state,
  }) : super(key: key);

  final DisplaysState state;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (value) async {
        print("open display at index: $value");
        await showOutputsModal(context, value);
      },
      tooltip: "Edit output options",
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        padding: const EdgeInsets.all(8),
        child: const Text("Outputs"),
      ),
      itemBuilder: (context) {
        final items = <PopupMenuItem<int>>[];
        state.displays.value.asMap().forEach((index, display) {
          items.add(
            PopupMenuItem(
              enabled: display.value.connected,
              value: index,
              child: Text(display.value.name ?? display.value.outputName ?? "unknown"),
            ),
          );
        });
        return items;
      },
    );
  }
}

class RatioPopupItem extends HookWidget {
  RatioPopupItem(this.value, {super.key});

  final int value;
  final state = GetIt.instance.get<DisplaysState>();

  @override
  Widget build(BuildContext context) {
    final ratio = useValueListenable(state.aspectRatio);
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: ratio,
          onChanged: (value) {
            if (value == null) return;
            state.updateAspectRatio(value);
          },
        ),
        Text("1:$value"),
      ],
    );
  }
}
