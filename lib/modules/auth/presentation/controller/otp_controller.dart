import 'dart:developer';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/domain/success_model.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/auth/presentation/controller/signin_controller.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import '../../../../common/domain/error_model.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../network/network_client.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/utils.dart';

class OtpController extends GetxController {
  final isLoading = false.obs;

  Future<void> verifyOtp({required String confirmationCode}) async {
    isLoading(true);
    try {
      Response response =
          await NetworkClient().postRequest(Api.VERIFY_OTP_CODE, {
        "email": restPasswordController.text,
        "confirmationCode": confirmationCode,
      }); // Check if the response body is null
      handleUnknownError(response);
      if (response.status.hasError) {
        logErrorMessage(logName: "verifyOtp", response: response);
        showErrorMessage(message: ErrorModel.fromJson(response.body).message!);
      } else {
        showSuccessMessage(
            message: SuccessModel.fromJson(response.body).message!);
        Get.offAndToNamed(Routes.RESET_PASSWORD, arguments: [confirmationCode]);
      }
    } catch (exp) {
      log(exp.toString());
    }
    isLoading(false);
  }
}
