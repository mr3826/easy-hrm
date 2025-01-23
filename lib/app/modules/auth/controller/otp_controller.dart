import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as di;
import 'package:payrun_mobile/common/domain/success_model.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import '../../../global/services/api_service.dart';
import '../../../../common/domain/error_model.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../network/network_client.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/utils.dart';

/// Controller responsible for handling OTP verification.
class OtpController extends GetxController {
  // Observable to track the loading state
  final isLoading = false.obs;
  final isResendLoading = false.obs;

  // Network client for making API requests
  final ApiService _apiService = Get.find<ApiService>();

  /// Verifies the OTP [confirmationCode] for the given email.
  /// On success, navigates to the Reset Password screen.
  Future<void> verifyOtp({required String confirmationCode}) async {
    isLoading(true); // Start loading
    try {
      // API call to verify OTP
      di.Response? response = await _apiService.post(Api.VERIFY_OTP_CODE, {
        "email": restPasswordController.text,
        "confirmationCode": confirmationCode
      });

      if (response != null) {
        _handleSuccess(response, confirmationCode); // Handle success response
      }
    } catch (exp) {
      log(exp.toString()); // Log any exceptions
    }
    isLoading(false); // End loading
  }

  /// Resends OTP to the specified email address.
  /// Displays appropriate success or error message based on the response.
  Future<void> resendOtp({required String mailAddress}) async {
    isResendLoading(true); // Start loading for resend
    try {
      // API call to resend OTP
      di.Response? response = await _apiService.post(Api.RESEND_OTP, {
        "email": mailAddress,
      });
      if (response != null) {
        showSuccessMessage(
            message: SuccessModel.fromJson(response.data).message ?? "");
      }
    } catch (exp) {
      log(exp.toString()); // Log any exceptions
    }
    isResendLoading(false); // End resend loading
  }

  // Private helper functions

  /// Handles success response, shows a success message, and navigates to the Reset Password screen.
  void _handleSuccess(di.Response response, String confirmationCode) {
    showSuccessMessage(message: SuccessModel.fromJson(response.data).message!);
    Get.offAndToNamed(Routes.RESET_PASSWORD, arguments: [confirmationCode]);
  }
}
