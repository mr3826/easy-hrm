import 'dart:developer';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/api_endpoints.dart';
import '../../../utils/utils.dart';
import '../../auth/domain/signin_res.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    if (GetStorage().read(AppString.ACCESS_TOKEN) != null) {
      if (checkTokenExpiration() < 1) {
        _getNewToken();
      }
    }
    Future.delayed(const Duration(milliseconds: 2500), () =>Get.offAndToNamed(Routes.SIGN_IN_SCREEN) );
    super.onReady();
  }

  Future chooseScreen() async {
    final box = GetStorage();
    if (box.read(AppString.IS_LOGGED_IN_FIRST_TIME) == true ||
        box.read(AppString.IS_LOGGED_IN_FIRST_TIME) == null) {
      Get.offNamed(Routes.ONBOARD_SCRREN);
    } else {
      if (GetStorage().read(AppString.LOGGED_IN) == true &&
          GetStorage().read(AppString.LOGGED_IN) != null) {
        Get.offAndToNamed(Routes.MAIN_SCREEN);
      } else {
        Get.offAndToNamed(Routes.SIGN_IN_SCREEN);
      }
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

  void _getNewToken() async {
    try {
      Response response = await NetworkClient().postRequest(Api.REFRESH_TOKEN, {
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID),
        "refreshToken": GetStorage().read(AppString.REFRESH_TOKEN)
      });

      if (response.hasError) {
        logErrorMessage(logName: "refresh token", response: response);
      } else {
        logSuccessMessage(logName: "refresh token", response: response);
        GetStorage().write(AppString.ID_TOKEN,
            SignInResponse.fromJson(response.body).data?.idToken ?? "");
        GetStorage().write(AppString.ACCESS_TOKEN,
            SignInResponse.fromJson(response.body).data?.accessToken ?? "");
        GetStorage().write(AppString.REFRESH_TOKEN,
            SignInResponse.fromJson(response.body).data?.refreshToken ?? "");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
