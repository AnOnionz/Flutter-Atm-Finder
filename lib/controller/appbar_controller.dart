import 'package:get/get.dart';

class AppBarControl extends GetxController{
  static AppBarControl get to => Get.find();
  final state = Rx<AppBarState>();
  final isShowCloseButton = RxBool();
  final isBoxDecoration = RxBool();
  final textSearching = RxString();
  @override
  void onInit(){
    textSearching.value = "Tìm kiếm ở đây";
    state.value = AppBarState.initial();
    isShowCloseButton.value = false;
    isBoxDecoration.value = false;
  }
  void buildCategory(){
    state.value = AppBarState.initial();
  }
  void buildFilter(){
    state.update((value) {value.buildFilter= true; value.buildCategory = false; value.buildTransportMode = false;});
  }
  void buildTransportMode(){
    state.update((value) {value.buildFilter= false; value.buildCategory = false; value.buildTransportMode = true;});
  }
  void disable(){
    state.update((value) {value.buildFilter= false; value.buildCategory = false; value.buildTransportMode = false;});
    buildBoxDecoration(false);
  }
  void setTextSearch(String text){
    textSearching.value = text;
  }
  void buildCloseButton(bool value){
    isShowCloseButton.value = value;
  }
  void buildBoxDecoration(bool value){
    isBoxDecoration.value = value;
  }
}
class AppBarState{
  bool buildFilter;
  bool buildCategory;
  bool buildTransportMode;

  AppBarState({this.buildFilter, this.buildCategory, this.buildTransportMode});
  factory AppBarState.initial(){
    return AppBarState(buildCategory: true, buildFilter: false, buildTransportMode: false);
  }
}