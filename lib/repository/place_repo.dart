import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutteramap/config/config.dart';
import 'package:flutteramap/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class PlaceRepository {
  Dio dio = new Dio();
  Future<List<PlaceModel>> fetchAtms({LatLng location, int limit, String keyWord, int radius, String cat}) async {
    String url = "https://discover.search.hereapi.com/v1/discover?lang=vi&";
    Map<String, dynamic> parameters = {
      "limit": limit,
      "in": "circle:${location.latitude},${location.longitude};r=$radius",
      "q": "${keyWord ?? ""}+$cat",
      "apikey": "$HERE_API_KEY"
    };
    final response = await dio.get(url, queryParameters: parameters);
    if (response.statusCode == 200) {
      return Future.value(compute(_parsedPlaces, response.data));
    } else {
      Get.snackbar(
          "Error", "Request failed with status : ${response.statusCode}");
      return List();
    }
  }

  Future<List<PlaceModel>> fetchBySearch(String query, LatLng latLng) async {
    String url = "https://autosuggest.search.hereapi.com/v1/autosuggest?";
    Map<String, dynamic> parameters = {
      "at": "${latLng.latitude},${latLng.longitude}",
      "limit": 15,
      "q": query,
      "resultTypes": "place",
      "apikey": "$HERE_API_KEY"
    };
    final response = await dio.get(url, queryParameters: parameters);
    if (response.statusCode == 200) {
      return Future.value(compute(_parsedPlaces, response.data));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return List();
    }
  }
}

List<PlaceModel> _parsedPlaces(dynamic response) {
  List<dynamic> items = response['items'];
  return items.map((json) => PlaceModel.fromJson(json)).toList();
}
