import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutteramap/controller/home_controller.dart';
import 'package:flutteramap/controller/map_controller.dart';
import 'package:flutteramap/models/place.dart';
import 'package:flutteramap/repository/place_repo.dart';
import 'package:get/get.dart';

class SearchControl extends GetxController{
  static SearchControl get to => Get.find();
  ScrollController _controller;
  ScrollController get controller => _controller;
  //check is scroll to show shadow
  final isScroll = false.obs ;
  final query = "".obs;
  final searchResult =List<PlaceModel>().obs;
  @override
  void onInit() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.onInit();
  }
  _scrollListener() {
    if (_controller.offset > _controller.position.minScrollExtent &&
        !_controller.position.outOfRange || _controller.offset > _controller.position.maxScrollExtent &&
        _controller.position.outOfRange  ) {
        isScroll.value = true;
      }else{
        isScroll.value = false;
    }
  }
  @override
  void onReady() {
    ever(query, (_)=> updateSearchResult());
    super.onReady();
  }
  void updateQuery(String text){
    query.value = text;
  }
  void updateSearchResult() async {
    searchResult.clear();
    try{
      searchResult.value = await Get.find<PlaceRepository>().fetchBySearch(query.value, MapControl.to.position.value.latlng);
    } on DioError catch(ex){
      if(ex.type == DioErrorType.DEFAULT){
        HomeControl.to.initHomeState();
        Get.snackbar("Error", "No Internet Access");
      }else{
        // Timeout hoac Canceled
        HomeControl.to.initHomeState();
        Get.snackbar("Error", "code: " + ex.response.statusCode.toString());
      }
    }
    }
}