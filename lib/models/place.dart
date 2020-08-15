import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'place.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaceModel {
  final String title;
  final String id;
  final String resultType;
  final Address address;
  // vi tri tren map
  LatLng latlng;
  //vi tri trong thuc te
  final Access access;
  final int distance;
  final ApiCategory categories;
  //id chuoi cac may atm cung thuoc ve mot ngan hang
  final Chain chains;
  PlaceModel(this.title, this.id, this.resultType, this.address, this.latlng,
      this.distance, this.categories, this.access, this.chains,);
  factory PlaceModel.initial(){
    return PlaceModel('Vị trí của bạn', null,  null,  null, null,  null,  null, null,  null,);
  }
  factory PlaceModel.fromJson(Map<String, dynamic> json) => _$PlaceModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class Address{
  Address(this.label, this.countryCode, this.countryName, this.state, this.county, this.city, this.district, this.street, this.postalCode, this.houseNumber);

  final String label;
  final String countryCode;
  final String countryName;
  final String state;
  final String county;
  final String city;
  final String district;
  final String street;
  final String postalCode;
  final String houseNumber;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

}
@JsonSerializable(explicitToJson: true)
class Position{
  Position(this.lat, this.lng);
  double lat;
  double lng;

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);

}
@JsonSerializable(explicitToJson: true)
class Access{
  Access(this.lat, this.lng);

  final double lat;
  final double lng;

  factory Access.fromJson(List<dynamic> json) => _$AccessFromJson(json);
  Map<String, dynamic> toJson() => _$AccessToJson(this);

}
@JsonSerializable(explicitToJson: true)
class ApiCategory {
  ApiCategory(this.id, this.name, this.primary);
  final String id;
  final String name;
  final bool primary;

  factory ApiCategory.fromJson(List<dynamic> json) => _$ApiCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ApiCategoryToJson(this);

}



@JsonSerializable(explicitToJson: true)
class Chain {
  Chain(this.id);
  String id;

  factory Chain.fromJson(List<dynamic> json) =>
      _$ChainFromJson(json);
  Map<String, dynamic> toJson() => _$ChainToJson(this);
}
