import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as di;
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/domain/error_model.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../routes/app_pages.dart';
import '../../auth/presentation/controller/signin_controller.dart';

class LogoutController extends GetxController {
  RxBool isLogoutLoading = false.obs;

  Future<void> logout() async {
    isLogoutLoading(true);
    try {
      di.Response response = await NetworkClient().postRequestWithDio(Api.LOGOUT, {
        "refreshToken": GetStorage().read(AppString.REFRESH_TOKEN),
      });
      // Check if the response body is null
      handleUnknownError(response);
      if (response.statusCode!=200) {
        if (ErrorModel.fromJson(response.data).message != null &&
            ErrorModel.fromJson(response.data)
                .message!
                .startsWith("Authorization failed, error: UserDoesNotExist")) {
          GetStorage().remove(AppString.ACCESS_TOKEN);
          GetStorage().remove(AppString.LOGGED_IN);
        }
        if (ErrorModel.fromJson(response.data).message != null &&
            ErrorModel.fromJson(response.data)
                .message!
                .startsWith("Unauthorized")) {
          GetStorage().remove(AppString.ACCESS_TOKEN);
          GetStorage().remove(AppString.LOGGED_IN);
        }
        showErrorMessage(
            message: ErrorModel.fromJson(response.data).message ?? "");
      } else {
        _clearSession();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _clearSession();
    }
    isLogoutLoading(false);
  }

  void _clearSession() {
    GetStorage().remove(AppString.ACCESS_TOKEN);
    GetStorage().remove(AppString.LOGGED_IN);
    Get.offAllNamed(Routes.SIGN_IN_SCREEN);
    passwordController.clear();
  }
}
