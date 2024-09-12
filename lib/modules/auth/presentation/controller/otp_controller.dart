import 'dart:developer';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/domain/success_model.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import '../../../../common/domain/error_model.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../network/network_client.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/utils.dart';

/// Controller responsible for handling OTP verification.
class OtpController extends GetxController {
  // Observable to track the loading state
  final isLoading = false.obs;

  // Instance of NetworkClient to handle API requests
  final NetworkClient _networkClient = Get.find<NetworkClient>();

  /// Verifies the OTP [confirmationCode] for the given email.
  /// On success, navigates to the Reset Password screen.
  Future<void> verifyOtp({required String confirmationCode}) async {
    isLoading(true); // Start loading
    try {
      // API call to verify OTP
      Response response = await _networkClient.postRequest(
          Api.VERIFY_OTP_CODE,
          {
            "email": restPasswordController.text,
            "confirmationCode": confirmationCode
          }
      );
      handleUnknownError(response);

      if (response.status.hasError) {
        _handleError(response); // Handle error response
      } else {
        _handleSuccess(response, confirmationCode); // Handle success response
      }
    } catch (exp) {
      log(exp.toString()); // Log any exceptions
    }
    isLoading(false); // End loading
  }

  // Private helper functions

  /// Handles success response, shows a success message, and navigates to the Reset Password screen.
  void _handleSuccess(Response response, String confirmationCode) {
    showSuccessMessage(
        message: SuccessModel.fromJson(response.body).message!);
    Get.offAndToNamed(Routes.RESET_PASSWORD, arguments: [confirmationCode]);
  }

  /// Handles error response, logs the error, and displays an error message.
  void _handleError(Response response) {
    logErrorMessage(logName: "verifyOtp", response: response);
    showErrorMessage(message: ErrorModel.fromJson(response.body).message!);
  }
}
