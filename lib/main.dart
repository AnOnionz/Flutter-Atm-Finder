import 'package:flutteramap/controller/appbar_controller.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/controller/route_controller.dart';
import 'package:flutteramap/controller/filter_controller.dart';
import 'package:flutteramap/controller/find_controller.dart';
import 'package:flutteramap/models/place.dart';
import 'package:flutteramap/repository/route_repo.dart';
import 'package:flutteramap/screens/flash_page.dart';
import 'controller/home_controller.dart';
import 'controller/map_controller.dart';
import 'controller/search_controller.dart';
import 'repository/place_repo.dart';
import 'screens/home/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'services/location.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      initialRoute: '/flash',
      getPages: [
        GetPage(name: "/home", page: () => HomePage()),
        GetPage(name: "/flash", page: () => FlashPage()),
      ]));
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PlaceModel.initial());
    Get.put(LocationService());
    Get.put(MapControl());
    Get.put(BottomSheetControl());
    Get.put(LocationService());
    Get.put(SearchControl());
    Get.put(FilterControl());
    Get.put(FindControl());
    Get.put(AppBarControl());
    Get.put(RouteControl());
    Get.put(HomeControl());
    Get.put(PlaceRepository());
    Get.put(PlaceModel);
    Get.put(RouteRepository());
  }
}
