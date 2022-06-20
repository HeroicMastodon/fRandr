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
    @Default(Orientation.normal()) Orientation orientation,
  }) = _Display;

  factory Display.fromJson(Map<String, dynamic> json) =>
      _$DisplayFromJson(json);
}

@freezed
class Resolution with _$Resolution {
  const factory Resolution(
    double width,
    double height,
  ) = _Resolution;

  factory Resolution.fromJson(Map<String, dynamic> json) =>
      _$ResolutionFromJson(json);
}

@freezed
class DisplayOffset with _$DisplayOffset {
  const factory DisplayOffset(
    double x,
    double y,
  ) = _Offset;

  factory DisplayOffset.fromJson(Map<String, dynamic> json) =>
      _$DisplayOffsetFromJson(json);
}

@freezed
class Orientation with _$Orientation {
  const factory Orientation.normal() = NormalOrientation;

  const factory Orientation.right() = TurnedRight;

  const factory Orientation.inverted() = InvertedOrientation;

  const factory Orientation.left() = TurnedLeft;

  factory Orientation.fromJson(Map<String, dynamic> json) =>
      _$OrientationFromJson(json);
}
