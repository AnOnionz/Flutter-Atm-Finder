import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutteramap/controller/home_controller.dart';
import 'package:flutteramap/controller/map_controller.dart';
import 'package:get/get.dart';

class FilterControl extends GetxController {
  static FilterControl get to => Get.find();
  final isShowRange = RxBool();
  final radius = RxDouble();
  final bankName = RxString();
  final filterChanged = RxBool();
  final banks = Rx<Map<String, String>>();
  final Map<String, String> constantBanks = {
    "Tất cả": "Tất cả",
    "Ngân hàng An Bình": "ABBANK",
    "Ngân hàng Á Châu": "ACB",
    "Ngân hàng NN&PT Nông thôn Việt Nam": "AgribanK",
    "Ngân hàng Bắc Á": "Bac A Bank",
    "Ngân hàng Bảo Việt": "BAO VIET Bank",
    "Ngân hàng Đầu tư và Phát triển Việt Nam": "BIDV",
    "Ngân hàng Xây dựng": "CB",
    "Ngân hàng CIMB Việt Nam": "CIMB",
    "Ngân hàng Đông Á": "DongA Bank",
    "Ngân hàng Xuất Nhập Khẩu": "Eximbank",
    "Ngân hàng Dầu khí toàn cầu": "GPBank",
    "Ngân hàng Phát triển TPHồ Chí Minh": "HDBank",
    "Ngân hàng Hong Leong Việt Nam": "HLBVN",
    "Ngân hàng HSBC Việt Nam": "HSBC",
    "Ngân hàng Indovina": "IVB",
    "Ngân hàng Kiên Long": "KienLongBank",
    "Ngân hàng Bưu điện Liên Việt": "LienVietPostBank",
    "Ngân hàng Quân Đội": "MB",
    "Ngân hàng Hàng Hải": "MSB",
    "Ngân hàng Nam Á": "Nam A Bank",
    "Ngân hàng Quốc dân": "NCB",
    "Ngân hàng Phương Đông": "OCB",
    "Ngân hàng Đại Dương": "Ocean Bank",
    "Ngân hàng Public Bank Việt Nam": "PBVN",
    "Ngân hàng Xăng dầu Petrolimex": "PG Bank",
    "Ngân hàng Sài Gòn Thương Tín": "SacomBank",
    "Ngân hàng Sài Gòn Công Thương": "SAIGONBANK",
    "Ngân hàng Sài Gòn": "SCB",
    "Ngân hàng Đông Nam Á": "SeABank",
    "Ngân hàng Sài Gòn – Hà Nội": "SHB",
    "Ngân hàng Shinhan Việt Nam": "SHBVN",
    "Ngân hàng TMCP Kỹ Thương": "TechcombanK",
    "Ngân hàng Tiên Phong": "TPBANK",
    "Ngân hàng Chính sách xã hội Việt Nam": "VBSP",
    "Ngân hàng Phát triển Việt Nam": "VDB",
    "Ngân hàng Quốc Tế": "VIB",
    "Ngân hàng Việt Á": "VietABank",
    "Ngân hàng Việt Nam Thương Tín": "Vietbank",
    "Ngân hàng Ngoại Thương Việt Nam": "Vietcombank",
    "Ngân hàng Công thương Việt Nam": "VietTinBank",
    "Ngân hàng Việt Nam Thịnh Vượng": "VPBANK",
    "Ngân hàng Liên doanh Việt – Nga": "VRB",
  };
  @override
  void onInit() async{
    isShowRange.value = false;
    radius.value = 5000.0;
    bankName.value = "Tất cả";
    filterChanged.value = false;
    try{
    QuerySnapshot snapshot = await Firestore.instance.collection("bank").getDocuments();
    banks.value = {"Tất cả": "Tất cả"};
    snapshot.documents.forEach((bank) {
      var name = bank.data['name'];
      var brandName = bank.data['brandName'];
      banks.value.addAll({name:brandName});
    });}
    catch(e){
      banks.value = constantBanks;
    }
    super.onInit();
  }

  @override
  void onReady() {
    ever(bankName, (_) => {filterChanged.value = true});
    ever(radius, (_) => {filterChanged.value = true});
    super.onReady();
  }

  void setBankName(String name) {
    bankName.value = name;
  }

  void setRadius(double value) {
    radius.value = value;
  }

  void setIsShowRange() {
    isShowRange.value = !isShowRange.value;
  }
  List<String> getListBank(){
    return [banks.value.values.elementAt(0),...banks.value.values.skip(1).toList()..sort(),];
  }
  void onUpdate() async {
    if (filterChanged.value == true) {
      MapControl.to
          .findAtmFromPosition(MapControl.to.position.value.latlng);
      filterChanged.value = false;
    }
    Get.find<HomeControl>().closeFilter();
  }
}
