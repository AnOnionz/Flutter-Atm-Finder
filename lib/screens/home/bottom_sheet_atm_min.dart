import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/controller/map_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MinSizeAtmSheet extends StatelessWidget {
  final double size;
  const MinSizeAtmSheet({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomSheetControl.to.state.value.isShowMinAtm
        ? RepaintBoundary(
            child: GestureDetector(
              onTap: (){
                BottomSheetControl.to.state.update((value) {
                  value.isShowMinAtm =
                  !BottomSheetControl.to.state.value.isShowMinAtm;
                });
                MapControl.to.goToPlace(target: LatLng(MapControl.to.position.value.latlng.latitude-0.031, MapControl.to.position.value.latlng.longitude),zoom: 12,);
              },
              child: DraggableScrollableSheet(
                  initialChildSize: size,
                  minChildSize: size,
                  maxChildSize: size,
                  builder: (context, controller) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Hiển thị danh sách", style: TextStyle(color: Colors.blueAccent, fontSize: 18),),
                      ),
                    );
                  }),
            ),
          )
        : Container());
  }
}
