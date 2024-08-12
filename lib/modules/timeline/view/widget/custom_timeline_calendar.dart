import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/widget/single_date_picker_calendar.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timeline_calendar.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../utils/utils.dart';
import '../../controller/timeline_controller.dart';
import 'timelog_summary_working_gol_layout.dart';

class CustomTimelineCalendar extends StatelessWidget {
  const CustomTimelineCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: swapTimelineCalendarHeightAccordingScreenSize(context),
      child: Obx(() => Stack(
            children: [
              const TimeLineCalendar(),
              _summaryLayout(),
              Get.find<TimelineController>()
                          .isTimelineSummaryByDateLoading
                          .isTrue &&
                      Get.find<TimelineController>()
                          .isTimelineCalendarByDateLoading
                          .isTrue
                  ? const Positioned(
                      top: 120,
                      right: 120,
                      left: 120,
                      child: Center(
                          child: CupertinoActivityIndicator(
                              radius: 20, color: Colors.blueAccent)))
                  : Container()
            ],
          )),
    );
  }
}

double swapTimelineCalendarHeightAccordingScreenSize(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  // Consider a base height increment based on the device's aspect ratio
  double baseIncrement = 2200.0;
  double additionalIncrement = 300.0; // Increment for smaller screens

  // Determine if the device is small based on both width and height
  bool isSmallScreen = width < 400.0 || height < 400.0;

  if (isSmallScreen) {
    print("Small screen detected");
    return height + baseIncrement + additionalIncrement;
  } else {
    print("Regular screen detected");
    return height + baseIncrement;
  }
}


Widget dateCalendarLayout() {
  return Card(
    elevation: 0,
    child: GestureDetector(
      onTap: () {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return const Dialog(
                child: SingleDatePicker(
              isCalledFormTimeLog: true,
            ));
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () async {
                      Get.find<DateTimeController>().requestedDate.value =
                          DateFormat("yyyy-MM-dd").format(DateTime.parse(
                                  Get.find<DateTimeController>()
                                      .requestedDate
                                      .value)
                              .subtract(const Duration(days: 1)));

                      DateTime date = DateTime.parse(
                          Get.find<DateTimeController>().requestedDate.value);
                      Get.find<TimelineController>().getTimelineSummaryByDate(
                          startDate:
                              "${DateTime(date.year, date.month, date.day, 0, 0, 0)}",
                          endDate:
                              "${DateTime(date.year, date.month, date.day, 23, 59, 59)}");

                      Get.find<TimelineController>().getCalendarTimelineDataByDate(
                          startDate:
                              "${DateTime(date.year, date.month, date.day, 0, 0, 0)}",
                          endDate:
                              "${DateTime(date.year, date.month, date.day, 23, 59, 59)}");
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.normalTextColor,
                      size: 20,
                    )),
                Text(
                  Get.find<DateTimeController>().requestedDate.value ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now())
                      ? "Today"
                      : DateFormat('dd MMM yyyy').format(DateTime.parse(
                          Get.find<DateTimeController>().requestedDate.value)),
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.secondaryColor,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () async {
                      Get.find<DateTimeController>().requestedDate.value =
                          DateFormat("yyyy-MM-dd").format(DateTime.parse(
                                  Get.find<DateTimeController>()
                                      .requestedDate
                                      .value)
                              .add(const Duration(days: 1)));

                      DateTime date = DateTime.parse(
                          Get.find<DateTimeController>().requestedDate.value);

                      Get.find<TimelineController>().getTimelineSummaryByDate(
                          startDate:
                              "${DateTime(date.year, date.month, date.day, 0, 0, 0)}",
                          endDate:
                              "${DateTime(date.year, date.month, date.day, 23, 59, 59)}");

                      Get.find<TimelineController>().getCalendarTimelineDataByDate(
                          startDate:
                              "${DateTime(date.year, date.month, date.day, 0, 0, 0)}",
                          endDate:
                              "${DateTime(date.year, date.month, date.day, 23, 59, 59)}");
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColor.normalTextColor,
                      size: 20,
                    )),
              ],
            ),
            Center(
                child: Text(
              DateFormat("EEEE")
                  .format(DateTime.parse(
                      Get.find<DateTimeController>().requestedDate.value))
                  .toString(),
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 1),
            ))
          ],
        ),
      ),
    ),
  );
}

Widget _summaryLayout() {
  return Positioned(
      top: AppLayout.getHeight(0),
      child: Container(
        color: AppColor.cardColor,
        width: MediaQuery.of(Get.context!).size.width,
        child: workingScheduleLayout(
            schedule: getConvertSecondsToHours(Get.find<TimelineController>()
                    .timelineSummaryByDate
                    ?.getTimelogSummaryForApp
                    ?.totalScheduledSeconds ??
                ""),
            balanceTime: getConvertSecondsToHours(Get.find<TimelineController>()
                    .timelineSummaryByDate
                    ?.getTimelogSummaryForApp
                    ?.balance ??
                ""),
            loggedTime: getConvertSecondsToHours(Get.find<TimelineController>()
                    .timelineSummaryByDate
                    ?.getTimelogSummaryForApp
                    ?.loggedTotalSeconds ??
                ""),
            paidLeave: getConvertSecondsToHours(Get.find<TimelineController>()
                    .timelineSummaryByDate
                    ?.getTimelogSummaryForApp
                    ?.totalLeavesSeconds ??
                "")),
      ));
}
