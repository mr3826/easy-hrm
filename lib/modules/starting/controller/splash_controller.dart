import 'package:payrun_mobile/modules/starting/view/view.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class SplashController extends GetxController {
  final box = GetStorage();
  @override
  void onReady() {
    _swapLogo();
    _logoLayout();
   // Future.delayed(const Duration(seconds: 3), ()=>chooseScreen());
    super.onReady();
  }

  RxInt width = 120.obs;
  RxInt height = 120.obs;
  RxBool status = false.obs;


  _swapLogo() {
    status.value = true;
  }
  _logoLayout() {
    width = 18.obs;
    height = 18.obs;
  }

  Future chooseScreen() async {
    final idStore = box.read(AppString.ID_STORE);
    dynamic remValue = box.read(AppString.REMEMBER_KEY);
    dynamic logValue = box.read(AppString.LOGIN_CHECK_KEY);
    if (idStore == null) {
      await Get.to(const ViewScreen());
    } else if (logValue != null && remValue != null) {
      await Get.to(const ViewScreen());
    } else {
      await Get.to(const ViewScreen());
    }
  }
}