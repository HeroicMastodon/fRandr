import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'actions.freezed.dart';

@freezed
class Actions with _$Actions {
  const factory Actions.moveDisplay({
    required int index,
    required String selectedHash,
    required DraggableDetails draggableDetails,
    required int xOffsetPadding,
    required int yOffsetPadding,
  }) = MoveDisplay;

  const factory Actions.loadConfiguration() = LoadConfiguration;

  const factory Actions.saveConfiguration() = SaveConfiguration;
}
