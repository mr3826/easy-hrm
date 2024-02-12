import 'dart:developer';
import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/domain/error_model.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';

import '../../../routes/app_pages.dart';

class LogoutController extends GetxController {
  RxBool isLogoutLoading = false.obs;

  Future<void> logout() async {
    isLogoutLoading(true);
    try {
      Response response = await NetworkClient().postRequest(Api.LOGOUT, {
        "refreshToken": GetStorage().read(AppString.REFRESH_TOKEN),
      });

      if (response.hasError) {
        logErrorMessage(logName: "logout", response: response);
        if (ErrorModel.fromJson(response.body).message != null &&
            ErrorModel.fromJson(response.body)
                .message!
                .startsWith("Authorization failed, error: UserDoesNotExist")) {
          GetStorage().remove(AppString.ACCESS_TOKEN);
          GetStorage().remove(AppString.LOGGED_IN);
          Get.offAllNamed(Routes.SIGN_IN_SCREEN);
        }
        if (ErrorModel.fromJson(response.body).message != null &&
            ErrorModel.fromJson(response.body)
                .message!
                .startsWith("Unauthorized")) {
          GetStorage().remove(AppString.ACCESS_TOKEN);
          GetStorage().remove(AppString.LOGGED_IN);
          Get.offAllNamed(Routes.SIGN_IN_SCREEN);
        }
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ?? "");
      } else {
        logSuccessMessage(logName: "logout", response: response);
        if (Platform.isAndroid) {
          GetStorage().remove(AppString.ACCESS_TOKEN);
          GetStorage().remove(AppString.LOGGED_IN);
          Get.offAllNamed(Routes.SIGN_IN_SCREEN);
        } else if (Platform.isIOS) {
          GetStorage().remove(AppString.ACCESS_TOKEN);
          GetStorage().remove(AppString.LOGGED_IN);
          Get.offAllNamed(Routes.SIGN_IN_SCREEN);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    isLogoutLoading(false);
  }
}
