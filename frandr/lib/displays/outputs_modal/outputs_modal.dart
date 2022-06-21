import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frandr/displays/displays_state.dart';
import 'package:frandr/displays/models.dart';
import 'package:get_it/get_it.dart';

class OutputsModal extends HookWidget {
  OutputsModal({
    super.key,
    required this.displayIndex,
  });

  final int displayIndex;
  final state = GetIt.I.get<DisplaysState>();

  @override
  Widget build(BuildContext context) {
    final display = useValueListenable(state.displays[displayIndex]);
    var numberFormatters = [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
    ];
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Display Name"),
                    initialValue: display.name,
                    onChanged: (value) =>
                        state.changeDisplayName(displayIndex, value),
                  ),
                ),
                Text("- ${display.outputName ?? "unknown output name"}")
              ],
            ),
            // Primary
            // Refresh Rate
            Row(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: display.primary,
                      onChanged: (value) => state.changeDisplayIsPrimary(
                          displayIndex, value ?? display.primary),
                    ),
                    const Text('Primary')
                  ],
                ),
                // Active
                Row(
                  children: [
                    Checkbox(
                      value: display.active,
                      onChanged: (value) => state.changeDisplayIsActive(
                          displayIndex, value ?? display.active),
                    ),
                    const Text('Active'),
                  ],
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 128,
                  child: DropdownButtonFormField<DisplayOrientation>(
                    value: display.orientation,
                    decoration: const InputDecoration(labelText: 'Orientation'),
                    items: const [
                      DropdownMenuItem(
                        value: NormalOrientation(),
                        child: Text('Normal'),
                      ),
                      DropdownMenuItem(
                        value: TurnedRight(),
                        child: Text('Turned Right'),
                      ),
                      DropdownMenuItem(
                        value: InvertedOrientation(),
                        child: Text('Inverted'),
                      ),
                      DropdownMenuItem(
                        value: TurnedLeft(),
                        child: Text('Turned Left'),
                      ),
                    ],
                    onChanged: (value) => state.changeDisplayOrientation(
                        displayIndex, value ?? const NormalOrientation()),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    children: [
                      SizedBox(
                        width: 104,
                        child: TextFormField(
                          onChanged: (value) {
                            final numberVal = double.parse(value);
                            state.changeDisplayRefresh(displayIndex, numberVal);
                          },
                          decoration:
                              const InputDecoration(labelText: 'Refresh Rate'),
                          initialValue: display.refreshRate.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[0-9]*(\.[0-9]{0,2})?'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Resolution
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Resolution'),
                const SizedBox(width: 16),
                SizedBox(
                  width: 96,
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Width'),
                    initialValue: display.resolution.width.toString(),
                    onChanged: (value) {},
                    inputFormatters: numberFormatters,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(' X '),
                ),
                SizedBox(
                  width: 96,
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Height'),
                    initialValue: display.resolution.height.toString(),
                    onChanged: (value) {},
                    inputFormatters: numberFormatters,
                  ),
                ),
              ],
            ),
            // Offset
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Offset'),
                const SizedBox(width: 16),
                SizedBox(
                  width: 96,
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'horizontal'),
                    initialValue: display.offset.x.toString(),
                    onChanged: (value) {},
                    inputFormatters: numberFormatters,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(' X '),
                ),
                SizedBox(
                  width: 96,
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'vertical'),
                    initialValue: display.offset.x.toString(),
                    onChanged: (value) {},
                    inputFormatters: numberFormatters,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future showOutputsModal(BuildContext context, int displayIndex) {
  return showDialog(
      context: context,
      builder: (context) {
        return OutputsModal(displayIndex: displayIndex);
      });
}
