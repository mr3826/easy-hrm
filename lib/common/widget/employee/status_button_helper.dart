import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_string.dart';
import '../custom_status_button.dart';

class StatusBtnHelper {
  static Widget approvedStatusBtn() {
    return CustomStatusButton(
      textColor: AppColor.successColor,
      bgColor: AppColor.successColor.withOpacity(0.2),
      text: AppString.text_approved.tr,
      textSize: Dimensions.fontSizeSmall,
      paddingTop: 0,
    );
  }

  static Widget rejectedStatusBtn() {
    return CustomStatusButton(
      textColor: AppColor.errorColorLight,
      bgColor: AppColor.errorColor.withOpacity(0.1),
      text: AppString.text_rejected.tr,
      paddingTop: 0,
      textSize: Dimensions.fontSizeSmall,
    );
  }

  static Widget pendingStatusBtn() {
    return CustomStatusButton(
      textColor: AppColor.pendingColor,
      bgColor: AppColor.pendingColor.withOpacity(0.1),
      text: AppString.text_pendding.tr,
      paddingTop: 0,
      textSize: Dimensions.fontSizeSmall,
    );
  }

  static Widget tokenStatusBtn() {
    return CustomStatusButton(
      textColor: AppColor.primaryColor,
      bgColor: AppColor.primaryColor.withOpacity(0.1),
      text: AppString.text_token.tr,
      paddingTop: 0,
      textSize: Dimensions.fontSizeSmall,
    );
  }

  static Widget cancelStatusBtn() {
    return CustomStatusButton(
      textColor: AppColor.bgColor,
      bgColor: AppColor.errorColorLight.withOpacity(.9),
      text: AppString.text_cancel.tr,
      paddingTop: 0,
      textSize: Dimensions.fontSizeSmall,
    );
  }


  static Widget cancelledStatusBtn() {
    return CustomStatusButton(
      textColor: AppColor.hintColor,
      bgColor: AppColor.hintColor.withOpacity(0.2),
      text: AppString.textCancelled.tr,
      paddingTop: 0,
      textSize: Dimensions.fontSizeSmall,
    );
  }

}
