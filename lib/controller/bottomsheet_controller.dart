import 'package:flutteramap/controller/appbar_controller.dart';
import 'package:flutteramap/controller/map_controller.dart';
import 'package:flutteramap/models/place.dart';
import 'package:flutteramap/models/route.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BottomSheetControl extends GetxController {
  static BottomSheetControl get to => Get.find();
  final state = Rx<BottomSheetState>();

  @override
  void onInit() {
    state.value = BottomSheetState.initial();
    super.onInit();
  }
    void showSheetAtms() {
      state.update((value) { value.isShowAtm = true; value.isShowMinAtm = false; value.isShowRoute = false; value.isShowMinRoute = false; value.isShowPlace = false;});
    }

    void showSheetPlace({PlaceModel placeModel}) {
      AppBarControl.to.buildCloseButton(true);
      AppBarControl.to.setTextSearch(placeModel.title);
      MapControl.to.addMarker(
          placeModel.latlng);
      MapControl.to.goToPlace(zoom: 16, target: LatLng(placeModel.latlng.latitude - (0.0008 * 4), placeModel.latlng.longitude));
      state.update((value) {value.place = placeModel; value.isShowMinRoute = false; value.isShowRoute= false; value.isShowMinAtm=false; value.isShowPlace = true; value.isShowAtm = false;});
    }
    void showSheetRoute(RouteModel routeModel){
      state.update((value) {value.route = routeModel; value.isShowMinRoute = true; value.isShowRoute = true; value.isShowPlace = false; value.isShowAtm = false; value.isShowMinAtm = false;});
    }
    void updateRoute(RouteModel routeModel){
      state.update((value) {value.route = routeModel;});
    }

  }
  class BottomSheetState{
    bool isShowAtm ;
    bool isShowPlace;
    bool isShowRoute;
    bool isShowMinAtm;
    bool isShowMinRoute;
    RouteModel route;
    PlaceModel place;
    List<PlaceModel> atms;
    bool get isShowBottomSheet => (isShowPlace || isShowAtm || isShowRoute);
    bool get isShowListAtm => isShowAtm && !isShowMinAtm;
    bool get isShowListRoute => isShowRoute && !isShowMinRoute;
    BottomSheetState({this.isShowAtm, this.isShowPlace, this.isShowRoute, this.isShowMinAtm, this.isShowMinRoute,
      this.route, this.place, this.atms});

    factory BottomSheetState.initial(){
      return BottomSheetState(isShowAtm: false, isShowPlace:false, isShowRoute:false, isShowMinAtm: false, isShowMinRoute: false, atms: [], place: null, route: null);
    }
}