import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget timelineLayout() {
  return SizedBox(
    height: AppLayout.getHeight(115),
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.only(left: AppLayout.getHeight(12)),
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder.copyWith(
            borderRadius: BorderRadius.circular(8)),
        color: AppColor.cardColor.withOpacity(0.2),
        child: Padding(
          padding: marginLayout.copyWith(top: 12, bottom: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _countLayout(
                      dynamicText: Get.find<TimelineController>()
                              .timelineSummaryByMonth
                              ?.getTimelogSummaryForApp
                              ?.totalSchedule ??
                          "",
                      staticText: AppString.text_schedule.tr),
                  const Spacer(),
                  _divider(),
                  const Spacer(),
                  _countLayout(
                      dynamicText: Get.find<TimelineController>()
                              .timelineSummaryByMonth
                              ?.getTimelogSummaryForApp
                              ?.totalLogged ??
                          "",
                      staticText: AppString.text_logged.tr),
                  const Spacer(),
                  _divider(),
                  const Spacer(),
                  _countLayout(
                      dynamicText: Get.find<TimelineController>()
                              .timelineSummaryByMonth
                              ?.getTimelogSummaryForApp
                              ?.paidLeave ??
                          "",
                      staticText: AppString.text_paid_leave.tr),
                  const Spacer(),
                  _divider(),
                  const Spacer(),
                  _countLayout(
                      dynamicText: Get.find<TimelineController>()
                              .timelineSummaryByMonth
                              ?.getTimelogSummaryForApp
                              ?.balanced ??
                          "",
                      staticText: AppString.text_balance.tr),
                ],
              ),
              const Spacer(),
              _tabToViewTimeLogSummery()
            ],
          ),
        ),
      ),
    ),
  );
}

_tabToViewTimeLogSummery() {
  return GestureDetector(
    onTap: () => Get.toNamed(Routes.TIME_LOG_SUMMARY),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppString.text_tab_to_view_timelog_summary.tr,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.cardColor,
            decoration: TextDecoration.underline,
            decorationColor: AppColor.cardColor,
            fontSize: Dimensions.fontSizeDefault,
          ),
        ),
        customSpacerWidth(width: 10),
        const Icon(
          Icons.arrow_forward,
          color: AppColor.cardColor,
          size: 18,
        )
      ],
    ),
  );
}

_countLayout({required dynamicText, required staticText}) {
  return Column(
    children: [
      Text(
        "$dynamicText",
        style: AppStyle.normal_text_black.copyWith(
            color: AppColor.cardColor,
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.fontSizeMid - 2),
      ),
      Text(
        "$staticText",
        style: AppStyle.normal_text_black.copyWith(
            color: AppColor.cardColor.withOpacity(0.9),
            fontSize: Dimensions.fontSizeDefault - 1),
      ),
    ],
  );
}

_divider() {
  return Container(
    width: 0.8,
    height: AppLayout.getHeight(25),
    color: AppColor.cardColor,
  );
}
