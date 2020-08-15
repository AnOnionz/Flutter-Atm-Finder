import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/controller.dart';
import 'package:flutteramap/screens/direction/bottom_sheet_route.dart';
import 'package:flutteramap/screens/direction/min_route_sheet.dart';
import 'package:flutteramap/screens/flitter/filter_page.dart';
import 'package:flutteramap/screens/home/bottom_sheet_atm.dart';
import 'package:flutteramap/screens/home/drawer.dart';
import 'package:flutteramap/screens/home/home_bar.dart';
import 'package:flutteramap/screens/home/layer_button.dart';
import 'package:flutteramap/screens/home/bottom_sheet_atm_min.dart';
import 'package:flutteramap/screens/home/mylocation_button.dart';
import 'package:flutteramap/screens/search/bottom_sheet_place.dart';
import 'package:flutteramap/screens/search/search_page.dart';
import 'package:flutteramap/widgets/map.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      maintainBottomViewPadding: true,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        drawer: MyDrawer(),
        body: Stack(
          children: [
            //build map
            Obx(
              () => MyMap(
                  completer: MapControl.to.completer,
                  center: MapControl.to.myLocation.value,
                  zoom: 14.0,
                  type: MapControl.to.typeMap.value,
                  markers: !HomeControl.to.openDirectPage.value
                      ? [
                          ...MapControl.to.markers.value,
                          ...MapControl.to.markerByLongPress.value
                        ].toSet()
                      : MapControl.to.markerByRoute.value.toSet(),
                  polylines: MapControl.to.polyline.value.toSet(),
                  onLongPress: (LatLng position) {
                    MapControl.to.addMarker(position);
                  }),
            ),
            MyLocationButton(),
            LayerButton(),
            BottomSheetAtm(),
            BottomSheetPlace(),
            MinSizeRouteSheet(size: 0.18,),
            HomeBar(_scaffoldKey),
            MinSizeAtmSheet(size: 0.09,),
            BottomSheetRoute(),
            SearchPage(),
            FilterPage(),
          ],
        ),
      ),
    );
  }
}
