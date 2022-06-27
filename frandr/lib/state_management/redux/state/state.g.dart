// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppSettings _$$_AppSettingsFromJson(Map<String, dynamic> json) =>
    _$_AppSettings(
      configDirectory: json['configDirectory'] as String? ?? '',
      wiggleRoom: json['wiggleRoom'] as int? ?? 25,
      currentSetupHash: json['currentSetupHash'] as String? ?? null,
    );

Map<String, dynamic> _$$_AppSettingsToJson(_$_AppSettings instance) =>
    <String, dynamic>{
      'configDirectory': instance.configDirectory,
      'wiggleRoom': instance.wiggleRoom,
      'currentSetupHash': instance.currentSetupHash,
    };

_$_ReduxState _$$_ReduxStateFromJson(Map<String, dynamic> json) =>
    _$_ReduxState(
      settings: json['settings'] ?? const AppSettings(),
      configurations: (json['configurations'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, Configuration.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$_ReduxStateToJson(_$_ReduxState instance) =>
    <String, dynamic>{
      'settings': instance.settings,
      'configurations': instance.configurations,
    };
