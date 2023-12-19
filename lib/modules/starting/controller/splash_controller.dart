import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
 //   Future.delayed(const Duration(milliseconds: 2500), () => chooseScreen());
  }

  Future chooseScreen() async {
    final box = GetStorage();
    if (box.read(AppString.IS_LOGGED_IN_FIRST_TIME) == true ||
        box.read(AppString.IS_LOGGED_IN_FIRST_TIME) == null) {
      Get.offNamed(Routes.ONBOARD_SCRREN);
    } else {
      Get.offAndToNamed(Routes.MAIN_SCREEN);
    }
  }
}
