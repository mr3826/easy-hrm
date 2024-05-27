
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../common/domain/error_model.dart';
import '../../../common/domain/upload_policy.dart';
import '../../../common/widget/error_message.dart';
import '../../../network/exception_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';

class UpdateProfileController extends GetxController {
  final isLoading = false.obs;
  final isUploadPolicyLoading = false.obs;
  final isFileUploadedSuccessfully = false.obs;
  UploadPolicyResponse uploadPolicyResponse = UploadPolicyResponse();

  void updateUserProfile(Map<String, dynamic> variables) async {


    variables.forEach((key, value) { print("key:: $key value:: $value");});

    isLoading(true);
    final response = await NetworkClient()
        .mutationGraphData(updateUserProfileMutation, {"inputData": variables});



    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      Get.find<UserProfileController>().getUserProfile();
      Get.back();
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
        showSuccessMessage(message: AppString.passwordChangeSuccessfulMessage);
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        Get.offAllNamed(Routes.MAIN_SCREEN);
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading(false);
  }

  getUploadPolicy({fileName}) async {
    print(
        "${DateTime.now().millisecondsSinceEpoch.toString()}.${fileName.split('.').last}");
    isUploadPolicyLoading(true);

    final response = await NetworkClient()
        .getGraphQuery(queryString: getUploadPolicyQuery, variables: {
      "queryData": {
        "sub_folder_name": GetStorage().read(AppString.ORGANIZATION_ID),
        "filename":
            "${DateTime.now().millisecondsSinceEpoch.toString()}.${fileName.split('.').last}",
        "directive": "Files"
      }
    });

    print("get policy ::: $response");

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      uploadPolicyResponse = UploadPolicyResponse.fromJson(response.data!);
      uploadFile(
          url: uploadPolicyResponse.getUploadPolicy?.url ?? "",
          fileName: fileName,
          list: uploadPolicyResponse.getUploadPolicy?.policyData);
    }
    isUploadPolicyLoading(false);
  }

  uploadFile(
      {required String fileName,
      List<PolicyData>? list,
      required String url}) async {
    if (list == null || url.isEmpty) return;
    isUploadPolicyLoading(true);

    FormData formData = FormData({});
    for (var data in list) {
      formData.fields.add(MapEntry(data.name!, data.value!));
    }

    formData.files.add(MapEntry(
        "file",
        MultipartFile(File(fileName),
            filename:
                "${DateTime.now().millisecondsSinceEpoch.toString()}.${fileName.split('.').last}")));

    await NetworkClient().post(url, formData).then((value) {
      print(value.statusCode);
      isFileUploadedSuccessfully.value = true;
    }, onError: (_) => isFileUploadedSuccessfully.value = false);
    isUploadPolicyLoading(false);
  }
}
