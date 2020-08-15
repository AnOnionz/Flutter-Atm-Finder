import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/controller.dart';
import 'package:get/get.dart';

class TransportMode extends StatelessWidget {
  final Map<String, Widget> icons = {
    "carRoute": Icon(Icons.directions_car),
    "walkRoute": Icon(Icons.directions_run)
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: double.infinity,
      child: ListView.builder(
          itemCount: icons.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
              child: Obx(() => FlatButton(
                  textColor: RouteControl.to.currentIndex.value == index
                      ? Colors.blueAccent[200]
                      : Colors.black,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  shape: RouteControl.to.currentIndex.value == index
                      ? RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue[200], width: 0.8),
                          borderRadius: BorderRadius.circular(22.0),
                        )
                      : null,
                  color: Colors.white,
                  child: Obx(() => Row(
                        children: [
                          icons.values.toList()[index],
                          Text(RouteControl.to.times[index]),
                        ],
                      )),
                  onPressed: () {
                    RouteControl.to.currentIndex.value = index;
                  })),
            );
          }),
    );
  }
}
