import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_inside_appbar.dart';
import 'package:payrun_mobile/common/widget/custom_network_image.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/update_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/utils.dart';
import '../../controller/profile_image_selected_controller.dart';
import '../widget/edit_profile_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    textFiledLayout()
                  ],
                ),
              ),
            )),
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

  _profileSectionLayout(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _profileImageLayout(),
        customSpacerWidth(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   AppString.text_update_your_profile.tr,
            //   style: AppStyle.mid_large_text
            //       .copyWith(color: AppColor.normalTextColor,overflow: TextOverflow.ellipsis),
            // ),
            // Text(
            //   AppString.text_upload_a_photo_undar_2mb.tr,
            //   style: AppStyle.mid_large_text.copyWith(
            //       color: AppColor.hintColor,
            //       fontSize: Dimensions.fontSizeDefault - 1),
            // ),
            // customSpacerHeight(height: 8),


            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text:"${AppString.text_update_your_profile.tr} ",
                      style: AppStyle.mid_large_text
                          .copyWith(color: AppColor.normalTextColor,overflow: TextOverflow.ellipsis),),
                    TextSpan(
                      text:AppString.text_upload_a_photo_undar_2mb.tr,
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
    return CustomNetworkImage(
        height: 37,
        imgUrl:
            "${Api.PUBLIC_IMAGE_URL_DOMAIN}/files/${GetStorage().read(AppString.ORGANIZATION_ID)}/${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.image}");
  }
}
