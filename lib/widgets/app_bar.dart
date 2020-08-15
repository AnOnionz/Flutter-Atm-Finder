import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/find_controller.dart';
import 'package:flutteramap/controller/home_controller.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget action;
  final Color color;
  final bool shadow;
  const CustomAppBar(
      {Key key, this.leading, this.title, this.action, this.color, this.shadow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: color,
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 5.0,
        ),
        child: RepaintBoundary(
          child: Row(
            crossAxisAlignment: HomeControl.to.openDirectPage.value ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              leading,
              Expanded(child: title),
              Obx(() => FindControl.to
                      .state.value.isFinding && !HomeControl.to.openSearchPage.value //&& !Get.find<BottomSheetControl>().isShow.value
                  ? Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    )
                  : Container()),
              action,
            ],
          ),
        ),
      ),
    );
  }
}
