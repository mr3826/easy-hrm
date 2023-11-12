import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class SplashController extends GetxController {
  final box = GetStorage();
  @override
  void onReady() {
   // Future.delayed(const Duration(seconds: 3), ()=>chooseScreen());
    super.onReady();
  }


  Future chooseScreen() async {
    final idStore = box.read(AppString.ID_STORE);
    dynamic remValue = box.read(AppString.REMEMBER_KEY);
    dynamic logValue = box.read(AppString.LOGIN_CHECK_KEY);
    if (idStore == null) {
      await Get.toNamed(Routes.ONBOARD_SCRREN);
    } else if (logValue != null && remValue != null) {
      await Get.toNamed(Routes.ONBOARD_SCRREN);
    } else {
      await Get.toNamed(Routes.ONBOARD_SCRREN);
    }
  }
}