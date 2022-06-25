// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Display _$$_DisplayFromJson(Map<String, dynamic> json) => _$_Display(
      resolution: json['resolution'] == null
          ? const Resolution(0, 0)
          : Resolution.fromJson(json['resolution'] as Map<String, dynamic>),
      offset: json['offset'] == null
          ? const DisplayOffset(0, 0)
          : DisplayOffset.fromJson(json['offset'] as Map<String, dynamic>),
      name: json['name'] as String?,
      outputName: json['outputName'] as String?,
      active: json['active'] as bool? ?? false,
      primary: json['primary'] as bool? ?? false,
      connected: json['connected'] as bool? ?? false,
      refreshRate: (json['refreshRate'] as num?)?.toDouble() ?? 60,
      orientation: json['orientation'] == null
          ? const DisplayOrientation.normal()
          : DisplayOrientation.fromJson(
              json['orientation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_DisplayToJson(_$_Display instance) =>
    <String, dynamic>{
      'resolution': instance.resolution,
      'offset': instance.offset,
      'name': instance.name,
      'outputName': instance.outputName,
      'active': instance.active,
      'primary': instance.primary,
      'connected': instance.connected,
      'refreshRate': instance.refreshRate,
      'orientation': instance.orientation,
    };

_$_Resolution _$$_ResolutionFromJson(Map<String, dynamic> json) =>
    _$_Resolution(
      json['width'] as int,
      json['height'] as int,
    );

Map<String, dynamic> _$$_ResolutionToJson(_$_Resolution instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

_$_Offset _$$_OffsetFromJson(Map<String, dynamic> json) => _$_Offset(
      json['x'] as int,
      json['y'] as int,
    );

Map<String, dynamic> _$$_OffsetToJson(_$_Offset instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

_$NormalOrientation _$$NormalOrientationFromJson(Map<String, dynamic> json) =>
    _$NormalOrientation(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NormalOrientationToJson(_$NormalOrientation instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$TurnedRight _$$TurnedRightFromJson(Map<String, dynamic> json) =>
    _$TurnedRight(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TurnedRightToJson(_$TurnedRight instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$InvertedOrientation _$$InvertedOrientationFromJson(
        Map<String, dynamic> json) =>
    _$InvertedOrientation(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InvertedOrientationToJson(
        _$InvertedOrientation instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$TurnedLeft _$$TurnedLeftFromJson(Map<String, dynamic> json) => _$TurnedLeft(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TurnedLeftToJson(_$TurnedLeft instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_Configuration _$$_ConfigurationFromJson(Map<String, dynamic> json) =>
    _$_Configuration(
      setup: json['setup'] as String? ?? '',
      setups: (json['setups'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Setup.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      selectedSetupId: json['selectedSetupId'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_ConfigurationToJson(_$_Configuration instance) =>
    <String, dynamic>{
      'setup': instance.setup,
      'setups': instance.setups,
      'selectedSetupId': instance.selectedSetupId,
      'name': instance.name,
    };

_$_Setup _$$_SetupFromJson(Map<String, dynamic> json) => _$_Setup(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'name',
      displays: (json['displays'] as List<dynamic>?)
              ?.map((e) => Display.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      command: json['command'] as String? ?? '',
      aspectRatio: json['aspectRatio'] as int? ?? 8,
    );

Map<String, dynamic> _$$_SetupToJson(_$_Setup instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displays': instance.displays,
      'command': instance.command,
      'aspectRatio': instance.aspectRatio,
    };
