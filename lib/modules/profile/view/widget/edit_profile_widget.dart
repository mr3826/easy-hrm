import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../leave/view/widget/custom_title_text_widget.dart';
import '../../controller/profile_image_selected_controller.dart';
import '../../controller/update_profile_controller.dart';

class TextFiledLayout extends StatelessWidget {
  final dynamic formKey;
  const TextFiledLayout({super.key, this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userFirstName(),
        _userLastName(),
        _userAddress(),
        _userPhoneNumber(),
        _userEmergencyPhoneNumber(),
        _userPersonalBio(),
        customSpacerHeight(height: 20),
        CustomDoubleAppButton(
            buttonText: AppString.text_save.tr,
            onAction: () {
              final variables = _addVariables();
              variables?.forEach((key, value) {print("key $key value:: $value");});
              if (formKey.currentState!.validate()) {
                Get.find<UpdateProfileController>()
                    .updateUserProfile(variables!);
              }
            },
            cancelAction: () {
              _clearInputField();
              Get.find<PikedProfileImgController>()
                  .storageForUpload
                  .filePath
                  .value = "";
              Get.back();
            }),
        customSpacerHeight(height: AppLayout.getHeight(80)),
      ],
    );
  }
}

void _clearInputField() {
  editBioController.clear();
  editEmergencyPhoneController.clear();
  editPhoneController.clear();
  editAddressController.clear();
  editLastNameController.clear();
  editFirstNameController.clear();
}

Map<String, dynamic>? _addVariables() {
  Map<String, dynamic> inputData = {};

  inputData["about"] = editBioController.text;

  inputData["emergency_phone_number"] = editEmergencyPhoneController.text;

  inputData["personal_phone_number"] = editPhoneController.text;

  inputData["address"] = editAddressController.text;

  inputData["last_name"] = editLastNameController.text;

  if (editFirstNameController.text.isNotEmpty) {
    inputData["first_name"] = editFirstNameController.text;
  } else {
    inputData["first_name"] = Get.find<UserProfileController>()
            .userDetails
            ?.getOrganizationUserDetails
            ?.profile
            ?.firstName ??
        "";
  }

  inputData["org_user_id"] = GetStorage().read(AppString.ORGANIZATION_USER_ID);

  inputData["department_id"] = Get.find<UserProfileController>()
          .userDetails
          ?.getOrganizationUserDetails
          ?.department
          ?.id ??
      "";

  // inputData["employment_status_id"] =
  //     Get.find<UserProfileController>()
  //         .employeeWorkHistory
  //         ?.getOrganizationUserHistory
  //         ?.employmentHistories?[0]
  //         .employmentStatus
  //         ?.id ??
  //     "";



  inputData["image"] = "files/${GetStorage().read(AppString.ORGANIZATION_ID)}/org-user/${Get.find<UpdateProfileController>()
      .uploadPolicyResponse
      .getUploadPolicy
      ?.policyData
      ?.firstWhere((e) => e.name == 'key'.toLowerCase())
      .value
      ?.split("/")
      .last ??
      ""}";

  return inputData;
}

_userPersonalBio() {
  return userTextFieldLayout(
      hintText: AppString.text_bio.tr,
      titleText: AppString.text_bio.tr,
      isRequired: false,
      controller: editBioController,
      isNoteFieldVisible: true);
}

_userEmergencyPhoneNumber() {
  return userTextFieldLayout(
      isRequired: false,
      hintText: AppString.text_emergency_phone.tr,
      titleText: AppString.text_emergency_phone.tr,
      controller: editEmergencyPhoneController);
}

_userPhoneNumber() {
  return userTextFieldLayout(
      isRequired: false,
      hintText: AppString.text_phone.tr,
      titleText: AppString.text_phone.tr,
      controller: editPhoneController);
}

_userAddress() {
  return userTextFieldLayout(
      isRequired: false,
      titleText: AppString.text_address.tr,
      controller: editAddressController,
      hintText: AppString.text_address.tr);
}

_userLastName() {
  return userTextFieldLayout(
      hintText: AppString.text_last_name.tr,
      titleText: AppString.text_last_name.tr,
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_last_name_field_is_required.tr;
        } else {
          return null;
        }
      },
      controller: editLastNameController);
}

_userFirstName() {
  return userTextFieldLayout(
      hintText: AppString.text_first_name.tr,
      titleText: AppString.text_first_name.tr,
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_first_name_field_is_required.tr;
        } else {
          return null;
        }
      },
      controller: editFirstNameController);
}

userTextFieldLayout(
    {required String titleText,
    required TextEditingController controller,
    required String hintText,
    bool isNoteFieldVisible = false,
    bool isRequired = true,
    validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customTitleText(text: titleText, isRequired: isRequired),
      customSpacerHeight(height: 12),
      isNoteFieldVisible != false
          ? InputNote(
              controller: editBioController,
              hintText: hintText,
            )
          : CustomInputField(
              hint: hintText ?? titleText,
              controller: controller,
              validator: validator,
            ),
      customSpacerHeight(height: 12),
    ],
  );
}
