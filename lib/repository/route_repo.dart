import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutteramap/config/config.dart';
import 'package:flutteramap/models/route.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteRepository {
  Dio dio = new Dio();
  Future<RouteModel> fetchRoute({ LatLng wPoint0, LatLng wPoint1, String transportMode}) async {
    String url = "https://router.hereapi.com/v8/routes?lang=vi&";
    Map<String, dynamic> parameters = {
      "transportMode": transportMode,
      "origin": "${wPoint0.latitude},${wPoint0.longitude}",
      "destination": "${wPoint1.latitude},${wPoint1.longitude}",
      "return": "polyline,actions,instructions,summary",
      "routingMode": transportMode == "car" ? "short" : "fast",
      "apiKey": "$HERE_API_KEY"
    };
    final response = await dio.get(
      url,
      queryParameters: parameters,
    );
    if (response.statusCode == 200) {
      return Future.value(compute(_parsedRoute, response.data));
    } else {
      Get.snackbar(
          "Error", "Request failed with status : ${response.statusCode}");
      return null;
    }
  }
}

RouteModel _parsedRoute(dynamic response) {
  Map<String, dynamic> json = response['routes'][0]['sections'][0];
  return RouteModel.fromJson(json);
}
