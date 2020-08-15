import 'package:flutter/material.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/widgets/custom_bottom.dart';
import 'package:get/get.dart';

class BottomSheetPlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomSheetControl.to.state.value.isShowPlace ? CustomBottom(
        initSize: 0.19,
        maxSize: 0.19,
        minSize: 0.19,
    ):Container());
    //sheet router
  }
}
