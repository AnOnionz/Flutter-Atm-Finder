import 'package:flutter/material.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/controller/controller.dart';
import 'package:flutteramap/widgets/custom_bottom.dart';
import 'package:get/get.dart';

class BottomSheetAtm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomSheetControl.to.state.value.isShowListAtm
        ? NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (notification.extent <= notification.minExtent) {
                BottomSheetControl.to.state.update((value) {
                  value.isShowMinAtm =
                  !BottomSheetControl.to.state.value.isShowMinAtm;
                });
               MapControl.to.goToPlace(target: MapControl.to.position.value.latlng,zoom: 14);
              }
              return true;
            },
            child: CustomBottom(
              initSize: 0.5,
              maxSize: 1.0,
              minSize: 0.15,
            ))
        : Container());

    //sheet atm
  }
}
