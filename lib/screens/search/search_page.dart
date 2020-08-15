import 'package:flutter/material.dart';
import 'package:flutteramap/controller/bottomsheet_controller.dart';
import 'package:flutteramap/controller/controller.dart';
import 'package:flutteramap/controller/home_controller.dart';
import 'package:flutteramap/controller/map_controller.dart';
import 'package:flutteramap/controller/search_controller.dart';
import 'package:flutteramap/widgets/app_bar.dart';
import 'package:flutteramap/widgets/list_view_custom.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
      return Obx(()=> HomeControl.to.openSearchPage.value ? SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          key: scaffoldKey,
          body: Stack(children: [
            Positioned(
              left: 10,
              top: 68,
              right: 10,
              bottom: 0,
              child: Obx(() => CustomList(
                  list: SearchControl.to.searchResult.value,
                  controller: SearchControl.to.controller,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        HomeControl.to.closeSearch();
                        AppBarControl.to.disable();
                        BottomSheetControl.to.showSheetPlace(placeModel: SearchControl.to.searchResult[index]);
                        MapControl.to.position.value = SearchControl.to.searchResult[index];
                      },
                      child: ListTile(
                        title: Text(SearchControl.to.searchResult[index].title),
                        subtitle: Text(
                            SearchControl.to.searchResult[index].address.label),
                        leading:
                        SearchControl.to.searchResult[index].resultType ==
                            "place"
                            ? Icon(Icons.location_on)
                            : Icon(Icons.category),
                      ),
                    );
                  })),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height - 90,
              child: Obx(() => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: SearchControl.to.isScroll.value
                      ? [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ]
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 1),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: CustomAppBar(
                      shadow: false,
                      color: Colors.white,
                      leading: IconButton(
                        padding: const EdgeInsets.only(bottom: 5, top: 3),
                        icon: Icon(
                          Icons.chevron_left,
                          size: 40,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          HomeControl.to.closeSearch();
                        },
                      ),
                      title: TextField(
                        autofocus: true,
                        controller: _textEditingController,
                        onChanged: (_) {
                          SearchControl.to.updateQuery(
                              _textEditingController.text);
                        },
                        style: TextStyle(
                            fontSize: 20, decoration: TextDecoration.none),
                        decoration: InputDecoration(
                          hintText: "Tìm kiếm",
                          hintStyle: TextStyle(
                              color: Colors.black, fontSize: 20),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 20, bottom: 12, top: 10, right: 20),
                        ),
                      ),
                      action: IconButton(
                          icon: Icon(
                            Icons.keyboard_voice,
                            size: 28,
                          ),
                          onPressed: () {}),
                    ),
                  ),
                ),
              )),
            ),
          ]),
        ),
      ): Container());
  }
}
