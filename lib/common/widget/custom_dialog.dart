import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

 showCustomAlertDialog({
  required BuildContext context,
   IconData? iconData,
  Widget? iconWidget,
  Widget? titleContent,
  Widget? descriptionContent,
  double? descriptionFontSize,
   String ?titleText,
   String ?descriptionText,
  double paddingHorizontal = 20.0,
  double paddingVertical = 20.0,
  double buttonSpacing = 12.0,
  required Function() onConfirm,
  required String confirmButtonText,
  Widget? confirmButtonChild,
   String? extraInfoText,
  Widget? actionButtonWidget,
  required Color iconBackgroundColor,
  required Color confirmButtonColor,
  Color ? closeButtonColor, // Added close button color with default value
}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding:
        EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget ??
                CircleAvatar(
                  backgroundColor: iconBackgroundColor.withOpacity(0.2),
                  radius: 32,
                  child: Icon(
                    iconData,
                    size: 40,
                    color: confirmButtonColor,
                  ),
                ),
            customSpacerHeight(height: 12),
            titleContent??   Text(
              titleText??"",
              textAlign: TextAlign.center,
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeMid-2

              ),
            ),
            customSpacerHeight(height: 12),
            Center(
              child: descriptionContent?? Text(
                descriptionText??"",
                textAlign: TextAlign.center,
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: descriptionFontSize ?? Dimensions.fontSizeDefault-2,
                ),
              ),
            ),
            Center(
              child:Text(
                extraInfoText??"",
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 3,
                ),
              ),
            ),
            customSpacerHeight(height: buttonSpacing),
            actionButtonWidget ??
                CustomDoubleAppButton(
                  buttonText: confirmButtonText,
                  onAction: onConfirm,
                  cancelAction: () => Get.back(),
                  btnColor: confirmButtonColor,
                  saveBtn: confirmButtonChild,
                  cancelBtnColor: closeButtonColor,
                ),
          ],
        ),
      ),
    ),
  );
}






void displayCustomDialog({
  required BuildContext context,
  IconData? icon,
  Widget? customIconWidget,
  Widget? customTitleWidget,
  Widget? customDescriptionWidget,
  double? descriptionFontSize,
  String? titleText,
  String? descriptionText,
  double horizontalPadding = 20.0,
  double verticalPadding = 20.0,
  double buttonSpacing = 25.0,
  Function()? onConfirmAction,
  String? confirmButtonText,
  Widget? confirmButtonChild,
  String? additionalInfoText,
  Widget? customActionButtons,
  Color?iconBackgroundColor,
  Color ?confirmButtonColor,
  Color? cancelButtonColor, // Custom cancel button color
}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Section
            customIconWidget ??
                CircleAvatar(
                  backgroundColor: iconBackgroundColor?.withOpacity(0.2),
                  radius: 32,
                  child: Icon(
                    icon,
                    size: 40,
                    color: confirmButtonColor,
                  ),
                ),
            const SizedBox(height: 12),

            // Title Section
            customTitleWidget ??
                Text(
                  titleText ?? "",
                  textAlign: TextAlign.center,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.fontSizeMid - 2,
                  ),
                ),
            const SizedBox(height: 12),

            // Description Section
            customDescriptionWidget ??
                Text(
                  descriptionText ?? "",
                  textAlign: TextAlign.center,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: descriptionFontSize ?? Dimensions.fontSizeSmall ,
                  ),
                ),

            // Additional Info Section
            if (additionalInfoText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  additionalInfoText,
                  textAlign: TextAlign.center,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: Dimensions.fontSizeDefault - 3,
                  ),
                ),
              ),
            SizedBox(height: buttonSpacing),

            // Action Buttons Section
            customActionButtons ??
                CustomDoubleAppButton(
                  buttonText: confirmButtonText,
                  onAction: onConfirmAction??(){},
                  cancelAction: () => Navigator.of(context).pop(),
                  btnColor: confirmButtonColor??Colors.blue,
                  saveBtn: confirmButtonChild,
                  cancelBtnColor: cancelButtonColor,
                ),
          ],
        ),
      ),
    ),
  );
}



















