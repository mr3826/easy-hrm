import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

 customDialog({
  required BuildContext context,
   IconData? icon,
  Widget? iconWidget,
  double? drcFontSize,
  required String titleText,
  required String subText,
  double horizontalPadding = 20.0,
  double verticalPadding = 20.0,
  double btnPadding = 12.0,
  required Function() saveBtnAction,
  required String btnText,
  Widget? childForSaveBtn,
  required String drcText,
  Widget? btnWidget,
  required Color iconBgColor,
  required Color btnBgColor,
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
        EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget ??
                CircleAvatar(
                  backgroundColor: iconBgColor.withOpacity(0.2),
                  radius: 32,
                  child: Icon(
                    icon,
                    size: 40,
                    color: btnBgColor,
                  ),
                ),
            customSpacerHeight(height: 12),
            Text(
              titleText,
              textAlign: TextAlign.center,
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeMid-2

              ),
            ),
            customSpacerHeight(height: 12),
            Center(
              child: Text(
                subText,
                textAlign: TextAlign.center,
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: drcFontSize ?? Dimensions.fontSizeDefault-2,
                ),
              ),
            ),
            Center(
              child: Text(
                drcText,
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 3,
                ),
              ),
            ),
            customSpacerHeight(height: btnPadding),
            btnWidget ??
                CustomDoubleAppButton(
                  buttonText: btnText,
                  onAction: saveBtnAction,
                  cancelAction: () => Get.back(),
                  btnColor: btnBgColor,
                  saveBtn: childForSaveBtn,
                  cancelBtnColor: closeButtonColor,
                ),
          ],
        ),
      ),
    ),
  );
}
