import 'dart:developer';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import '../../../../common/domain/error_model.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../network/network_client.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/utils.dart';


class OtpController extends GetxController {
  final isLoading = false.obs;

  final NetworkClient _networkClient = Get.find<NetworkClient>();

  Future<void> verifyOtp({required String confirmationCode}) async {
    isLoading(true);
    try {
      Response response =
      await _networkClient.postRequest(Api.RESET_PASSWORD, {

        "email": restPasswordController.text,
        "confirmationCode": confirmationCode,
        "password": "111111",
      });
      if (response.status.hasError) {
        logErrorMessage(logName: "verifyOtp", response: response);
        if (ErrorModel.fromJson(response.body)
            .message!
            .startsWith("Invalid verification code provided")) {
          showErrorMessage(message: AppString.invalidVerificationCode.tr);
        } else if (ErrorModel.fromJson(response.body)
            .message!
            .startsWith("Password does not conform to policy")) {
          Get.offAndToNamed(Routes.RESET_PASSWORD,arguments: [confirmationCode]);

        } else {
          showErrorMessage(
              message: ErrorModel.fromJson(response.body).message!);
        }
      }
    } catch (exp) {
      log(exp.toString());
    }
    isLoading(false);
  }
}
