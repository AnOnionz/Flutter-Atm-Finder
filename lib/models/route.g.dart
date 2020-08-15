// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) {
  return RouteModel(
    json['summary']['length'] as int,
    json['summary']['duration'] as int,
    json['transport']['mode'] as String,
    (json['actions'] as List)
        ?.map((e) =>
            e == null ? null : RouteItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    FlexiblePolyline.decode(json['polyline'] as String)
  );
}

Map<String, dynamic> _$RouteModelToJson(RouteModel instance) =>
    <String, dynamic>{
      'length': instance.length,
      'travelTime': instance.travelTime,
      'transportMode': instance.transportMode,
      'actions': instance.actions?.map((e) => e?.toJson())?.toList(),
      'polyline': instance.polyline?.map((e) => e?.toJson())?.toList(),
    };

RouteItem _$RouteItemFromJson(Map<String, dynamic> json) {
  return RouteItem(
    json['action'] as String,
    json['duration'] as int,
    (json['instruction'] as String).replaceAll("đường Đường", "Đường"),
    json['direction'] as String,
  );
}

Map<String, dynamic> _$RouteItemToJson(RouteItem instance) => <String, dynamic>{
      'action': instance.action,
      'duration': instance.duration,
      'instruction': instance.instruction,
      'direction': instance.direction,
    };
