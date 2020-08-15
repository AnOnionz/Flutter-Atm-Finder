import 'package:flutteramap/controller/appbar_controller.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/controller/controller.dart';
import 'package:flutteramap/controller/find_controller.dart';
import 'package:flutteramap/controller/search_controller.dart';
import 'package:flutteramap/models/place.dart';
import 'package:flutteramap/screens/home/home_page.dart';
import 'package:get/get.dart';

class HomeControl extends GetxController {
  static HomeControl get to => Get.find();
  final openFilterPage = false.obs;
  final openSearchPage = false.obs;
  final openDirectPage = false.obs;
  @override
  void onReady() {
    once(
        MapControl.to.myLocation,
        (_) => Future.delayed(const Duration(milliseconds: 0), () {
              Get.off(HomePage());
            }));

    super.onInit();
  }

  void initHomeState() {
    openFilterPage.value = false;
    openSearchPage.value = false;
    openDirectPage.value = false;
    BottomSheetControl.to.onInit();
    AppBarControl.to.onInit();
    FindControl.to.onInit();
    SearchControl.to.onInit();
    FilterControl.to.onInit();
    MapControl.to.startMap();
  }

  void goToSearch() {
    openSearchPage.value = true;
  }

  void closeSearch() {
    openSearchPage.value = false;
  }

  void goToFilter() {
    openFilterPage.value = true;
  }

  void closeFilter() {
    openFilterPage.value = false;
  }

  void goToDirection(
    PlaceModel from,
    PlaceModel to,
  ) {
    openDirectPage.value = true;
    AppBarControl.to.buildBoxDecoration(true);
    RouteControl.to.loadRouter(from, to);
    AppBarControl.to.buildTransportMode();
  }

  void closeDirection() {
    openDirectPage.value = false;
  }
}
