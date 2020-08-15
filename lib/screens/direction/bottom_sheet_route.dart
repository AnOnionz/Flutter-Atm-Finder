import 'package:flutter/material.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/widgets/custom_bottom.dart';
import 'package:get/get.dart';

class BottomSheetRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomSheetControl.to.state.value.isShowListRoute
        ? NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          if (notification.extent == notification.minExtent) {
            BottomSheetControl.to.state.update((value) {
              value.isShowMinRoute =
              !BottomSheetControl.to.state.value.isShowMinRoute;
            });
          }
          return true;
        },
        child: CustomBottom(
          initSize: 0.6,
          maxSize: 0.6,
          minSize: 0.17,
        ))
        : Container());
    //sheet router
  }
}
