import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutteramap/controller/appbar_controller.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/controller/controller.dart';
import 'package:flutteramap/controller/filter_controller.dart';
import 'package:flutteramap/controller/find_controller.dart';
import 'package:flutteramap/models/place.dart';
import 'package:flutteramap/repository/place_repo.dart';
import 'package:flutteramap/services/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapControl extends GetxController {
  static MapControl get to => Get.find();
  Completer<GoogleMapController> completer = Completer();
  final typeMap = Rx<MapType>();
  final myLocation = Rx<LatLng>();
  final position = Rx<PlaceModel>();
  final markers = List<Marker>().obs;
  final polyline = List<Polyline>().obs;
  final markerByLongPress = List<Marker>().obs;
  final markerByRoute = List<Marker>().obs;
  final markerIcon = BitmapDescriptor.defaultMarker.obs;
  final defaultIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue).obs;
  final atmIcon = BitmapDescriptor.defaultMarker.obs;

  @override
  void onInit() async {
    typeMap.value = MapType.normal;
    myLocation.value = await LocationService().getLocation();
    startMap();
    position.value = PlaceModel('Vị trí của bạn', null,  null,  null, myLocation.value,  null, null,  null,  null);
    markerIcon.value = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(15.0, 15.0)), 'images/redmarker.png');
    atmIcon.value = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(15.0, 15.0)), 'images/atm.png');
  }
  void startMap() {
    markers.value = [];
    markerByLongPress.value = [];
    initPollyline();
    position.value = PlaceModel('Vị trí của bạn', null,  null,  null, myLocation.value,  null, null,  null,  null);
    goToPlace(target: myLocation.value, zoom: 17);
  }
  void initPollyline() {
    polyline.value = [];
    markerByRoute.value = [];
  }

  void setMapType(MapType mapType) {
    typeMap.value = mapType;
  }

  Future<void> findAtmFromPosition(LatLng latlng) async {
    FindControl.to.findLoadingState();
    markerByLongPress.value = [];
    String bankName = FilterControl.to.bankName.value;
    int radius = FilterControl.to.radius.value.toInt();
    try {
      var listAtms = await Get.find<PlaceRepository>().fetchAtms(
          limit: 40,
          location: latlng,
          radius: radius,
          keyWord: bankName == "Tất cả" ? "" : bankName,
          cat: "atm");
      updateMarker(listAtms);
      BottomSheetControl.to.state.value.atms = listAtms;
      goToPlace(
        target: LatLng(latlng.latitude - 0.031, latlng.longitude),
        zoom: 12,
      );
      Get.find<BottomSheetControl>().showSheetAtms();
      FindControl.to.findSuccessState();
      AppBarControl.to.buildFilter();
      AppBarControl.to.buildBoxDecoration(true);
      AppBarControl.to.buildCloseButton(true);
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.DEFAULT) {
        HomeControl.to.initHomeState();
        Get.snackbar("Error", "No Internet Access");
      } else {
        // Timeout hoac Canceled
        HomeControl.to.initHomeState();
        Get.snackbar("Error", "code: " + ex.response.statusCode.toString());
      }
    }
  }

  void updateMarker(List<PlaceModel> list) async {
    markers.clear();
    list.forEach((atm) {
      markers.add(Marker(
          markerId: MarkerId(atm.id),
          position: LatLng(atm.access.lat, atm.access.lng),
          icon: markerIcon.value,
          zIndex: 10,
          infoWindow: InfoWindow(
            title: atm.address.label,
          ),
          onTap: () {}));
    });
  }

  void updatePolyline(List<LatLng> list, PlaceModel from, PlaceModel to) {
    markerByLongPress.value = [];
    polyline.clear();
    polyline.add(Polyline(
        polylineId: PolylineId("0"),
        points: [
          ...[from.latlng],
          ...list,
          ...[to.latlng],
        ],
        color: Colors.blueAccent,
        width: 5));
  }

  void addMarker(LatLng position) {
    markerByLongPress.clear();
    markerByLongPress.add(Marker(
      markerId: MarkerId("redMarker"),
      position: position,
      icon: defaultIcon.value,
      onTap: () {},
    ));
  }

  void addMarkerRoute(PlaceModel from, PlaceModel to) {
    markerByRoute.clear();
    markerByRoute.add(Marker(
      markerId: MarkerId(from.title),
      position: from.latlng,
      icon: markerIcon.value,
      infoWindow: InfoWindow(
        title: from.title,
      ),
      onTap: () {},
    ));
    markerByRoute.add(Marker(
      markerId: MarkerId(to.title),
      position: to.latlng,
      icon: atmIcon.value,
      infoWindow: InfoWindow(
        title: to.title,
      ),
      onTap: () {},
    ));
  }

  Future<void> showInfor(PlaceModel place) async {
    final GoogleMapController controller = await completer.future;
    controller.showMarkerInfoWindow(MarkerId(place.id));
  }

  Future<void> goToPlace (
      {LatLng target, double zoom, double bearing, double tilt}) async {
    final GoogleMapController controller = await completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: bearing ?? 0.0,
        target: target,
        tilt: tilt ?? 0.0,
        zoom: zoom)));
  }

  Future<void> zoomToPolyline(LatLng latlng) async {
    final GoogleMapController controller = await completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(bearing: 45.0, target: latlng, tilt: 90.0, zoom: 19.0)));
  }
}
