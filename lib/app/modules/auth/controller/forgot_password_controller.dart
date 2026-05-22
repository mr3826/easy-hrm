import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as di;
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/common/domain/success_model.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../routes/app_pages.dart';

/// Controller responsible for handling the Forgot Password functionality
/// including sending reset requests, OTP resending, and password reset.
class ForgotPasswordController extends GetxController {
  // Observables to track the loading state of different operations
  final isLoading = false.obs;

  // Network client for making API requests
  final ApiService _apiService = Get.find<ApiService>();

  /// Sends a forgot password request to the server with the provided email.
  /// It displays a success or error message based on the response.
  Future<void> forgotPassword() async {
    isLoading(true); // Start loading
    try {
      // API call to send forgot password request
      di.Response? response = await _apiService.post(
          Api.FORGOT_PASSWORD, {"email": restPasswordController.text});

      if (response != null) {
        // On success, navigate to OTP screen and show success message
        Get.toNamed(Routes.OTP, arguments: [restPasswordController.text]);
        showSuccessMessage(
            message: SuccessModel.fromJson(response.data!).message);
      }
    } catch (exp) {
      // Handle exceptions and show error message
      _handleException(exp as Exception);
    }
    isLoading(false); // End loading
  }

  /// Resets the password using the provided confirmation code and new password.
  /// Displays success or error messages based on the response.
  Future<void> resetPassword({
    required String confirmationCode,
  }) async {
    isLoading(true); // Start loading
    try {
      // API call to reset the password
      di.Response? response =
          await _apiService.post(Api.RESET_PASSWORD, {
        "email": restPasswordController.text,
        "confirmationCode": confirmationCode,
        "password": confirmPasswordController.text,
      });

      if (response!= null) {
        confirmPasswordController.clear(); // Clear password fields
        restPasswordController.clear();
        showSuccessMessage(
            message: SuccessModel.fromJson(response.data).message);
        Get.toNamed(Routes.PASSWORD_UPDATE_SCRREN); // Navigate to update screen
      }
    } catch (exp) {
      _handleException(exp as Exception); // Handle any exceptions
    }
    isLoading(false); // End loading
  }

  // Helper function to handle exceptions
  void _handleException(Exception exp) {
    showErrorMessage(message: AppString.error_text);
    log(exp.toString());
  }
}

