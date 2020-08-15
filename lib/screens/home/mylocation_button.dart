import 'package:flutter/material.dart';
import 'package:flutteramap/controller/home_controller.dart';
import 'package:flutteramap/controller/map_controller.dart';
import 'package:flutteramap/widgets/float-button.dart';
import 'package:get/get.dart';

class MyLocationButton extends StatelessWidget {
  final HomeControl homeControl = Get.put(HomeControl());
  final MapControl mapControl = Get.put(MapControl());
  MyLocationButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.1,
      top: MediaQuery.of(context).size.height * 0.8,
      right: 0,
      child: FloatButton(
        size: 8.0,
        color: Colors.white,
        onPressed: () {
         mapControl.goToPlace(target: MapControl.to.myLocation.value, bearing: 45.0, tilt: 45.0, zoom: 19);
        },
        icon: Icon(
          Icons.gps_fixed,color: Colors.blueAccent,size: 30,
        ),

      ),
    );
  }
}
