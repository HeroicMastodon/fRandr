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
    final ratio = useValueListenable(state.aspectRatio);

    return MaterialApp(
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
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: const BorderRadius.all(Radius.circular(4))
                  ),
                  padding: const EdgeInsets.all(4),
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
                  decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: const BorderRadius.all(Radius.circular(4))
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Text("Aspect Ratio"),
                ),
                onSelected: (value) {
                  state.updateAspectRatio(value);
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        value: 4,
                        child: Row(
                          children: [
                            Radio(
                              value: 4,
                              groupValue: ratio,
                              onChanged: (value) {},
                            ),
                            const Text("1:4"),
                          ],
                        )),
                    PopupMenuItem(
                        value: 8,
                        child: Row(
                          children: [
                            Radio(
                              value: 8,
                              groupValue: ratio,
                              onChanged: (value) {},
                            ),
                            const Text("1:8"),
                          ],
                        )),
                    PopupMenuItem(
                        value: 16,
                        child: Row(
                          children: [
                            Radio(
                              value: 16,
                              groupValue: ratio,
                              onChanged: (value) {},
                            ),
                            const Text("1:16"),
                          ],
                        )),
                  ];
                },
              ),
              Tooltip(
                message: "Edit Configuration",
                child: IconButton(
                  onPressed: () {
                    print("edit configuration");
                  },
                  icon: const Icon(Icons.settings),
                ),
              ),
              Tooltip(
                message: "Save Configuration",
                child: IconButton(
                  onPressed: () {
                    print("save configuration");
                  },
                  icon: const Icon(Icons.save),
                ),
              ),
              const Tooltip(
                message: "Apply current configuration",
                child: IconButton(
                  onPressed: null,
                  icon: const Icon(Icons.check_circle_outline),
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
