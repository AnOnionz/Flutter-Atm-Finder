import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/filter_controller.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:get/get.dart';

class BankSelector extends StatelessWidget {
  final buttonPadding = const EdgeInsets.fromLTRB(0, 8, 0, 0);
  final Map<String, String> data;
  final String label;

  BankSelector({@required this.data, @required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.only(left: 4),
            child: Text(label)),
        Padding(
          padding: buttonPadding,
          child: Container(
            decoration: _getShadowDecoration(),
            child: Card(
                child: InkWell(
              onTap: () => showMaterialScrollPicker(
                context: context,
                title: "Chọn một ngân hàng",
                cancelText: "Hủy bỏ",
                confirmText: "Xác nhận",
                headerColor: Colors.blueAccent[500],
                buttonTextColor: Colors.blueAccent,
                items: FilterControl.to.getListBank(),
                selectedItem: FilterControl.to.bankName.value,
                onChanged: (value) => FilterControl.to.setBankName(value),
              ),
              child: Obx(() => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              FilterControl.to.banks.value.keys.toList().elementAt(
                                  FilterControl.to.banks.value.values
                                      .toList()
                                      .indexOf(
                                          FilterControl.to.bankName.value)),
                              style: TextStyle(fontSize: 16),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: _getDropdownIcon(),
                      )
                    ],
                  )),
            )),
          ),
        ),
      ],
    );
  }
}

BoxDecoration _getShadowDecoration() {
  return BoxDecoration(
    boxShadow: <BoxShadow>[
      new BoxShadow(
        color: Colors.black.withOpacity(0.06),
        spreadRadius: 4,
        offset: new Offset(0.0, 0.0),
        blurRadius: 15.0,
      ),
    ],
  );
}

Icon _getDropdownIcon() {
  return Icon(
    Icons.unfold_more,
    color: Colors.blueAccent,
  );
}
