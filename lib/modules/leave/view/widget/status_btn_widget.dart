import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';

Widget approvedStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.successColor,
    bgColor: AppColor.successColor.withOpacity(0.1),
    text: AppString.text_approved.tr,
    statusIcon: Icons.check,
  );
}

Widget rejectedStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.errorColor,
    bgColor: AppColor.errorColor.withOpacity(0.07),
    text: AppString.text_rejected.tr,
    statusIcon: Icons.block_flipped,
  );
}

Widget pendingStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.pendingColor,
    bgColor: AppColor.pendingColor.withOpacity(0.1),
    text: AppString.text_pendding.tr,
    statusIcon: Icons.timeline,
  );
}

Widget tokenStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.primaryColor,
    bgColor: AppColor.primaryColor.withOpacity(0.1),
    text: AppString.text_token.tr,
    statusIcon: Icons.task_alt,
  );
}

Widget canceledStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.bgColor,
    bgColor: AppColor.errorColor.withOpacity(0.6),
    text: AppString.text_canceled.tr,
    statusIcon: Icons.block_flipped,
  );
}
