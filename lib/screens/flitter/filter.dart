import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutteramap/controller/controller.dart';
import 'package:flutteramap/controller/home_controller.dart';
import 'package:get/get.dart';

class Filter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 38,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.14,
                  child: RaisedButton(
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.black12, width: 1),
                      ),
                      color: Colors.white,
                      child: Icon(
                        Icons.tune,
                        size: 20,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        HomeControl.to.goToFilter();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Text("Ngân hàng",style: TextStyle(color: Colors.black54),),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 18,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    onPressed: () => showMaterialScrollPicker(
                        context: context,
                        title: "Chọn một ngân hàng",
                        cancelText: "Hủy bỏ",
                        confirmText: "Xác nhận",
                        headerColor: Colors.blueAccent[500],
                        buttonTextColor: Colors.blueAccent,
                        items: FilterControl.to.getListBank(),
                        selectedItem: FilterControl.to.bankName.value,
                        onChanged: (value){ FilterControl.to.setBankName(value);
                        MapControl.to
                            .findAtmFromPosition(MapControl.to.position.value.latlng);
                        },
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Obx(()=>RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    color: FilterControl.to.isShowRange.value ? Colors.blue[200] : Colors.white,
                    child: Text("Khoảng cách", style: TextStyle(color: Colors.black54),),
                    onPressed: () {
                      FilterControl.to.setIsShowRange();
                    },
                  )),
                ),
                FlatButton(
                  child: Text(
                    "Các bộ lọc khác",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                  onPressed: (){
                    HomeControl.to.goToFilter();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
