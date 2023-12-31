import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget workingScheduleLayout() {
  return Card(
    elevation: 0,
    shape:
        roundedRectangleBorder.copyWith(borderRadius: BorderRadius.circular(8)),
    color: AppColor.cardColor.withOpacity(0.2),
    child: Padding(
      padding: marginLayout.copyWith(top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _countLayout(
              dynamicText: "120h", staticText: AppString.text_schedule.tr),
          _divider(),
          _countLayout(
              dynamicText: "122h+", staticText: AppString.text_logged.tr),
          _divider(),
          _countLayout(
              dynamicText: "0.8h+", staticText: AppString.text_paid_leave.tr),
          _divider(),
          _countLayout(
              dynamicText: "30h", staticText: AppString.text_balance.tr),
        ],
      ),
    ),
  );
}

_countLayout({required dynamicText, required staticText}) {
  return Column(
    children: [
      Text(
        "$dynamicText",
        style: AppStyle.normal_text_black.copyWith(
            color: AppColor.normalTextColor,
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.fontSizeMid - 3),
      ),
      Text(
        "$staticText",
        style: AppStyle.normal_text_black.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.5),
            fontSize: Dimensions.fontSizeDefault - 2),
      ),
    ],
  );
}

_divider() {
  return Container(
    width: 0.8,
    height: AppLayout.getHeight(28),
    color: AppColor.disableColor,
  );
}
