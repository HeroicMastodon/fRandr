import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../displays/models.dart';

part 'state.freezed.dart';
part 'state.g.dart';

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default('') String configDirectory,
    @Default(25) int wiggleRoom,
    @Default(null) String? currentConfigurationHash,
    @Default(8) int aspectRatio,
}) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}

@freezed
class ReduxState with _$ReduxState {
  const ReduxState._();

  const factory ReduxState({
    // verticalScrollOffset
    // horizontalScrollOffset
    @Default(AppSettings()) AppSettings settings,
    @Default({}) Map<String, Configuration> configurations,
}) = _ReduxState;

  Configuration? get configuration =>
      settings.currentConfigurationHash != null ?
      configurations[settings.currentConfigurationHash] : null;

  Setup? get setup =>
      configuration?.setups[configuration?.selectedSetupId];

  List<Display> get displays => setup?.displays ?? [];

  factory ReduxState.fromJson(Map<String, dynamic> json) =>
      _$ReduxStateFromJson(json);
}
