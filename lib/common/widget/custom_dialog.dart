import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../utils/app_color.dart';

customDialog(
    {required context,
    required icon,
    drcFontSize,
    required titleText,
    required subText,
    required saveBtnAction,
    required btnText,
    Widget? childForSaveBtn,
    drcText,
    required iconBgColor,
    required btnBgColor}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  color: AppColor.normalTextColor, fontWeight: FontWeight.w600),
            ),
            customSpacerHeight(height: 12),
            Center(
                child: Text(
              subText,
              textAlign: TextAlign.center,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: drcFontSize ?? Dimensions.fontSizeDefault),
            )),
            Center(
                child: Text(
              drcText,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 3),
            )),
            customSpacerHeight(height: 20),
            CustomDoubleAppButton(
              buttonText: btnText,
              onAction: saveBtnAction,
              cancelAction: () => Get.back(),
              btnColor: btnBgColor,
              saveBtn: childForSaveBtn,
            )
          ],
        ),
      ),
    ),
  );
}
