import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frandr/displays/displays_state.dart';
import 'package:get_it/get_it.dart';

import 'models.dart';

class DisplaysWidget extends HookWidget {
  DisplaysWidget({super.key});

  final state = GetIt.instance.get<DisplaysState>();

  verticalScrollListener(ScrollController controller) => () {
    state.verticalScrollOffset = controller.offset;
  };

  horizontalScrollListener(ScrollController controller) => () {
    state.horizontalScrollOffset = controller.offset;
  };

  @override
  Widget build(BuildContext context) {
    print(jsonEncode(state.displays.first.value));
    final displays = state.displays;
    double width = state.maxWidth;
    double height = state.maxHeight;
    final verticalScroll = useScrollController();
    final horizontalScroll = useScrollController();
    useEffect(() {
      verticalScroll.addListener(verticalScrollListener(verticalScroll));
      horizontalScroll.addListener(horizontalScrollListener(horizontalScroll));

      return () {
        verticalScroll.removeListener(verticalScrollListener(verticalScroll));
        horizontalScroll.removeListener(horizontalScrollListener(horizontalScroll));
      };
    });

    return Scrollbar(
      controller: verticalScroll,
      trackVisibility: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: verticalScroll,
        child: Scrollbar(
          controller: horizontalScroll,
          trackVisibility: true,
          child: SingleChildScrollView(
            controller: horizontalScroll,
            scrollDirection: Axis.horizontal,
            child: Container(
              width: width,
              height: height,
              color: Colors.grey,
              child: Stack(
                children: displays
                    .asMap()
                    .map(
                      (key, value) => MapEntry(
                        key,
                        DisplayWidget(
                          state: state,
                          index: key,
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayWidget extends HookWidget {
  const DisplayWidget({
    super.key,
    required this.state,
    required this.index,
  });

  final DisplaysState state;
  final int index;

  @override
  Widget build(BuildContext context) {
    final display = useValueListenable(state.displays[index]);
    final ratio = useValueListenable(state.aspectRatio);
    return Positioned(
      left: display.offset.x,
      top: display.offset.y,
      child: Draggable(
        feedback: child(context, display, ratio),
        onDragEnd: (details) {
          state.updateDisplayCoordinates(details, index);
        },
        childWhenDragging: const SizedBox.shrink(),
        child: child(context, display, ratio),
      ),
    );
  }

  Widget child(BuildContext context, Display display, int ratio) {
    return Container(
      width: display.resolution.width / ratio,
      height: display.resolution.height / ratio,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
      ),
    );
  }
}