import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/controller/filter_controller.dart';
import 'package:flutteramap/controller/home_controller.dart';
import 'package:flutteramap/controller/map_controller.dart';
import 'package:flutteramap/models/place.dart';
import 'package:flutteramap/models/route.dart';
import 'package:flutteramap/services/utils.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BottomResults extends StatelessWidget {
  final ScrollController scrollController;
  final List<PlaceModel> atms;
  final PlaceModel place;
  final RouteModel route;
  final Map<String, Widget> routeIcon = {
    "depart": Icon(Icons.arrow_upward),
    "arrive": Icon(Icons.golf_course),
    "continue": Icon(Icons.arrow_upward),
    "keepleft": Transform.rotate(
        angle: 225 * pi / 180, child: Icon(Icons.arrow_upward)),
    "keepright":
        Transform.rotate(angle: 45 * pi / 180, child: Icon(Icons.arrow_upward)),
    "turnleft": Transform.rotate(
        angle: 180 * pi / 180, child: Icon(Icons.subdirectory_arrow_right)),
    "turnright": Transform.rotate(
        angle: 180 * pi / 180, child: Icon(Icons.subdirectory_arrow_left))
  };
  BottomResults(
      {Key key, this.atms, this.scrollController, this.place, this.route})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14.0),
            topRight: Radius.circular(14.0),
          )),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        controller: scrollController,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Container(
                  height: 5,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
            BottomSheetControl.to.state.value.isShowListRoute
                ? GetBuilder<BottomSheetControl>(
                    builder: (b) => route != null
                        ? Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  ListView.builder(
                                    controller: scrollController,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: route.actions.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: routeIcon[
                                            "${route.actions[index].action}${route.actions[index].direction ?? ""}"],
                                        title: Text(route
                                            .actions[index].instruction
                                            .toString()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0, left: 16.0),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                  text: TextSpan(
                                                      text:
                                                          Util.standardizedTime(
                                                              BottomSheetControl
                                                                  .to
                                                                  .state
                                                                  .value
                                                                  .route
                                                                  .travelTime),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 25),
                                                      children: <TextSpan>[
                                                    TextSpan(
                                                      text: "  (" +
                                                          Util.standardizedRange(
                                                              BottomSheetControl
                                                                  .to
                                                                  .state
                                                                  .value
                                                                  .route
                                                                  .length) +
                                                          ")",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 25),
                                                    ),
                                                  ])),
                                              Text(
                                                BottomSheetControl
                                                            .to
                                                            .state
                                                            .value
                                                            .route
                                                            .transportMode ==
                                                        'car'
                                                    ? "tuyến đường ngắn nhất"
                                                    : "tuyến đường nhanh nhất",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54),
                                              ),
                                              Container(
                                                width: 150,
                                                child: FlatButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                        side: BorderSide(
                                                            width: .5,
                                                            color: Colors
                                                                    .blueAccent[
                                                                100])),
                                                    onPressed: () {
                                                      BottomSheetControl
                                                          .to.state
                                                          .update((value) {
                                                        value.isShowMinRoute =
                                                            !BottomSheetControl
                                                                .to
                                                                .state
                                                                .value
                                                                .isShowMinRoute;
                                                      });
                                                    },
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.map,
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                          Text(
                                                            " Bản đồ",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent,
                                                            ),
                                                          ),
                                                        ])),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ],
                          )
                        : Center(
                            child: Text("không tìm thấy đuòng đi"),
                          ),
                  )
                : BottomSheetControl.to.state.value.isShowPlace
                    ? Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      place.title,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    place.address.label
                                        .split(",")
                                        .sublist(1)
                                        .join(","),
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    MapControl.to
                                        .findAtmFromPosition(place.latlng);
                                    MapControl.to.position.value = place;
                                  },
                                  color: Colors.blue,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.directions,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Tìm Atm",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            letterSpacing: .3),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                                Text(
                                    "khoảng cách: ${Util.standardizedRange(place.distance)}",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      )
                    : BottomSheetControl.to.state.value.isShowAtm
                        ? atms.length > 0
                            ? ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                      color: Colors.black54,
                                    ),
                                itemCount: atms.length,
                                controller: scrollController,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6, bottom: 6),
                                    child: InkWell(
                                      onTap: () {
                                        MapControl.to.goToPlace(
                                            target: LatLng(
                                                atms[index].latlng.latitude -
                                                    (0.0008 * 4),
                                                atms[index].latlng.longitude),
                                            zoom: 16);
                                        MapControl.to.showInfor(atms[index]);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12.0, left: 12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    atms[index].title,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  Text(
                                                    "ATM - ${atms[index].address.street == null ? "" : "${atms[index].address.street}, "} ${atms[index].address.district},  ${atms[index].address.city}",
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 14),
                                                  ),
                                                  Obx(() => FilterControl
                                                          .to.isShowRange.value
                                                      ? Text(
                                                          "Khoảng cách: ${Util.standardizedRange(atms[index].distance)}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              fontSize: 14),
                                                        )
                                                      : Container()),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
//                                      Container(
//                                        width: 55,
//                                        child: FlatButton(
//                                            child: Icon(
//                                              Icons.phone,
//                                              color: Colors.blueAccent,
//                                            ),
//                                            shape: CircleBorder(
//                                                side: BorderSide(
//                                                    color: Colors.black12,
//                                                    width: 1)),
//                                            onPressed: () {}),
//                                      ),
                                                Container(
                                                  width: 55,
                                                  child: FlatButton(
                                                      child: Icon(
                                                        Icons.directions,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      shape: CircleBorder(
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .black12,
                                                              width: 1)),
                                                      onPressed: () {
                                                        HomeControl.to
                                                            .goToDirection(
                                                                MapControl
                                                                    .to
                                                                    .position.value
                                                                   ,
                                                                atms[index]);
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Center(
                                      child: Text(
                                    "Không tìm thấy Atm ${FilterControl.to.bankName.value} nào quanh đây",
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                              )
                        : Container()
          ],
        ),
      ),
    );
  }
}
