import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:payrun_mobile/common/controller/user_info_controller.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../common/controller/connectivity_controller.dart';
import '../../../utils/api_endpoints.dart';
import '../../auth/domain/signin_res.dart';
import 'package:dio/dio.dart' as di;

class SplashController extends GetxController {
  @override
  void onReady() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.to(const NetworkErrorPage());
      Get.find<ConnectivityController>().isDialogIsOpened(true);
    } else {
      _routingProcess();
      super.onReady();
    }
  }

  _chooseRoute() {
    GetStorage box = GetStorage();
    if (box.read(AppString.IS_LOGGED_IN_FIRST_TIME) == true ||
        box.read(AppString.IS_LOGGED_IN_FIRST_TIME) == null) {
      Get.offNamed(Routes.ONBOARD_SCRREN);
    } else {
      Get.offAndToNamed(Routes.SIGN_IN_SCREEN);
    }
  }

  int checkTokenExpiration() {
    DateTime now = DateTime.now();

    // Specify the target date and time

    DateTime targetDate =
        JwtDecoder.getExpirationDate(GetStorage().read(AppString.ACCESS_TOKEN));

    // Calculate the difference
    Duration difference = targetDate.difference(now);

    return difference.inHours;
  }

  Future<bool> _getNewToken() async {
    try {
      di.Response response =
          await Get.find<NetworkClient>().postRequest(Api.REFRESH_TOKEN, {
        "refreshToken": GetStorage().read(AppString.REFRESH_TOKEN),
        "accessToken": GetStorage().read(AppString.ACCESS_TOKEN),
      });

      if (response.statusCode != 200) {
        return false;
      } else {
        _handleSuccess(response);
        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  void _handleSuccess(di.Response response) {
    GetStorage().write(AppString.ACCESS_TOKEN,
        SignInResponse.fromJson(response.data).data?.accessToken ?? "");
    GetStorage().write(AppString.REFRESH_TOKEN,
        SignInResponse.fromJson(response.data).data?.refreshToken ?? "");
  }

  _routingProcess() {
    if (GetStorage().read(AppString.ACCESS_TOKEN) != null) {
      if (checkTokenExpiration().isNegative || checkTokenExpiration() < 1) {
        _getNewToken().then((value) => value == true
            ? Future.delayed(const Duration(milliseconds: 2500), () async {
                await Get.find<UserInfoController>().getOrgSubscriptionInfo();
                // Navigate to the main screen
                Get.offNamed(Routes.MAIN_SCREEN);
              })
            : Future.delayed(const Duration(milliseconds: 2500),
                () => Get.offAndToNamed(Routes.SIGN_IN_SCREEN)));
      } else {
        Future.delayed(const Duration(milliseconds: 2500), () async {
          await Get.find<UserInfoController>().getOrgSubscriptionInfo();
          // Navigate to the main screen
          Get.offNamed(Routes.MAIN_SCREEN);
        });
      }
    } else {
      Future.delayed(const Duration(milliseconds: 2500), () => _chooseRoute());
    }
  }
}
