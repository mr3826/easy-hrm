import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';

import '../../controller/update_profile_controller.dart';

Widget textFiledLayout() {
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
            if (variables!.containsKey("about") ||
                variables.containsKey("emergency_phone_number") ||
                variables.containsKey("personal_phone_number") ||
                variables.containsKey("address") ||
                variables.containsKey("last_name") ||
                editFirstNameController.text.isNotEmpty) {
              print(variables);
              Get.find<UpdateProfileController>().updateUserProfile(variables);
            }
          },
          cancelAction: () {
            _clearInputField();
            Get.back();
          }),
      customSpacerHeight(height: AppLayout.getHeight(80)),
    ],
  );
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
  if (editBioController.text.isNotEmpty) {
    inputData["about"] = editBioController.text;
  }
  if (editEmergencyPhoneController.text.isNotEmpty) {
    inputData["emergency_phone_number"] = editEmergencyPhoneController.text;
  }
  if (editPhoneController.text.isNotEmpty) {
    inputData["personal_phone_number"] = editPhoneController.text;
  }
  if (editAddressController.text.isNotEmpty) {
    inputData["address"] = editAddressController.text;
  }
  if (editLastNameController.text.isNotEmpty) {
    inputData["last_name"] = editLastNameController.text;
  }
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
  inputData["org_user_id"] = "4ce59a0e-4180-4a51-b654-8dd9e5b3d64c";
  inputData["department_id"] = Get.find<UserProfileController>()
          .userDetails
          ?.getOrganizationUserDetails
          ?.department
          ?.id ??
      "";
  inputData["employment_status_id"] = Get.find<UserProfileController>()
          .employeeWorkHistory
          ?.getOrganizationUserHistory
          ?.employmentHistories?[0]
          .employmentStatus
          ?.id ??
      "";

  return inputData;
}

_userPersonalBio() {
  return userTextFieldLayout(
      hintText: Get.find<UserProfileController>()
              .userDetails
              ?.getOrganizationUserDetails
              ?.profile
              ?.about ??
          AppString.text_bio.tr,
      titleText: AppString.text_bio.tr,
      controller: editBioController,
      isNoteFieldVisible: true);
}

_userEmergencyPhoneNumber() {
  return userTextFieldLayout(
      hintText: Get.find<UserProfileController>()
              .userDetails
              ?.getOrganizationUserDetails
              ?.profile
              ?.emergencyNumber ??
          AppString.text_emergency_phone.tr,
      titleText: AppString.text_emergency_phone.tr,
      controller: editEmergencyPhoneController);
}

_userPhoneNumber() {
  return userTextFieldLayout(
      hintText: Get.find<UserProfileController>()
              .userDetails
              ?.getOrganizationUserDetails
              ?.profile
              ?.personalNumber ??
          AppString.text_phone.tr,
      titleText: AppString.text_phone.tr,
      controller: editPhoneController);
}

_userAddress() {
  return userTextFieldLayout(
      titleText: AppString.text_address.tr,
      controller: editAddressController,
      hintText: Get.find<UserProfileController>()
              .userDetails
              ?.getOrganizationUserDetails
              ?.profile
              ?.address ??
          AppString.text_address.tr);
}

_userLastName() {
  return userTextFieldLayout(
      hintText: Get.find<UserProfileController>()
              .userDetails
              ?.getOrganizationUserDetails
              ?.profile
              ?.lastName ??
          AppString.text_last_name.tr,
      titleText: AppString.text_last_name.tr,
      controller: editLastNameController);
}

_userFirstName() {
  return userTextFieldLayout(
      hintText: Get.find<UserProfileController>()
              .userDetails
              ?.getOrganizationUserDetails
              ?.profile
              ?.firstName ??
          AppString.text_first_name.tr,
      titleText: AppString.text_first_name.tr,
      controller: editFirstNameController);
}

userTextFieldLayout(
    {required titleText,
    required TextEditingController controller,
    hintText,
    isNoteFieldVisible = false,
    validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$titleText",
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault + 2),
      ),
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
