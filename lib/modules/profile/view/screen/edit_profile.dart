import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_inside_appbar.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/common/widget/warning_message.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/update_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../common/widget/custom_network_image.dart';
import '../../../../utils/utils.dart';
import '../../controller/profile_image_selected_controller.dart';
import '../widget/edit_profile_widget.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: customInsideAppbar(
            title: AppString.text_edit_profile.tr,
            onPressAction: () {
              _clearInputField();
              Get.back();
            }),
        body: Obx(() => Get.find<UpdateProfileController>().isLoading.isTrue
            ? const LoadingIndicator()
            : Padding(
                padding: marginLayout,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _profileSectionLayout(context),
                      customSpacerHeight(height: 30),
                      TextFiledLayout(
                        formKey: _formKey,
                      )
                    ],
                  ),
                ),
              )),
      ),
    );
  }

  void _clearInputField() {
    editBioController.clear();
    editEmergencyPhoneController.clear();
    editPhoneController.clear();
    editAddressController.clear();
    editLastNameController.clear();
    editFirstNameController.clear();
    Get.find<PikedProfileImgController>().storageForUpload.filePath.value = "";
  }

  _profileSectionLayout(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => _profileImageLayout()),
        customSpacerWidth(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${AppString.text_update_your_profile.tr} ",
                      style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.normalTextColor,
                          overflow: TextOverflow.ellipsis),
                    ),
                    TextSpan(
                      text: AppString.text_upload_a_photo_undar_2mb.tr,
                      style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            customSpacerHeight(height: 6),
            Row(
              children: [
                _uploadBtnLayout(),
                customSpacerWidth(width: 12),
                _removeBtnLayout(context)
              ],
            ),
          ],
        ),
      ],
    );
  }

  _uploadBtnLayout() {
    return GestureDetector(
      onTap: () {
        Get.find<PikedProfileImgController>().storageForUpload.pickFile();
      },
      child: SizedBox(
        height: AppLayout.getHeight(36),
        width: AppLayout.getWidth(100),
        child: Card(
          elevation: 0,
          color: AppColor.secondaryColor,
          shape: roundedRectangleBorder.copyWith(
              borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
          child: Center(
            child: Text(
              AppString.text_upload.tr,
              style: AppStyle.mid_large_text
                  .copyWith(fontSize: Dimensions.fontSizeDefault),
            ),
          ),
        ),
      ),
    );
  }

  _removeBtnLayout(context) {
    return GestureDetector(
        onTap: () {
          customDialog(
              context: context,
              saveBtnAction: () {
                Get.find<PikedProfileImgController>()
                    .storageForUpload
                    .filePath
                    .value = "";

                final variables = _addVariables();

                if (editFirstNameController.text.isNotEmpty &&
                    editLastNameController.text.isNotEmpty) {
                  Get.find<UpdateProfileController>()
                      .updateUserProfile(variables!);
                } else {
                  showWarningMessage(
                      message: "First and last name field is required!");
                }

                Get.find<PikedProfileImgController>()
                        .storageForUpload
                        .filePath
                        .value
                        .isEmpty
                    ? Get.back()
                    : Container();
              },
              icon: Icons.delete_outline_outlined,
              titleText: AppString.text_remove_photo.tr,
              subText: AppString.text_sure_you_want_to_deleted_this_photo.tr,
              iconBgColor: AppColor.errorColorLight,
              btnBgColor: AppColor.errorColorLight,
              btnText: AppString.text_remove.tr,
              drcText: "");
        },
        child: Text(
          AppString.text_remove_photo.tr,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.pendingColor,
              fontSize: Dimensions.fontSizeDefault),
        ));
  }

  _profileImageLayout() {
    return Get.find<PikedProfileImgController>()
            .storageForUpload
            .filePath
            .value
            .isNotEmpty
        ? CircleAvatar(
            radius: 42,
            backgroundColor: AppColor.hintColor.withOpacity(0.8),
            child: CircleAvatar(
              backgroundColor: AppColor.cardColor,
              radius: 41,
              child: _imageLayout(),
            ))
        : _placeholderImage();
  }
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

  inputData["employment_status_id"] = Get.find<UserProfileController>()
          .employeeWorkHistory
          ?.getOrganizationUserHistory
          ?.employmentHistories?[0]
          .employmentStatus
          ?.id ??
      "";

  inputData["image"] = "";

  return inputData;
}

Widget _imageLayout() {
  if (Get.find<UpdateProfileController>().isFileUploadedSuccessfully.isTrue &&
      Get.find<UpdateProfileController>().isUploadPolicyLoading.isFalse) {
    /// file image
    return _selectedImageViewLayout();
  } else if (Get.find<UpdateProfileController>()
          .isFileUploadedSuccessfully
          .isFalse &&
      Get.find<UpdateProfileController>().isUploadPolicyLoading.isFalse) {
    if (Get.find<PikedProfileImgController>()
        .storageForUpload
        .filePath
        .isEmpty) {
      /// initial stage
      return _placeholderImage();
    } else {
      /// broken image
      if (Get.find<UpdateProfileController>().isUploadPolicyLoading.isFalse) {
        return _brokenImageViewLayout();
      } else {
        return const Center(
            child: CupertinoActivityIndicator(
          color: AppColor.primaryColor,
        ));
      }
    }
  } else {
    return const Center(
        child: CupertinoActivityIndicator(
      color: AppColor.primaryColor,
    ));
  }
}

Widget _brokenImageViewLayout() {
  return CircleAvatar(
    radius: 39,
    backgroundColor: AppColor.primaryColor,
    backgroundImage: AssetImage(Images.PLACEHOLDER),
  );
}

_placeholderImage() {
  return CustomNetworkImage(
      height: 42,
      imgUrlKey:
          "${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.image}");
}

Widget _selectedImageViewLayout() {
  return CircleAvatar(
    radius: 39,
    backgroundColor: AppColor.primaryColor,
    backgroundImage: FileImage(File(Get.find<PikedProfileImgController>()
            .storageForUpload
            .filePath
            .value)
        .absolute),
  );
}
