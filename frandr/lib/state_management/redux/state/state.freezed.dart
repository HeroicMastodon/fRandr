// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return _AppSettings.fromJson(json);
}

/// @nodoc
mixin _$AppSettings {
  String get configDirectory => throw _privateConstructorUsedError;
  int get wiggleRoom => throw _privateConstructorUsedError;
  String? get currentConfigurationHash => throw _privateConstructorUsedError;
  int get aspectRatio => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res>;
  $Res call(
      {String configDirectory,
      int wiggleRoom,
      String? currentConfigurationHash,
      int aspectRatio});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res> implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  final AppSettings _value;
  // ignore: unused_field
  final $Res Function(AppSettings) _then;

  @override
  $Res call({
    Object? configDirectory = freezed,
    Object? wiggleRoom = freezed,
    Object? currentConfigurationHash = freezed,
    Object? aspectRatio = freezed,
  }) {
    return _then(_value.copyWith(
      configDirectory: configDirectory == freezed
          ? _value.configDirectory
          : configDirectory // ignore: cast_nullable_to_non_nullable
              as String,
      wiggleRoom: wiggleRoom == freezed
          ? _value.wiggleRoom
          : wiggleRoom // ignore: cast_nullable_to_non_nullable
              as int,
      currentConfigurationHash: currentConfigurationHash == freezed
          ? _value.currentConfigurationHash
          : currentConfigurationHash // ignore: cast_nullable_to_non_nullable
              as String?,
      aspectRatio: aspectRatio == freezed
          ? _value.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_AppSettingsCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$_AppSettingsCopyWith(
          _$_AppSettings value, $Res Function(_$_AppSettings) then) =
      __$$_AppSettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String configDirectory,
      int wiggleRoom,
      String? currentConfigurationHash,
      int aspectRatio});
}

/// @nodoc
class __$$_AppSettingsCopyWithImpl<$Res> extends _$AppSettingsCopyWithImpl<$Res>
    implements _$$_AppSettingsCopyWith<$Res> {
  __$$_AppSettingsCopyWithImpl(
      _$_AppSettings _value, $Res Function(_$_AppSettings) _then)
      : super(_value, (v) => _then(v as _$_AppSettings));

  @override
  _$_AppSettings get _value => super._value as _$_AppSettings;

  @override
  $Res call({
    Object? configDirectory = freezed,
    Object? wiggleRoom = freezed,
    Object? currentConfigurationHash = freezed,
    Object? aspectRatio = freezed,
  }) {
    return _then(_$_AppSettings(
      configDirectory: configDirectory == freezed
          ? _value.configDirectory
          : configDirectory // ignore: cast_nullable_to_non_nullable
              as String,
      wiggleRoom: wiggleRoom == freezed
          ? _value.wiggleRoom
          : wiggleRoom // ignore: cast_nullable_to_non_nullable
              as int,
      currentConfigurationHash: currentConfigurationHash == freezed
          ? _value.currentConfigurationHash
          : currentConfigurationHash // ignore: cast_nullable_to_non_nullable
              as String?,
      aspectRatio: aspectRatio == freezed
          ? _value.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppSettings implements _AppSettings {
  const _$_AppSettings(
      {this.configDirectory = '',
      this.wiggleRoom = 25,
      this.currentConfigurationHash = null,
      this.aspectRatio = 8});

  factory _$_AppSettings.fromJson(Map<String, dynamic> json) =>
      _$$_AppSettingsFromJson(json);

  @override
  @JsonKey()
  final String configDirectory;
  @override
  @JsonKey()
  final int wiggleRoom;
  @override
  @JsonKey()
  final String? currentConfigurationHash;
  @override
  @JsonKey()
  final int aspectRatio;

  @override
  String toString() {
    return 'AppSettings(configDirectory: $configDirectory, wiggleRoom: $wiggleRoom, currentConfigurationHash: $currentConfigurationHash, aspectRatio: $aspectRatio)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppSettings &&
            const DeepCollectionEquality()
                .equals(other.configDirectory, configDirectory) &&
            const DeepCollectionEquality()
                .equals(other.wiggleRoom, wiggleRoom) &&
            const DeepCollectionEquality().equals(
                other.currentConfigurationHash, currentConfigurationHash) &&
            const DeepCollectionEquality()
                .equals(other.aspectRatio, aspectRatio));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(configDirectory),
      const DeepCollectionEquality().hash(wiggleRoom),
      const DeepCollectionEquality().hash(currentConfigurationHash),
      const DeepCollectionEquality().hash(aspectRatio));

  @JsonKey(ignore: true)
  @override
  _$$_AppSettingsCopyWith<_$_AppSettings> get copyWith =>
      __$$_AppSettingsCopyWithImpl<_$_AppSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppSettingsToJson(this);
  }
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings(
      {final String configDirectory,
      final int wiggleRoom,
      final String? currentConfigurationHash,
      final int aspectRatio}) = _$_AppSettings;

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$_AppSettings.fromJson;

  @override
  String get configDirectory => throw _privateConstructorUsedError;
  @override
  int get wiggleRoom => throw _privateConstructorUsedError;
  @override
  String? get currentConfigurationHash => throw _privateConstructorUsedError;
  @override
  int get aspectRatio => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AppSettingsCopyWith<_$_AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

ReduxState _$ReduxStateFromJson(Map<String, dynamic> json) {
  return _ReduxState.fromJson(json);
}

/// @nodoc
mixin _$ReduxState {
// verticalScrollOffset
// horizontalScrollOffset
  AppSettings get settings => throw _privateConstructorUsedError;
  Map<String, Configuration> get configurations =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReduxStateCopyWith<ReduxState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReduxStateCopyWith<$Res> {
  factory $ReduxStateCopyWith(
          ReduxState value, $Res Function(ReduxState) then) =
      _$ReduxStateCopyWithImpl<$Res>;
  $Res call({AppSettings settings, Map<String, Configuration> configurations});

  $AppSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$ReduxStateCopyWithImpl<$Res> implements $ReduxStateCopyWith<$Res> {
  _$ReduxStateCopyWithImpl(this._value, this._then);

  final ReduxState _value;
  // ignore: unused_field
  final $Res Function(ReduxState) _then;

  @override
  $Res call({
    Object? settings = freezed,
    Object? configurations = freezed,
  }) {
    return _then(_value.copyWith(
      settings: settings == freezed
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
      configurations: configurations == freezed
          ? _value.configurations
          : configurations // ignore: cast_nullable_to_non_nullable
              as Map<String, Configuration>,
    ));
  }

  @override
  $AppSettingsCopyWith<$Res> get settings {
    return $AppSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value));
    });
  }
}

/// @nodoc
abstract class _$$_ReduxStateCopyWith<$Res>
    implements $ReduxStateCopyWith<$Res> {
  factory _$$_ReduxStateCopyWith(
          _$_ReduxState value, $Res Function(_$_ReduxState) then) =
      __$$_ReduxStateCopyWithImpl<$Res>;
  @override
  $Res call({AppSettings settings, Map<String, Configuration> configurations});

  @override
  $AppSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$_ReduxStateCopyWithImpl<$Res> extends _$ReduxStateCopyWithImpl<$Res>
    implements _$$_ReduxStateCopyWith<$Res> {
  __$$_ReduxStateCopyWithImpl(
      _$_ReduxState _value, $Res Function(_$_ReduxState) _then)
      : super(_value, (v) => _then(v as _$_ReduxState));

  @override
  _$_ReduxState get _value => super._value as _$_ReduxState;

  @override
  $Res call({
    Object? settings = freezed,
    Object? configurations = freezed,
  }) {
    return _then(_$_ReduxState(
      settings: settings == freezed
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
      configurations: configurations == freezed
          ? _value._configurations
          : configurations // ignore: cast_nullable_to_non_nullable
              as Map<String, Configuration>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReduxState extends _ReduxState {
  const _$_ReduxState(
      {this.settings = const AppSettings(),
      final Map<String, Configuration> configurations = const {}})
      : _configurations = configurations,
        super._();

  factory _$_ReduxState.fromJson(Map<String, dynamic> json) =>
      _$$_ReduxStateFromJson(json);

// verticalScrollOffset
// horizontalScrollOffset
  @override
  @JsonKey()
  final AppSettings settings;
  final Map<String, Configuration> _configurations;
  @override
  @JsonKey()
  Map<String, Configuration> get configurations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_configurations);
  }

  @override
  String toString() {
    return 'ReduxState(settings: $settings, configurations: $configurations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReduxState &&
            const DeepCollectionEquality().equals(other.settings, settings) &&
            const DeepCollectionEquality()
                .equals(other._configurations, _configurations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(settings),
      const DeepCollectionEquality().hash(_configurations));

  @JsonKey(ignore: true)
  @override
  _$$_ReduxStateCopyWith<_$_ReduxState> get copyWith =>
      __$$_ReduxStateCopyWithImpl<_$_ReduxState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReduxStateToJson(this);
  }
}

abstract class _ReduxState extends ReduxState {
  const factory _ReduxState(
      {final AppSettings settings,
      final Map<String, Configuration> configurations}) = _$_ReduxState;
  const _ReduxState._() : super._();

  factory _ReduxState.fromJson(Map<String, dynamic> json) =
      _$_ReduxState.fromJson;

  @override // verticalScrollOffset
// horizontalScrollOffset
  AppSettings get settings => throw _privateConstructorUsedError;
  @override
  Map<String, Configuration> get configurations =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ReduxStateCopyWith<_$_ReduxState> get copyWith =>
      throw _privateConstructorUsedError;
}
