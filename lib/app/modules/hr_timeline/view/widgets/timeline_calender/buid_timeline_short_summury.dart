import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../../../common/controller/date_time_controller.dart';
import '../../../bindings/TimelineSummaryBindings.dart';
import '../../../controllers/timelog_summary_controller.dart';
import '../../../models/timeline_summary_by_date.dart';
import '../../screen/timelog_summary.dart';

Widget buildTimelineShortSummary(TimelineSummaryByMonth timelineSummaryByMonth) {
  return SizedBox(
    height: AppLayout.getHeight(118),
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.only(left: AppLayout.getHeight(0)),
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
                      dynamicText: getConvertSecondsToHours(
                              timelineSummaryByMonth
                              .getTimelogSummaryForApp
                              ?.totalScheduledSeconds.toString() ??
                              ""),
                      staticText: AppString.text_schedule.tr),
                  const Spacer(),
                  _divider(),
                  const Spacer(),
                  _countLayout(
                      dynamicText: getConvertSecondsToHours(
                         timelineSummaryByMonth
                              .getTimelogSummaryForApp
                              ?.loggedTotalSeconds.toString() ??
                              ""),
                      staticText: AppString.text_logged.tr),
                  const Spacer(),
                  _divider(),
                  const Spacer(),
                  _countLayout(
                      dynamicText: getConvertSecondsToHours(
                          timelineSummaryByMonth
                              .getTimelogSummaryForApp
                              ?.totalLeavesSeconds.toString() ??
                              ""),
                      staticText: AppString.text_paid_leave.tr),
                  const Spacer(),
                  _divider(),
                  const Spacer(),
                  _countLayout(
                      dynamicText: getConvertSecondsToHours(
                         timelineSummaryByMonth
                              .getTimelogSummaryForApp
                              ?.balance.toString() ??
                              ""),
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
    onTap: (){
      TimeSheetBindings().dependencies();
      DateTime now=DateTime.now();
      Get.find<DateTimeController>().requestedDate(DateTime(now.year, now.month, 1, 0, 0, 0).toString());
      Get.find<DateTimeController>().requestedEndDate(DateTime(now.year, now.month + 1,0).toString());

      Get.find<TimelineSummaryController>().getTimelineSummaryByDate();
      Get.find<TimelineSummaryController>().getTimelogDetailsByMonth();

      Get.to(()=>const TimeLogSummary(isEmployee: true,));

    } ,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            AppString.text_tab_to_view_timelog_summary.tr,
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.cardColor,
              overflow: TextOverflow.ellipsis,
              decorationColor: AppColor.cardColor,
              decoration: TextDecoration.underline,
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
        ),
        customSpacerWidth(width: 10),
        const Icon(
          Icons.arrow_forward,
          color: AppColor.cardColor,
          size: 18,
        ),
      ],
    ),
  );
}

_countLayout({required String dynamicText, required String staticText}) {
  return Column(
    children: [
      Text(
        dynamicText,
        style: AppStyle.normal_text_black.copyWith(
            color: AppColor.cardColor,
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.fontSizeDefault + 1),
      ),
      Text(
        staticText,
        style: AppStyle.normal_text_black.copyWith(
            color: AppColor.cardColor.withOpacity(0.9),
            fontSize: Dimensions.fontSizeDefault - 3),
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
