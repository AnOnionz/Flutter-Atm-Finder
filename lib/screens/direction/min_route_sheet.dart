import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/services/utils.dart';
import 'package:get/get.dart';

class MinSizeRouteSheet extends StatelessWidget {
  final double size;
  const MinSizeRouteSheet({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomSheetControl.to.state.value.isShowMinRoute
        ? RepaintBoundary(
            child: GestureDetector(
              onTap: () {
                BottomSheetControl.to.state.update((value) {
                  value.isShowMinRoute =
                      !BottomSheetControl.to.state.value.isShowMinRoute;
                });
              },
              child: DraggableScrollableSheet(
                  initialChildSize: size,
                  minChildSize: size,
                  maxChildSize: size,
                  builder: (context, controller) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: BottomSheetControl.to.state.value.route != null
                          ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 12.0, left: 16.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              text: Util.standardizedTime(
                                                  BottomSheetControl.to.state
                                                      .value.route.travelTime),
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
                                        BottomSheetControl.to.state.value.route.transportMode == 'car'?"tuyến đường ngắn nhất": "tuyến đường nhanh nhất",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54),
                                      ),
                                      Container(
                                        width: 150,
                                        child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                side: BorderSide(
                                                    width: .5,
                                                    color: Colors
                                                        .blueAccent[100])),
                                            onPressed: () {
                                              BottomSheetControl.to.state.update((value) {
                                                value.isShowMinRoute =
                                                !BottomSheetControl.to.state.value.isShowMinRoute;
                                              });
                                            },
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.subject, color: Colors.blueAccent,),
                                                  Text(" Bước", style: TextStyle(color: Colors.blueAccent,),),
                                                ]
                                                )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ])
                          : Center(child: CircularProgressIndicator()),
                    );
                  }),
            ),
          )
        : Container());
  }
}
