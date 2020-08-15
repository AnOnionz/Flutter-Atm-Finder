import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/controller.dart';
import 'package:flutteramap/screens/direction/transport_mode.dart';
import 'package:flutteramap/screens/home/category.dart';
import 'file:///E:/Mobile/android/Flutter/flutter_amap/lib/screens/flitter/filter.dart';
import 'package:get/get.dart';
import 'package:flutteramap/widgets/app_bar.dart';

class HomeBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HomeBar(this.scaffoldKey);
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
      Obx(() => Container(
            decoration: AppBarControl.to.isBoxDecoration.value
                ? BoxDecoration(
                    color: Colors.white,
                  )
                : null,
            child: Column(
              key: key,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => (!HomeControl.to.openDirectPage.value)
                      ? CustomAppBar(
                          shadow: true,
                          color: Colors.white,
                          leading: IconButton(
                            padding: const EdgeInsets.all(5.0),
                            icon: Icon(
                              Icons.menu,
                              size: 28,
                            ),
                            onPressed: () {
                              scaffoldKey.currentState.openDrawer();
                            },
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 22.0),
                            child: InkWell(
                                onTap: () {
                                  HomeControl.to.goToSearch();
                                },
                                child: Text(
                                        AppBarControl.to.textSearching.value,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black),
                                      )),
                          ),
                          action: IconButton(
                              icon: Icon(
                                AppBarControl.to.isShowCloseButton.value
                                    ? Icons.clear
                                    : Icons.keyboard_voice,
                                size: 28,
                              ),
                              onPressed:
                                  AppBarControl.to.isShowCloseButton.value
                                      ? () {
                                          HomeControl.to.initHomeState();
                                        }
                                      : null),
                        )
                      : CustomAppBar(
                          shadow: false,
                          color: Colors.white,
                          leading: Container(
                            padding: const EdgeInsets.all(0.0),
                            child: InkWell(
                                onTap: RouteControl.to.loadRouteSuccess.value ? () {
                                  RouteControl.to.backToAtm();
                                }: null,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Container(
                                    child: Icon(
                                      Icons.chevron_left,
                                      size: 40,
                                      color: RouteControl.to.loadRouteSuccess.value ? Colors.black87: Colors.white,
                                    ),
                                  ),
                                )),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.adjust,
                                        size: 20,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    Transform.rotate(
                                        angle: 90 * pi / 180,
                                        child: Icon(
                                          Icons.more_horiz,
                                          color: Colors.black26,
                                          size: 18,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 5.0),
                                      child: Icon(
                                        Icons.location_on,
                                        size: 22,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2.0),
                                          child: InkWell(
                                              onTap: () {
                                                Get.find<HomeControl>()
                                                    .goToSearch();
                                              },
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  fit: BoxFit.none,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      RouteControl.to.state
                                                          .value.placeFrom,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 2.0),
                                        child: InkWell(
                                            onTap: () {
                                              Get.find<HomeControl>()
                                                  .goToSearch();
                                            },
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black38),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                fit: BoxFit.none,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5,
                                                  ),
                                                  child: Text(
                                                    RouteControl
                                                        .to.state.value.placeTo,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          action: Container(),
                        )),
                ),
                Obx(
                  () => (AppBarControl.to.state.value.buildTransportMode
                      ? TransportMode()
                      : AppBarControl.to.state.value.buildFilter
                          ? Filter()
                          : AppBarControl.to.state.value.buildCategory
                              ? Category()
                              : Container()),
                ),]
            ),
          )),
    ]);
  }
}
