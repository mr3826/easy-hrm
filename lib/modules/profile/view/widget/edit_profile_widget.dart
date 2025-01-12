import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/widget/phone_number_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../utils/app_style.dart';
import '../../../../common/widget/custom_title_text_widget.dart';
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
        _phoneNumberInputField(),
        customSpacerHeight(height: 14),
        _userEmergencyPhoneNumber(),
        _userPersonalBio(),
        customSpacerHeight(height: 20),
        Obx(
          () => CustomDoubleAppButton(
              buttonText: AppString.text_save.tr,
              onAction:
                  Get.find<UserProfileController>().isEnableEditButton == false
                      ? () {}
                      : () {
                          final variables = _addVariables();

                          if (formKey.currentState!.validate()) {
                            Get.find<UpdateProfileController>()
                                .updateUserProfile(variables!);
                          }
                        },
              btnColor:
                  Get.find<UserProfileController>().isEnableEditButton == true
                      ? AppColor.primaryColor
                      : AppColor.primaryColor.withOpacity(0.5),
              cancelAction: () {
                _clearInputField();
                Get.find<PikedProfileImgController>()
                    .storageForUpload
                    .filePath
                    .value = "";

                Get.back();
                Get.back();
              }),
        ),
        customSpacerHeight(height: AppLayout.getHeight(80)),
      ],
    );
  }
}

_phoneNumberInputField() {
  return Column(
    children: [
      customTitleText(
        text: AppString.text_phone.tr,
      ),
      customSpacerHeight(height: 12),
      const PersonalPhoneNumber(),
    ],
  );
}

_userEmergencyPhoneNumber() {
  return Column(
    children: [
      customTitleText(
        text: AppString.text_emergency_phone.tr,
      ),
      customSpacerHeight(height: 12),
      const EmergencyPhoneNumber(),
      customSpacerHeight(height: 12),
    ],
  );
}

void _clearInputField() {
  UserProfileController controller = Get.find<UserProfileController>();
  controller.firstName.value = "";
  controller.lastName.value = "";
  controller.address.value = "";
  controller.description.value = "";
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

  // Set emergency phone number with country code if updated
  _addInputPersonalPhoneNumber(inputData);

  // Set personal phone number with country code if updated
  _addInputEmergencyPhoneNumber(inputData);

  inputData["address"] = editAddressController.text;

  inputData["last_name"] = editLastNameController.text;

  // Set user first name
  _addInputUserFirstName(inputData);

  inputData["org_user_id"] = GetStorage().read(AppString.ORGANIZATION_USER_ID);

  inputData["department_id"] = Get.find<UserProfileController>()
          .userDetails
          ?.getOrganizationUserDetails
          ?.department
          ?.id ??
      "";

  inputData["image"] =
      "files/${GetStorage().read(AppString.ORGANIZATION_ID)}/org-user/${Get.find<UpdateProfileController>().uploadPolicyResponse.getUploadPolicy?.policyData?.firstWhere((e) => e.name == 'key'.toLowerCase()).value?.split("/").last ?? ""}";
  // Set image path if there is an uploaded profile image
  _addInputProfileImage(inputData);

  return inputData;
}

void _addInputProfileImage(Map<String, dynamic> inputData) {
  if (Get.find<PikedProfileImgController>()
      .storageForUpload
      .filePath
      .value
      .isNotEmpty) {
    inputData["image"] =
        "files/${GetStorage().read(AppString.ORGANIZATION_ID)}/org-user/${Get.find<UpdateProfileController>().uploadPolicyResponse.getUploadPolicy?.policyData?.firstWhere((e) => e.name == 'key'.toLowerCase()).value?.split("/").last ?? ""}";
  }
}

void _addInputUserFirstName(Map<String, dynamic> inputData) {
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
}

void _addInputPersonalPhoneNumber(Map<String, dynamic> inputData) {
  if (editPhoneController.text.isEmpty) {
    inputData["personal_phone_number"] = "";
  } else {
    inputData["personal_phone_number"] =
        Get.find<UpdateProfileController>().initialPersonalPhoneNumber.value;
  }
}

void _addInputEmergencyPhoneNumber(Map<String, dynamic> inputData) {
  if (editEmergencyPhoneController.text.isEmpty) {
    inputData["emergency_phone_number"] = "";
  } else {
    inputData["emergency_phone_number"] =
        Get.find<UpdateProfileController>().initialEmergencyPhoneNumber.value;
  }
}

_userPersonalBio() {
  return userTextFieldLayout(
      hintText: AppString.text_bio.tr,
      titleText: AppString.text_bio.tr,
      isRequired: false,
      onChanged: (String? value) {
        Get.find<UserProfileController>().description.value = value!;
      },
      controller: editBioController,
      isNoteFieldVisible: true);
}

_userAddress() {
  return userTextFieldLayout(
      isRequired: false,
      onChanged: (String? value) {
        Get.find<UserProfileController>().address.value = value!;
      },
      titleText: AppString.text_address.tr,
      controller: editAddressController,
      hintText: AppString.text_address.tr);
}

_userLastName() {
  return userTextFieldLayout(
      hintText: AppString.text_last_name.tr,
      titleText: AppString.text_last_name.tr,
      onChanged: (String? value) {
        Get.find<UserProfileController>().lastName.value = value!;
      },
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
      onChanged: (String? value) {
        Get.find<UserProfileController>().firstName.value = value!;
      },
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
    final String? Function(String?)? onChanged,
    final TextInputType? textInputType,
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
              onChanged: onChanged,
              maxLength: 150,
            )
          : CustomInputField(
              hint: hintText,
              hintStyle: AppStyle.normal_text_grey
                  .copyWith(fontWeight: FontWeight.w500),
              controller: controller,
              textInputType: textInputType,
              validator: validator,
              onChanged: onChanged,
            ),
      customSpacerHeight(height: 12),
    ],
  );
}
