import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/app/modules/profile/controller/profile_image_selected_controller.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'global_profile_controller.dart';
import 'hr_profile_controller.dart';
import '../../../../common/domain/upload_policy.dart';
import '../../../../network/exception_helper.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/utils.dart';
import '../../../../modules/dashboard/presentation/controller/employee_dashboard_controller.dart';
import 'log_out_controller.dart';

class UpdateProfileController extends GetxController {
  final isLoading = false.obs;
  final isUploadPolicyLoading = false.obs;
  final isFileUploadedSuccessfully = false.obs;
  RxString initialEmergencyPhoneNumber = ''.obs;
  RxString initialPersonalPhoneNumber = ''.obs;


  UploadPolicyResponse uploadPolicyResponse = UploadPolicyResponse();

  void updateUserProfile(Map<String, dynamic> variables) async {
    variables.forEach((key, value) {
      print("key:: $key value:: $value");
    });

    isLoading(true);
    final response = await NetworkClient().graphRequest(
        queryString: updateUserProfileMutation,
        variables: {"inputData": variables});

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!, methodName: "updateUserProfile");
    } else {
     Get.find<HrProfileController>().getUserProfile();
     // Get.find<ProfileController>().getUserProfile();
      Get.back(canPop: false);
      Get.back(canPop: false);
      Get.back(canPop: false);
      showSuccessMessage(message: AppString.profile_update_successfully_text.tr);
      Get.find<PikedProfileImgController>().storageForUpload.filePath.value="";
      Get.find<EmployeeDashboardController>().getProfileInfoForDashboard();
    }

    isLoading(false);
  }

  ///change password updated
  Future<void> changePassword(
      {required String currentPassword, required String newPassword}) async {
    isLoading(true);
    try {
      final response = await NetworkClient().postRequest(Api.CHANGE_PASSWORD, {
        "oldPassword": currentPassword,
        "newPassword": newPassword,
        "accessToken": GetStorage().read(AppString.ACCESS_TOKEN) ?? ""
      });

      if (response.statusCode == 200) {
        showSuccessMessage(message: AppString.passwordChangeSuccessfulMessage);
        _clearPasswordFields();
        _handleLogout();
      }
    } catch (e) {
      log("Exception caught: $e");
    } finally {
      isLoading(false); // Stop loading indicator
    }
  }

  void _clearPasswordFields() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  void _handleLogout() {
    GetStorage().remove(AppString.ACCESS_TOKEN);
    GetStorage().remove(AppString.LOGGED_IN);
    removeTokenForOrg(Get.find<ProfileGlobalController>()
        .organizationInfo
        ?.getUserOrganizations
        ?.data
        ?.map((e) => e.organization?.id)
        .toList() ??
        []);
    Get.offAllNamed(Routes.SIGN_IN_SCREEN);
  }

  getUploadPolicy({fileName}) async {
    isUploadPolicyLoading(true);

    final response = await NetworkClient()
        .graphRequest(queryString: getUploadPolicyQuery, variables: {
      "queryData": {
        "sub_folder_name":
            "${GetStorage().read(AppString.ORGANIZATION_ID)}/org-user",
        "filename":
            "${DateTime.now().millisecondsSinceEpoch.toString()}.${fileName.split('.').last}",
        "directive": "Files"
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(
          exception: response.exception!, methodName: "getUploadPolicy");
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
      isFileUploadedSuccessfully.value = true;
    }, onError: (_) => isFileUploadedSuccessfully.value = false);
    isUploadPolicyLoading(false);
  }

}
