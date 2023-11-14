import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/domain/success_model.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';

class ForgotPasswordController extends GetxController {
  final isLoading = false.obs;

  Future<void> forgotPassword() async {
    isLoading(true);
    try {
      Response response =
          await NetworkClient().postRequest(Api.FORGOT_PASSWORD, {
        "email": emailController.text,
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID)
      });

      if (response.status.hasError) {
      } else {
        log(SuccessModel.fromJson(response.body).message ?? "");
      }
    } catch (exp) {
      log(exp.toString());
    }
    isLoading(false);
  }

  Future<void> resendOtp() async {
    isLoading(true);
    try {
      Response response =
          await NetworkClient().postRequest(Api.FORGOT_PASSWORD, {
        "email": emailController.text,
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID)
      });

      if (response.status.hasError) {
      } else {
        log(SuccessModel.fromJson(response.body).message ?? "");
      }
    } catch (exp) {
      log(exp.toString());
    }
    isLoading(false);
  }

  Future<void> resetPassword({required String confirmationCode}) async {
    isLoading(true);
    try {
      Response response =
          await NetworkClient().postRequest(Api.RESET_PASSWORD, {
        "email": emailController.text,
        "confirmationCode": confirmationCode,
        "password": confirmPasswordController.text,
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID)
      });
      log(response.body.toString());
      if (response.status.hasError) {
      } else {
        log(SuccessModel.fromJson(response.body).message ?? "");
      }
    } catch (exp) {
      log(exp.toString());
    }
    isLoading(false);
  }
}
