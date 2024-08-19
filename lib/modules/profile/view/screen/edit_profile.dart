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
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
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

  _profileSectionLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => _profileImageLayout()),
        customSpacerWidth(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                width: double.infinity,
                child: Text(
                  AppString.text_update_your_profile.tr,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
              Text(
                AppString.text_upload_a_photo_undar_2mb.tr,
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 1,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              customSpacerHeight(height: 6),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(child: _uploadBtnLayout()),
                    customSpacerWidth(width: 12),
                    Expanded(child: _removeBtnLayout(context)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _uploadBtnLayout() {
    return GestureDetector(
      onTap: () {
        Get.find<PikedProfileImgController>().storageForUpload.pickFile();
      },
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
    );
  }

  // _removeBtnLayout(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       final pikedProfileImgController = Get.find<PikedProfileImgController>();
  //       final userProfileController = Get.find<UserProfileController>();
  //
  //       // Ensure null checks are properly performed
  //       final storageFilePath =
  //           pikedProfileImgController.storageForUpload.filePath.value;
  //       final userDetails = userProfileController.userDetails;
  //       final profileImage =
  //           userDetails?.getOrganizationUserDetails?.profile?.image;
  //       print("profileImage ::: $profileImage");
  //
  //       if (storageFilePath.isNotEmpty == true || profileImage?.isNotEmpty == true) {
  //
  //         customDialog(
  //           context: context,
  //           saveBtnAction: () {
  //             pikedProfileImgController.storageForUpload.filePath.value = "";
  //
  //             final variables = _addVariables();
  //
  //             if (editFirstNameController.text.isNotEmpty &&
  //                 editLastNameController.text.isNotEmpty) {
  //               Get.find<UpdateProfileController>()
  //                   .updateUserProfile(variables!);
  //             } else {
  //               showWarningMessage(
  //                 message: AppString.text_first_and_last_field_is_requured.tr,
  //               );
  //             }
  //
  //             if (pikedProfileImgController
  //                 .storageForUpload.filePath.value.isEmpty) {
  //               Get.back();
  //             }
  //           },
  //           icon: Icons.delete_outline_outlined,
  //           titleText: AppString.text_remove_photo.tr,
  //           subText: AppString.text_sure_you_want_to_deleted_this_photo.tr,
  //           iconBgColor: AppColor.errorColorLight,
  //           btnBgColor: AppColor.errorColorLight,
  //           btnText: AppString.text_remove.tr,
  //           drcText: "",
  //         );
  //       }
  //     },
  //     child: Text(
  //       AppString.text_remove_photo.tr,
  //       maxLines: 1,
  //       style: AppStyle.mid_large_text.copyWith(
  //         color: AppColor.pendingColor,
  //         overflow: TextOverflow.ellipsis,
  //         fontSize: Dimensions.fontSizeDefault,
  //       ),
  //     ),
  //   );
  // }




  _removeBtnLayout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final pikedProfileImgController = Get.find<PikedProfileImgController>();
        final userProfileController = Get.find<UserProfileController>();

        final storageFilePath = pikedProfileImgController.storageForUpload.filePath.value;
        final profileImage = userProfileController.userDetails?.getOrganizationUserDetails?.profile?.image;

        if ((storageFilePath.isNotEmpty || _isProfileImageValid(profileImage))) {
          customDialog(
            context: context,
            saveBtnAction: () {
              pikedProfileImgController.storageForUpload.filePath.value = "";

              if (_isProfileInfoValid()) {
                final variables = _addVariables();
                Get.find<UpdateProfileController>().updateUserProfile(variables!);
              } else {
                showWarningMessage(
                  message: AppString.text_first_and_last_field_is_requured.tr,
                );
              }

              if (pikedProfileImgController.storageForUpload.filePath.value.isEmpty) {
                Get.back();
              }
            },
            icon: Icons.delete_outline_outlined,
            titleText: AppString.text_remove_photo.tr,
            subText: AppString.text_sure_you_want_to_deleted_this_photo.tr,
            iconBgColor: AppColor.errorColorLight,
            btnBgColor: AppColor.errorColorLight,
            btnText: AppString.text_remove.tr,
            drcText: "",
          );
        }
      },
      child: Text(
        AppString.text_remove_photo.tr,
        maxLines: 1,
        style: AppStyle.mid_large_text.copyWith(
          color: AppColor.pendingColor,
          overflow: TextOverflow.ellipsis,
          fontSize: Dimensions.fontSizeDefault,
        ),
      ),
    );
  }

  bool _isProfileImageValid(String? profileImage) {
    if (profileImage == null || profileImage.isEmpty) return false;
    return _hasValidImageExtension(profileImage);
  }

  bool _hasValidImageExtension(String key) {
    List<String> validExtensions = ['.jpeg', '.jpg', '.png'];
    return validExtensions.any((ext) => key.toLowerCase().endsWith(ext));
  }

  bool _isProfileInfoValid() {
    return editFirstNameController.text.isNotEmpty &&
        editLastNameController.text.isNotEmpty;
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
  return const CircleAvatar(
    radius: 39,
    backgroundColor: AppColor.cardColor,
    child: CupertinoActivityIndicator(color: AppColor.primaryColor),
  );
}

_placeholderImage() {
  return CustomNetworkImage(
    errorText: (Get.find<UserProfileController>()
                        .userDetails
                        ?.getOrganizationUserDetails
                        ?.profile
                        ?.firstName !=
                    null &&
                Get.find<UserProfileController>()
                    .userDetails!
                    .getOrganizationUserDetails!
                    .profile!
                    .firstName!
                    .isNotEmpty) &&
            (Get.find<UserProfileController>()
                        .userDetails
                        ?.getOrganizationUserDetails
                        ?.profile
                        ?.lastName !=
                    null &&
                Get.find<UserProfileController>()
                    .userDetails!
                    .getOrganizationUserDetails!
                    .profile!
                    .lastName!
                    .isNotEmpty)
        ? "${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.firstName?[0].toUpperCase() ?? ""}"
            "${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.lastName?[0].toUpperCase() ?? ""}"
        : "",
    height: 42,
    profileImageKey:
        "${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.image}",
    imgUrlKey: '',
  );
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
