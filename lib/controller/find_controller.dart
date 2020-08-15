import 'package:get/get.dart';

class FindControl extends GetxController {
  static FindControl get to => Get.find();
  final state = FindState.initial().obs;

    @override
    void onInit(){
    state.value = FindState.initial();
  }

  void findLoadingState() {
    state.update((value) {
      value.isFinding = true;
      value.isSuccess = false;
      value.isFailure = false;
    });
  }

  void findSuccessState() {
    state.update((value) {
      value.isFinding = false;
      value.isSuccess = true;
      value.isFailure = false;
    });
  }

  void findFailureState() {
    state.update((value) {
      value.isFinding = false;
      value.isSuccess = false;
      value.isFailure = true;
    });
  }
}
class FindState {
  bool isFinding;
  bool isSuccess;
  bool isFailure;

  FindState({this.isFinding, this.isSuccess, this.isFailure});

  factory FindState.initial() {
    return FindState(isFinding: false, isSuccess: false, isFailure: false);
  }
}
