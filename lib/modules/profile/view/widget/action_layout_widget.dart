import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../common/widget/custom_drawer.dart';
import '../../controller/user_profile_controller.dart';
import '../screen/change_password.dart';

Widget actionLayout(
    {required userName,
    required departmentText,
    required editAction,
    changePassAction,
    required context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customButtonSheetAppbar(text: "$userName", subtext: "$departmentText"),
      customSpacerHeight(height: 20),
      InkWell(
          onTap: () {
            editFirstNameController.text = Get.find<UserProfileController>()
                    .userDetails
                    ?.getOrganizationUserDetails
                    ?.profile
                    ?.firstName ??
                "";
            editLastNameController.text = Get.find<UserProfileController>()
                    .userDetails
                    ?.getOrganizationUserDetails
                    ?.profile
                    ?.lastName ??
                "";
            editAddressController.text = Get.find<UserProfileController>()
                    .userDetails
                    ?.getOrganizationUserDetails
                    ?.profile
                    ?.address ??
                "";
            editPhoneController.text = Get.find<UserProfileController>()
                    .userDetails
                    ?.getOrganizationUserDetails
                    ?.profile
                    ?.personalNumber ??
                "";
            editEmergencyPhoneController.text =
                Get.find<UserProfileController>()
                        .userDetails
                        ?.getOrganizationUserDetails
                        ?.profile
                        ?.emergencyNumber ??
                    "";
            editBioController.text = Get.find<UserProfileController>()
                    .userDetails
                    ?.getOrganizationUserDetails
                    ?.profile
                    ?.about ??
                "";

            Get.toNamed(Routes.EDIT_PROFILE_SCREEN);
          },
          child: _fieldLayout(
              hintText: AppString.text_edit_profile.tr,
              onAction: editAction,

          url: Images.EDIT_ICON
          )),
      InkWell(
          onTap: () {
            customAntButtonSheet(
                context: context, child: ChangePasswordScreen());
          },
          child: _fieldLayout(
              hintText: AppString.text_change_password.tr,
              onAction: changePassAction,
              url: Images.KEY_ICON

          )),
    ],
  );
}

Widget _fieldLayout(
    {required hintText, required onAction, required url}) {
  return Padding(
    padding: marginLayout,
    child: Column(
      children: [
        customSpacerHeight(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$hintText",
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
            Text(
              "",
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
            Text(
              "",
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
            Image.asset(url,height: AppLayout.getHeight(50),width: AppLayout.getWidth(50),)
          ],
        ),
        customSpacerHeight(height: 12),
        const Divider(
          thickness: 1,
        ),
      ],
    ),
  );
}

void customAntButtonSheet({context, child}) {
  return showCustomAtmBtnSheet(
      height: 618,
      context: context,
      child: Material(
        color: AppColor.noColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radiusMid),
                topLeft: Radius.circular(Dimensions.radiusMid)),
            color: AppColor.cardColor,
          ),
          child: child,
        ),
      ));
}
