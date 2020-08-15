import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/filter_controller.dart';
import 'package:flutteramap/controller/home_controller.dart';
import 'package:flutteramap/screens/flitter/bank_selector.dart';
import 'package:get/get.dart';

class FilterPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => HomeControl.to.openFilterPage.value
        ? SlideInUp(
            duration: Duration(milliseconds: 50),
            child: Stack(
              children: <Widget>[
                Scaffold(
                  key: scaffoldKey,
                  appBar: AppBar(
                    elevation: 4,
                    bottomOpacity: 3.0,
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                        icon: Icon(
                          Icons.clear,
                          size: 30,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Get.find<HomeControl>().closeFilter();
                        }),
                    title: Text(
                      "Bộ lọc",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection("bank")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if(snapshot.connectionState == ConnectionState.none){
                                        return Center(child: CircularProgressIndicator(),);
                                      }
                                      if (snapshot.hasData) {
                                        Map<String, String> banks = {
                                          "Tất cả": "Tất cả"
                                        };
                                        final listBank =
                                            snapshot.data.documents;
                                        for (var bank in listBank) {
                                          final name = bank.data['name'];
                                          final brandName =
                                              bank.data['brandName'];
                                          banks.addAll({name: brandName});
                                        }
                                        FilterControl.to.banks.value = banks;
                                      }
                                      return BankSelector(
                                        data: FilterControl.to.banks.value,
                                        label: "Ngân hàng",
                                      );
                                    }),
                                SizedBox(height: 20.0),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Khoảng cách"),
                              Obx(() => Switch(
                                  value: FilterControl.to.isShowRange.value,
                                  onChanged: (newValue) {
                                    FilterControl.to.isShowRange.value =
                                        newValue;
                                  })),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Phạm vi tìm kiếm"),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Colors.red[700],
                                  inactiveTrackColor: Colors.red[100],
                                  trackShape: RoundedRectSliderTrackShape(),
                                  trackHeight: 4.0,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 12.0),
                                  thumbColor: Colors.redAccent,
                                  overlayColor: Colors.red.withAlpha(32),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 28.0),
                                  tickMarkShape: RoundSliderTickMarkShape(),
                                  activeTickMarkColor: Colors.red[700],
                                  inactiveTickMarkColor: Colors.red[100],
                                  valueIndicatorShape:
                                      PaddleSliderValueIndicatorShape(),
                                  valueIndicatorColor: Colors.redAccent,
                                  valueIndicatorTextStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                child: Obx(
                                  () => Slider(
                                    value: FilterControl.to.radius.value,
                                    min: 1000,
                                    max: 50000,
                                    divisions: 1000,
                                    label:
                                        '${(FilterControl.to.radius.value / 1000).toStringAsFixed(1)} km',
                                    onChanged: (double radius) {
                                      FilterControl.to
                                          .setRadius(radius.roundToDouble());
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            FilterControl.to.onInit();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.16,
                            child: Center(
                              child: Text(
                                "Xóa",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        )),
                        Container(
                          color: Colors.black26,
                          height: MediaQuery.of(context).size.width * 0.16,
                          width: 1,
                        ),
                        Expanded(
                            child: Container(
                          child: InkWell(
                            onTap: () {
                              FilterControl.to.onUpdate();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.16,
                              child: Center(
                                child: Text(
                                  "Áp dụng",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ))
        : Container());
  }
}
