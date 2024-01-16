import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';

import '../../../common/domain/error_model.dart';
import '../../../common/widget/error_message.dart';
import '../../../network/exception_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';

class UpdateProfileController extends GetxController {
  final isLoading = false.obs;

  void updateUserProfile(Map<String, dynamic> variables) async {
    isLoading(true);
    final response = await NetworkClient()
        .mutationGraphData(updateUserProfileMutation, {"inputData": variables});

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      Get.find<UserProfileController>().getUserProfile();
      showSuccessMessage(
          message: AppString.profile_update_successfully_text.tr);
    }

    isLoading(false);
  }

  void changePassword(
      {required String currentPassword, required String newPassword}) async {
    isLoading(true);
    try {
      final response = await NetworkClient().postRequest(Api.CHANGE_PASSWORD, {
        "oldPassword": currentPassword,
        "newPassword": newPassword,
        "accessToken": GetStorage().read(AppString.ACCESS_TOKEN) ?? ""
      });

      if (response.status.hasError) {
        logErrorMessage(logName: "changePassword", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                "Some Error occur!");
      } else {
        logSuccessMessage(
            logName: "submitVerificationCode", response: response);
        Get.offAllNamed(Routes.MAIN_SCREEN);
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading(false);
  }
}
