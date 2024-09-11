import 'dart:developer';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/domain/error_model.dart';
import 'package:payrun_mobile/common/domain/success_model.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final isLoading = false.obs;

  Future<void> forgotPassword() async {
    isLoading(true);
    try {
      Response response = await NetworkClient().postRequest(
          Api.FORGOT_PASSWORD, {"email": restPasswordController.text});

      if (response.status.hasError) {
        logErrorMessage(logName: "forgotPassword", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                AppString.error_text);
      } else {
        Get.toNamed(Routes.OTP, arguments: [restPasswordController.text]);
        showSuccessMessage(
            message: SuccessModel.fromJson(response.body!).message);
        logSuccessMessage(logName: "forgotPassword");
      }
    } catch (exp) {
      showErrorMessage(message: AppString.error_text);
      log(exp.toString());
    }
    isLoading(false);
  }

  Future<void> resendOtp({required String mailAddress}) async {
    isLoading(true);
    try {
      Response response = await NetworkClient().postRequest(Api.RESEND_OTP, {
        "email": mailAddress,
      });
      if (response.status.hasError) {
        logErrorMessage(logName: "resendOtp", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                AppString.error_text);
      } else {
        logSuccessMessage(logName: "resendOtp");
        showSuccessMessage(
            message: SuccessModel.fromJson(response.body).message ?? "");
      }
    } catch (exp) {
      log(exp.toString());
    }
    isLoading(false);
  }

  Future<void> resetPassword({
    required String confirmationCode,
  }) async {
    isLoading(true);
    try {
      Response response =
          await NetworkClient().postRequest(Api.RESET_PASSWORD, {
        "email": restPasswordController.text,
        "confirmationCode": confirmationCode,
        "password": confirmPasswordController.text,
      });
      log(response.body.toString());
      if (response.status.hasError) {
        logErrorMessage(logName: "resetPassword", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                AppString.error_text);
      } else {
        logSuccessMessage(logName: "resetPassword");
        confirmPasswordController.clear();
        restPasswordController.clear();
        showSuccessMessage(
            message: SuccessModel.fromJson(response.body).message);
        Get.toNamed(Routes.PASSWORD_UPDATE_SCRREN);
      }
    } catch (exp) {
      log(exp.toString());
    }
    isLoading(false);
  }
}
