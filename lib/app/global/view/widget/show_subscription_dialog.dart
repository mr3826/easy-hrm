import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../common/widget/custom_dialog.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/images.dart';


void showSubscriptionDialog(BuildContext context) {
  showCustomAlertDialog(
    context: context,
    onConfirm: () {},
    iconData: Icons.logout,
    paddingHorizontal: 18.0,
    paddingVertical: 16.0,
    buttonSpacing: 0.0,
    // Custom SVG image as the dialog icon
    iconWidget: customSvgImage(
      imageUrl: Images.alert,
      height: 56,
      width: 56,
    ),
    titleText: AppString.text_feature_unavailbe.tr,
    descriptionText: AppString.text_this_functionality_might_etc.tr,
    iconBackgroundColor: AppColor.errorColorLight,
    confirmButtonColor: AppColor.errorColorLight,
    confirmButtonText: AppString.text_log_out.tr,
    extraInfoText: "",
    descriptionFontSize: Dimensions.fontSizeDefault - 2,
    // Action button widget for canceling the dialog
    actionButtonWidget: GestureDetector(
      onTap: () => Get.back(),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Card(
          elevation: 0,
          color: AppColor.cardColor,
          shape: roundedRectangleBorder.copyWith(
            side: BorderSide(
              width: 1.2,
              color: AppColor.hintColor.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              AppString.text_cancel.tr,
              style: AppStyle.small_text_black.copyWith(
                color: AppColor.normalTextColor.withOpacity(0.6),
                fontSize: Dimensions.fontSizeMid - 4,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
