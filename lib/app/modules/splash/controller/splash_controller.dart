import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:payrun_mobile/app/global/controller/user_info_controller.dart';
import 'package:payrun_mobile/app/global/services/local_store_service.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../common/controller/connectivity_controller.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../modules/auth/domain/signin_res.dart';
import 'package:dio/dio.dart' as di;

class SplashController extends GetxController {

  _chooseRoute() async {
    final localStore = Get.find<LocalStoreService>();

    final isFirstTime =
        await localStore.read<bool?>(AppString.IS_LOGGED_IN_FIRST_TIME) ??
            false;

    print("isFirstTime $isFirstTime");

    if (isFirstTime) {
      Get.offNamed(Routes.ONBOARD_SCRREN);
      return;
    }

    final isLoggedIn =
        await localStore.read<bool>(AppString.LOGGED_IN) ?? false;

    final nextRoute = isLoggedIn ? Routes.MAIN_SCREEN : Routes.SIGN_IN_SCREEN;
    Get.offAndToNamed(nextRoute);
  }

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 2500), () => _chooseRoute());
  }
}
