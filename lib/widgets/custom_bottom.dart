import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/widgets/content_bottom.dart';
import 'package:get/get.dart';

class CustomBottom extends StatelessWidget {
  final double initSize;
  final double maxSize;
  final double minSize;
  const CustomBottom(
      {Key key, this.initSize, this.maxSize, this.minSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DraggableScrollableSheet(
        expand: true,
          initialChildSize: initSize,
          minChildSize: minSize,
          maxChildSize: maxSize,
          builder: (context, controller) {
            return SlideInUp(
                duration: const Duration(milliseconds: 200),
                child: Obx(() => BottomResults(
                      atms: BottomSheetControl.to.state.value.atms,
                      place: BottomSheetControl.to.state.value.place,
                      route: BottomSheetControl.to.state.value.route,
                      scrollController: controller,
                    )));
          }),
    );
  }
}
