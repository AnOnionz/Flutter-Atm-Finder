import 'package:flutteramap/services/here_polyline/flexiblepoliline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'route.g.dart';

@JsonSerializable(explicitToJson: true)
class RouteModel {

  RouteModel(this.length, this.travelTime,this.transportMode, this.actions, this.polyline);
  factory RouteModel.initial(){
    return RouteModel(0,0,"",[],[]);
  }
  final int length;
  final int travelTime;
  final String transportMode;
  final List<RouteItem> actions;
  final List<LatLng> polyline;


  factory RouteModel.fromJson(Map<String, dynamic> json) => _$RouteModelFromJson(json);
  Map<String, dynamic> toJson() => _$RouteModelToJson(this);

}
@JsonSerializable(explicitToJson: true)
class RouteItem {

  RouteItem(this.action, this.duration, this.instruction, this.direction);

  final String action;
  final int duration;
  final String instruction;
  final String direction;


  factory RouteItem.fromJson(Map<String, dynamic> json) => _$RouteItemFromJson(json);
  Map<String, dynamic> toJson() => _$RouteItemToJson(this);

}


