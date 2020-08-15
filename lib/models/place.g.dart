// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) {
  return PlaceModel(
    json['title'] as String,
    json['id'] as String,
    json['resultType'] as String,
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    json['position'] == null
        ? null
        : LatLng(json['position']['lat'],json['position']['lng']),
    json['distance'] as int,
    json['categories'] == null
        ? null
        : ApiCategory.fromJson(json['categories'] as List<dynamic>),
    json['access'] == null ? null : Access.fromJson(json['access'] as List<dynamic>),
    json['chains'] == null ? null : Chain.fromJson(json['chains'] as List<dynamic>),
  );
}

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'resultType': instance.resultType,
      'address': instance.address?.toJson(),
      'position': instance.latlng,
      'access': instance.access?.toJson(),
      'distance': instance.distance,
      'categories': instance.categories?.toJson(),
      'chains': instance.chains?.toJson(),
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['label'] as String,
    json['countryCode'] as String,
    json['countryName'] as String,
    json['state'] as String,
    json['county'] as String,
    json['city'] as String,
    json['district'] as String,
    json['street'] as String,
    json['postalCode'] as String,
    json['houseNumber'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'label': instance.label,
  'countryCode': instance.countryCode,
  'countryName': instance.countryName,
  'state': instance.state,
  'county': instance.county,
  'city': instance.city,
  'district': instance.district,
  'street': instance.street,
  'postalCode': instance.postalCode,
  'houseNumber': instance.houseNumber,
};

Position _$PositionFromJson(Map<String, dynamic> json) {
  return Position(
    (json['lat'] as num)?.toDouble(),
    (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
  'lat': instance.lat,
  'lng': instance.lng,
};

Access _$AccessFromJson(List<dynamic> json) {
  return Access(
    (json[0]['lat'] as num)?.toDouble(),
    (json[0]['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$AccessToJson(Access instance) => <String, dynamic>{
  'lat': instance.lat,
  'lng': instance.lng,
};

ApiCategory _$ApiCategoryFromJson(List<dynamic> json) {
  return ApiCategory(
    json[0]['id'] as String,
    json[0]['name'] as String,
    json[0]['primary'] as bool,
  );
}

Map<String, dynamic> _$ApiCategoryToJson(ApiCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'primary': instance.primary,
    };

Chain _$ChainFromJson(List<dynamic> json) {
  return Chain(
    json[0]['id'] as String,
  );
}

Map<String, dynamic> _$ChainToJson(Chain instance) => <String, dynamic>{
  'id': instance.id,
};

