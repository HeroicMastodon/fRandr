// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'actions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Actions {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)
        moveDisplay,
    required TResult Function() loadConfiguration,
    required TResult Function() saveConfiguration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)?
        moveDisplay,
    TResult Function()? loadConfiguration,
    TResult Function()? saveConfiguration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)?
        moveDisplay,
    TResult Function()? loadConfiguration,
    TResult Function()? saveConfiguration,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MoveDisplay value) moveDisplay,
    required TResult Function(LoadConfiguration value) loadConfiguration,
    required TResult Function(SaveConfiguration value) saveConfiguration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MoveDisplay value)? moveDisplay,
    TResult Function(LoadConfiguration value)? loadConfiguration,
    TResult Function(SaveConfiguration value)? saveConfiguration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MoveDisplay value)? moveDisplay,
    TResult Function(LoadConfiguration value)? loadConfiguration,
    TResult Function(SaveConfiguration value)? saveConfiguration,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionsCopyWith<$Res> {
  factory $ActionsCopyWith(Actions value, $Res Function(Actions) then) =
      _$ActionsCopyWithImpl<$Res>;
}

/// @nodoc
class _$ActionsCopyWithImpl<$Res> implements $ActionsCopyWith<$Res> {
  _$ActionsCopyWithImpl(this._value, this._then);

  final Actions _value;
  // ignore: unused_field
  final $Res Function(Actions) _then;
}

/// @nodoc
abstract class _$$MoveDisplayCopyWith<$Res> {
  factory _$$MoveDisplayCopyWith(
          _$MoveDisplay value, $Res Function(_$MoveDisplay) then) =
      __$$MoveDisplayCopyWithImpl<$Res>;
  $Res call(
      {int index,
      String selectedHash,
      DraggableDetails draggableDetails,
      int xOffsetPadding,
      int yOffsetPadding});
}

/// @nodoc
class __$$MoveDisplayCopyWithImpl<$Res> extends _$ActionsCopyWithImpl<$Res>
    implements _$$MoveDisplayCopyWith<$Res> {
  __$$MoveDisplayCopyWithImpl(
      _$MoveDisplay _value, $Res Function(_$MoveDisplay) _then)
      : super(_value, (v) => _then(v as _$MoveDisplay));

  @override
  _$MoveDisplay get _value => super._value as _$MoveDisplay;

  @override
  $Res call({
    Object? index = freezed,
    Object? selectedHash = freezed,
    Object? draggableDetails = freezed,
    Object? xOffsetPadding = freezed,
    Object? yOffsetPadding = freezed,
  }) {
    return _then(_$MoveDisplay(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      selectedHash: selectedHash == freezed
          ? _value.selectedHash
          : selectedHash // ignore: cast_nullable_to_non_nullable
              as String,
      draggableDetails: draggableDetails == freezed
          ? _value.draggableDetails
          : draggableDetails // ignore: cast_nullable_to_non_nullable
              as DraggableDetails,
      xOffsetPadding: xOffsetPadding == freezed
          ? _value.xOffsetPadding
          : xOffsetPadding // ignore: cast_nullable_to_non_nullable
              as int,
      yOffsetPadding: yOffsetPadding == freezed
          ? _value.yOffsetPadding
          : yOffsetPadding // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MoveDisplay implements MoveDisplay {
  const _$MoveDisplay(
      {required this.index,
      required this.selectedHash,
      required this.draggableDetails,
      required this.xOffsetPadding,
      required this.yOffsetPadding});

  @override
  final int index;
  @override
  final String selectedHash;
  @override
  final DraggableDetails draggableDetails;
  @override
  final int xOffsetPadding;
  @override
  final int yOffsetPadding;

  @override
  String toString() {
    return 'Actions.moveDisplay(index: $index, selectedHash: $selectedHash, draggableDetails: $draggableDetails, xOffsetPadding: $xOffsetPadding, yOffsetPadding: $yOffsetPadding)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoveDisplay &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality()
                .equals(other.selectedHash, selectedHash) &&
            const DeepCollectionEquality()
                .equals(other.draggableDetails, draggableDetails) &&
            const DeepCollectionEquality()
                .equals(other.xOffsetPadding, xOffsetPadding) &&
            const DeepCollectionEquality()
                .equals(other.yOffsetPadding, yOffsetPadding));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(selectedHash),
      const DeepCollectionEquality().hash(draggableDetails),
      const DeepCollectionEquality().hash(xOffsetPadding),
      const DeepCollectionEquality().hash(yOffsetPadding));

  @JsonKey(ignore: true)
  @override
  _$$MoveDisplayCopyWith<_$MoveDisplay> get copyWith =>
      __$$MoveDisplayCopyWithImpl<_$MoveDisplay>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)
        moveDisplay,
    required TResult Function() loadConfiguration,
    required TResult Function() saveConfiguration,
  }) {
    return moveDisplay(
        index, selectedHash, draggableDetails, xOffsetPadding, yOffsetPadding);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)?
        moveDisplay,
    TResult Function()? loadConfiguration,
    TResult Function()? saveConfiguration,
  }) {
    return moveDisplay?.call(
        index, selectedHash, draggableDetails, xOffsetPadding, yOffsetPadding);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)?
        moveDisplay,
    TResult Function()? loadConfiguration,
    TResult Function()? saveConfiguration,
    required TResult orElse(),
  }) {
    if (moveDisplay != null) {
      return moveDisplay(index, selectedHash, draggableDetails, xOffsetPadding,
          yOffsetPadding);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MoveDisplay value) moveDisplay,
    required TResult Function(LoadConfiguration value) loadConfiguration,
    required TResult Function(SaveConfiguration value) saveConfiguration,
  }) {
    return moveDisplay(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MoveDisplay value)? moveDisplay,
    TResult Function(LoadConfiguration value)? loadConfiguration,
    TResult Function(SaveConfiguration value)? saveConfiguration,
  }) {
    return moveDisplay?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MoveDisplay value)? moveDisplay,
    TResult Function(LoadConfiguration value)? loadConfiguration,
    TResult Function(SaveConfiguration value)? saveConfiguration,
    required TResult orElse(),
  }) {
    if (moveDisplay != null) {
      return moveDisplay(this);
    }
    return orElse();
  }
}

abstract class MoveDisplay implements Actions {
  const factory MoveDisplay(
      {required final int index,
      required final String selectedHash,
      required final DraggableDetails draggableDetails,
      required final int xOffsetPadding,
      required final int yOffsetPadding}) = _$MoveDisplay;

  int get index => throw _privateConstructorUsedError;
  String get selectedHash => throw _privateConstructorUsedError;
  DraggableDetails get draggableDetails => throw _privateConstructorUsedError;
  int get xOffsetPadding => throw _privateConstructorUsedError;
  int get yOffsetPadding => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$MoveDisplayCopyWith<_$MoveDisplay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadConfigurationCopyWith<$Res> {
  factory _$$LoadConfigurationCopyWith(
          _$LoadConfiguration value, $Res Function(_$LoadConfiguration) then) =
      __$$LoadConfigurationCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadConfigurationCopyWithImpl<$Res>
    extends _$ActionsCopyWithImpl<$Res>
    implements _$$LoadConfigurationCopyWith<$Res> {
  __$$LoadConfigurationCopyWithImpl(
      _$LoadConfiguration _value, $Res Function(_$LoadConfiguration) _then)
      : super(_value, (v) => _then(v as _$LoadConfiguration));

  @override
  _$LoadConfiguration get _value => super._value as _$LoadConfiguration;
}

/// @nodoc

class _$LoadConfiguration implements LoadConfiguration {
  const _$LoadConfiguration();

  @override
  String toString() {
    return 'Actions.loadConfiguration()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadConfiguration);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)
        moveDisplay,
    required TResult Function() loadConfiguration,
    required TResult Function() saveConfiguration,
  }) {
    return loadConfiguration();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)?
        moveDisplay,
    TResult Function()? loadConfiguration,
    TResult Function()? saveConfiguration,
  }) {
    return loadConfiguration?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)?
        moveDisplay,
    TResult Function()? loadConfiguration,
    TResult Function()? saveConfiguration,
    required TResult orElse(),
  }) {
    if (loadConfiguration != null) {
      return loadConfiguration();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MoveDisplay value) moveDisplay,
    required TResult Function(LoadConfiguration value) loadConfiguration,
    required TResult Function(SaveConfiguration value) saveConfiguration,
  }) {
    return loadConfiguration(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MoveDisplay value)? moveDisplay,
    TResult Function(LoadConfiguration value)? loadConfiguration,
    TResult Function(SaveConfiguration value)? saveConfiguration,
  }) {
    return loadConfiguration?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MoveDisplay value)? moveDisplay,
    TResult Function(LoadConfiguration value)? loadConfiguration,
    TResult Function(SaveConfiguration value)? saveConfiguration,
    required TResult orElse(),
  }) {
    if (loadConfiguration != null) {
      return loadConfiguration(this);
    }
    return orElse();
  }
}

abstract class LoadConfiguration implements Actions {
  const factory LoadConfiguration() = _$LoadConfiguration;
}

/// @nodoc
abstract class _$$SaveConfigurationCopyWith<$Res> {
  factory _$$SaveConfigurationCopyWith(
          _$SaveConfiguration value, $Res Function(_$SaveConfiguration) then) =
      __$$SaveConfigurationCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SaveConfigurationCopyWithImpl<$Res>
    extends _$ActionsCopyWithImpl<$Res>
    implements _$$SaveConfigurationCopyWith<$Res> {
  __$$SaveConfigurationCopyWithImpl(
      _$SaveConfiguration _value, $Res Function(_$SaveConfiguration) _then)
      : super(_value, (v) => _then(v as _$SaveConfiguration));

  @override
  _$SaveConfiguration get _value => super._value as _$SaveConfiguration;
}

/// @nodoc

class _$SaveConfiguration implements SaveConfiguration {
  const _$SaveConfiguration();

  @override
  String toString() {
    return 'Actions.saveConfiguration()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SaveConfiguration);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)
        moveDisplay,
    required TResult Function() loadConfiguration,
    required TResult Function() saveConfiguration,
  }) {
    return saveConfiguration();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)?
        moveDisplay,
    TResult Function()? loadConfiguration,
    TResult Function()? saveConfiguration,
  }) {
    return saveConfiguration?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int index,
            String selectedHash,
            DraggableDetails draggableDetails,
            int xOffsetPadding,
            int yOffsetPadding)?
        moveDisplay,
    TResult Function()? loadConfiguration,
    TResult Function()? saveConfiguration,
    required TResult orElse(),
  }) {
    if (saveConfiguration != null) {
      return saveConfiguration();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MoveDisplay value) moveDisplay,
    required TResult Function(LoadConfiguration value) loadConfiguration,
    required TResult Function(SaveConfiguration value) saveConfiguration,
  }) {
    return saveConfiguration(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MoveDisplay value)? moveDisplay,
    TResult Function(LoadConfiguration value)? loadConfiguration,
    TResult Function(SaveConfiguration value)? saveConfiguration,
  }) {
    return saveConfiguration?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MoveDisplay value)? moveDisplay,
    TResult Function(LoadConfiguration value)? loadConfiguration,
    TResult Function(SaveConfiguration value)? saveConfiguration,
    required TResult orElse(),
  }) {
    if (saveConfiguration != null) {
      return saveConfiguration(this);
    }
    return orElse();
  }
}

abstract class SaveConfiguration implements Actions {
  const factory SaveConfiguration() = _$SaveConfiguration;
}
