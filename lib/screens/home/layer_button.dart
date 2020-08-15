import 'package:flutter/material.dart';
import 'package:flutteramap/controller/controller.dart';
import 'package:flutteramap/widgets/float-button.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LayerButton extends StatelessWidget {
  final Map<String, MapType> mapStyle = {
    "mặc định": MapType.normal,
    "vệ tinh": MapType.satellite,
    "địa hình": MapType.terrain
  };
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.21,
      right: 0,
      child: Padding(
        key: key,
        padding: const EdgeInsets.only(top: 8.0),
        child: FloatButton(
          size: 8.0,
          icon: Icon(Icons.layers,size: 30,),
          onPressed: () {
            Get.defaultDialog(
                title: "Loại bản đồ",
                content: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: mapStyle.entries
                            .map(
                              (e) => Container(
                                width: 55,
                                child: Obx(() => Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            MapControl.to.setMapType(e.value);
                                          },
                                          child: Container(
                                              decoration: MapControl
                                                          .to.typeMap.value ==
                                                      e.value
                                                  ? BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9.5),
                                                      border: Border.all(
                                                        width: 2,
                                                        color: Colors.blueAccent,
                                                      ),
                                                    )
                                                  : null,
                                              child: Image.asset(
                                                  'images/${e.key}.png')),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        FittedBox(fit:BoxFit.fitWidth,child: Text(e.key)),
                                      ],
                                    )),
                              ),
                            )
                            .toList())));
          },
          color: Colors.white,
        ),
      ),
    );
  }
}
