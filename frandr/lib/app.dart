import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frandr/displays/displays_widget.dart';
import 'package:get_it/get_it.dart';

import 'displays/displays_state.dart';

class App extends HookWidget {
  App({super.key});

  final state = GetIt.I.get<DisplaysState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(toggleableActiveColor: Colors.blue),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(29, 29, 29, 1.0),
        appBar: AppBar(
          title: Row(
            children: [
              PopupMenuButton<int>(
                onSelected: (value) {
                  print("open display at index: $value");
                },
                tooltip: "Edit output options",
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(8),
                  child: const Text("Outputs"),
                ),
                itemBuilder: (context) {
                  final items = <PopupMenuItem<int>>[];
                  state.displays.asMap().forEach((index, display) {
                    items.add(
                      PopupMenuItem(
                        value: index,
                        child: Text(display.value.name ?? "unknown"),
                      ),
                    );
                  });
                  return items;
                },
              ),
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
              Tooltip(
                message: "Edit Configuration",
                child: IconButton(
                  splashRadius: 24,
                  onPressed: () {
                    print("edit configuration");
                  },
                  icon: const Icon(Icons.settings),
                ),
              ),
              Tooltip(
                message: "Save Configuration",
                child: IconButton(
                  splashRadius: 24,
                  onPressed: () {
                    print("save configuration");
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
              )
            ],
          ),
        ),
        body: DisplaysWidget(),
      ),
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
