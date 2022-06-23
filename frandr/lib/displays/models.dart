import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

part 'models.g.dart';

@freezed
class Display with _$Display {
  const factory Display({
    @Default(Resolution(0, 0)) Resolution resolution,
    @Default(DisplayOffset(0, 0)) DisplayOffset offset,
    String? name,
    String? outputName,
    @Default(false) bool active,
    @Default(false) bool primary,
    @Default(false) bool connected,
    @Default(60) double refreshRate,
    @Default(DisplayOrientation.normal()) DisplayOrientation orientation,
  }) = _Display;

  factory Display.fromJson(Map<String, dynamic> json) =>
      _$DisplayFromJson(json);
}

@freezed
class Resolution with _$Resolution {
  const factory Resolution(
    int width,
    int height,
  ) = _Resolution;

  factory Resolution.fromJson(Map<String, dynamic> json) =>
      _$ResolutionFromJson(json);
}

@freezed
class DisplayOffset with _$DisplayOffset {
  const factory DisplayOffset(
    int x,
    int y,
  ) = _Offset;

  factory DisplayOffset.fromJson(Map<String, dynamic> json) =>
      _$DisplayOffsetFromJson(json);
}

@freezed
class DisplayOrientation with _$DisplayOrientation {
  const factory DisplayOrientation.normal() = NormalOrientation;

  const factory DisplayOrientation.right() = TurnedRight;

  const factory DisplayOrientation.inverted() = InvertedOrientation;

  const factory DisplayOrientation.left() = TurnedLeft;

  factory DisplayOrientation.fromJson(Map<String, dynamic> json) =>
      _$DisplayOrientationFromJson(json);
}

@freezed
class Configuration with _$Configuration {
  const factory Configuration({
    @Default('') String setup,
    @Default({}) Map<String, Setup> setups,
    String? name,
}) = _Configuration;

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
}

@freezed
class Setup with _$Setup {
  const factory Setup({
    required String id,
    @Default('name') String name,
    @Default([]) List<Display> displays,
    @Default('') String command,
}) = _Setup;

  factory Setup.fromJson(Map<String, dynamic> json) => _$SetupFromJson(json);
}
