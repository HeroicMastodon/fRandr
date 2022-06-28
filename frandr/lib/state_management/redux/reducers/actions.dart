import 'package:flutter/material.dart';
import 'package:frandr/displays/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../state/state.dart';

part 'actions.freezed.dart';

@freezed
class Actions with _$Actions {
  const factory Actions.moveDisplay({
    required Setup setup,
    required Configuration configuration,
    required Display display,
    required DraggableDetails draggableDetails,
    required int xOffsetPadding,
    required int yOffsetPadding,
    required int aspectRatio,
    required int wiggleRoom,
  }) = MoveDisplay;

  const factory Actions.initialize() = Initialize;

  const factory Actions.initializeState({
    required AppSettings settings,
    required Map<String, Configuration> configurations,
}) = InitializeState;

  const factory Actions.loadConfiguration() = LoadConfiguration;

  const factory Actions.saveConfiguration() = SaveConfiguration;

  const factory Actions.setDisplayIsPrimary({
    required bool isPrimary,
    required Setup setup,
    required Configuration configuration,
    required Display display,
  }) = SetDisplayIsPrimary;

  const factory Actions.setDisplayIsActive({
    required bool isActive,
    required Setup setup,
    required Configuration configuration,
    required Display display,
  }) = SetDisplayIsActive;

  const factory Actions.setDisplayOrientation({
    required DisplayOrientation orientation,
    required Setup setup,
    required Configuration configuration,
    required Display display,
  }) = SetDisplayOrientation;

  const factory Actions.setDisplayRefresh({
    required double refreshRate,
    required Setup setup,
    required Configuration configuration,
    required Display display,
  }) = SetDisplayRefresh;

  const factory Actions.setDisplayResolution({
    required Resolution resolution,
    required Setup setup,
    required Configuration configuration,
    required Display display,
  }) = SetDisplayResolution;

  const factory Actions.setDisplayOffset({
    required DisplayOffset offset,
    required Setup setup,
    required Configuration configuration,
    required Display display,
  }) = SetDisplayOffset;

  const factory Actions.setAspectRatio(int aspectRatio) = SetAspectRatio;

  const factory Actions.setConfigurationDirectory(
    String directory,
  ) = SetConfigurationDirectory;
}
