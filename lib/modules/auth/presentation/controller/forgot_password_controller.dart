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

/// Controller responsible for handling the Forgot Password functionality
/// including sending reset requests, OTP resending, and password reset.
class ForgotPasswordController extends GetxController {
  // Observables to track the loading state of different operations
  final isLoading = false.obs;
  final isResendLoading = false.obs;

  // Network client for making API requests
  final NetworkClient _networkClient = Get.find<NetworkClient>();

  /// Sends a forgot password request to the server with the provided email.
  /// It displays a success or error message based on the response.
  Future<void> forgotPassword() async {
    isLoading(true); // Start loading
    try {
      // API call to send forgot password request
      Response response = await _networkClient.postRequest(
          Api.FORGOT_PASSWORD, {"email": restPasswordController.text});
      handleUnknownError(response);

      if (response.status.hasError) {
        // Handle error response
        _handleError(logName: "forgotPassword", response: response);
      } else {
        // On success, navigate to OTP screen and show success message
        Get.toNamed(Routes.OTP, arguments: [restPasswordController.text]);
        showSuccessMessage(
            message: SuccessModel.fromJson(response.body!).message);
        _logSuccess("forgotPassword");
      }
    } catch (exp) {
      // Handle exceptions and show error message
      _handleException(exp as Exception);
    }
    isLoading(false); // End loading
  }

  /// Resends OTP to the specified email address.
  /// Displays appropriate success or error message based on the response.
  Future<void> resendOtp({required String mailAddress}) async {
    isResendLoading(true); // Start loading for resend
    try {
      // API call to resend OTP
      Response response = await _networkClient.postRequest(Api.RESEND_OTP, {
        "email": mailAddress,
      });
      handleUnknownError(response);

      if (response.status.hasError) {
        _handleError(logName: "resendOtp", response: response);
      } else {
        _logSuccess("resendOtp");
        showSuccessMessage(
            message: SuccessModel.fromJson(response.body).message ?? "");
      }
    } catch (exp) {
      log(exp.toString()); // Log any exceptions
    }
    isResendLoading(false); // End resend loading
  }

  /// Resets the password using the provided confirmation code and new password.
  /// Displays success or error messages based on the response.
  Future<void> resetPassword({
    required String confirmationCode,
  }) async {
    isLoading(true); // Start loading
    try {
      // API call to reset the password
      Response response =
      await _networkClient.postRequest(Api.RESET_PASSWORD, {
        "email": restPasswordController.text,
        "confirmationCode": confirmationCode,
        "password": confirmPasswordController.text,
      });
      log(response.body.toString()); // Log the response body for debugging
      handleUnknownError(response);

      if (response.status.hasError) {
        _handleError(logName: "resetPassword", response: response);
      } else {
        _logSuccess("resetPassword");
        confirmPasswordController.clear(); // Clear password fields
        restPasswordController.clear();
        showSuccessMessage(
            message: SuccessModel.fromJson(response.body).message);
        Get.toNamed(Routes.PASSWORD_UPDATE_SCRREN); // Navigate to update screen
      }
    } catch (exp) {
      _handleException(exp as Exception); // Handle any exceptions
    }
    isLoading(false); // End loading
  }

  // Helper function to handle errors and log them
  void _handleError({required String logName, required Response response}) {
    logErrorMessage(logName: logName, response: response);
    showErrorMessage(
        message: ErrorModel.fromJson(response.body).message ??
            AppString.error_text);
  }

  // Helper function to log success messages
  void _logSuccess(String logName) {
    logSuccessMessage(logName: logName);
  }

  // Helper function to handle exceptions
  void _handleException(Exception exp) {
    showErrorMessage(message: AppString.error_text);
    log(exp.toString());
  }
}

