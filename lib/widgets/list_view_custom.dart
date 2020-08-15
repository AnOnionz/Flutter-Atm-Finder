import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final ScrollController controller;
  final List list;
  final Function itemBuilder;

  const CustomList({Key key, this.controller, this.list, this.itemBuilder,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controller,
        itemCount: list.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        physics: BouncingScrollPhysics(),
        itemBuilder: itemBuilder,
    );
  }
}
