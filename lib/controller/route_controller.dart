import 'package:dio/dio.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/controller/controller.dart';
import 'package:flutteramap/controller/map_controller.dart';
import 'package:flutteramap/models/place.dart';
import 'package:flutteramap/models/route.dart';
import 'package:flutteramap/repository/route_repo.dart';
import 'package:flutteramap/services/utils.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteControl extends GetxController {
  static RouteControl get to => Get.find();
  final state = Rx<RouteState>();
  final times = List<String>().obs;
  final currentIndex = RxInt();
  final loadRouteSuccess = RxBool();
  final List<String> initTime = ["", ""];
  @override
  void onInit() {
    loadRouteSuccess.value = false;
    state.value = RouteState.initial();
    times.value = initTime;
    currentIndex.value = 1998;
    super.onInit();
  }

  @override
  void onReady() {
    ever(currentIndex, (_) {
      if(currentIndex.value !=1998)
      BottomSheetControl.to
          .updateRoute(state.value.routes[currentIndex.value]);
    });
    super.onReady();
  }

  void loadRouter(PlaceModel from, PlaceModel to) async {
    times.value = initTime;
    state.update((value) {
      value.placeFrom = from.title;
      value.placeTo = to.title;
      value.routes = null;
    });
    BottomSheetControl.to.showSheetRoute(null);
    try {
      state.value = RouteState(
          placeFrom: from.title, placeTo: to.title, routes: [await Get.find<RouteRepository>().fetchRoute(
          wPoint0: from.latlng, wPoint1: to.latlng, transportMode: "car"), await Get.find<RouteRepository>().fetchRoute(
          wPoint0: from.latlng,
          wPoint1: to.latlng,
          transportMode: "pedestrian")]);
      updateTime();
      currentIndex.value = 0;
      MapControl.to.updatePolyline(
          state.value.routes[currentIndex.value].polyline, from, to);
      MapControl.to.addMarkerRoute(from, to);
      MapControl.to.zoomToPolyline(from.latlng);
      BottomSheetControl.to
          .showSheetRoute(state.value.routes[currentIndex.value]);
      loadRouteSuccess.value = true;
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.RESPONSE) {
        Get.snackbar("Error", ex.error.toString());
        backToAtm();
      } else if (ex.type == DioErrorType.DEFAULT) {
        Get.snackbar("Error", "No Internet Access");
        backToAtm();
      } else {
        // Timeout hoac Canceled
        Get.snackbar("Error", ex.error.toString());
        backToAtm();
      }
    }
  }

  void updateTime() {
    times.value = List<String>();
    for (var route in state.value.routes) {
      times.add(Util.standardizedTime(route.travelTime));
    }
  }

  void backToAtm() {
    onInit();
    HomeControl.to.closeDirection();
    AppBarControl.to.buildFilter();
    MapControl.to.initPollyline();
    BottomSheetControl.to.showSheetAtms();
    MapControl.to.goToPlace(
        target: LatLng(MapControl.to.position.value.latlng.latitude - 0.031,
            MapControl.to.position.value.latlng.longitude),
        zoom: 12);
  }
}

class RouteState {
  String placeFrom;
  String placeTo;
  List<RouteModel> routes;
  RouteState({this.placeFrom, this.placeTo, this.routes});

  factory RouteState.initial() {
    return RouteState(placeFrom: 'từ', placeTo: 'đến', routes: null);
  }
}
