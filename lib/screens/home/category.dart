import 'package:flutter/material.dart';
import 'package:flutteramap/controller/controller.dart';


class Category extends StatelessWidget {
  final Map<Widget, String> categories = {
    Icon(Icons.local_atm, size: 20,): "Atm",
    Icon(Icons.local_gas_station, size: 20,): "Trạm xăng",
    Icon(Icons.local_grocery_store, size: 20,): "Cửa hàng tạp hóa ",
    Icon(Icons.restaurant, size: 20,): "Nhà hàng",
    Icon(Icons.local_cafe, size: 20,): "Quán cà phê",
    Icon(Icons.local_hotel, size: 20,): "Khách sạn",
    Icon(Icons.local_airport, size: 20,): "Sân Bay",
    Icon(Icons.local_hospital, size: 20,): "Bệnh Viện"
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: double.infinity,
      child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 6.0 ),
              child: RaisedButton(
                elevation: 5,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                color: Colors.white,
                  child: Row(
                    children: [
                      categories.keys.toList()[index],
                      Text(categories.values.toList()[index]),
                    ],
                  ),
                  onPressed: () async{
                    AppBarControl.to.setTextSearch(
                        categories.values.toList()[index]);
                    AppBarControl.to.disable();
                    await MapControl.to.findAtmFromPosition(
                      MapControl.to.position.value.latlng);

                  }),
            );
          }),
    );
  }
}
