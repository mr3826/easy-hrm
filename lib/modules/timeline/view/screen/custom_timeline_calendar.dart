import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/calendar_date_controller.dart';
import 'package:payrun_mobile/modules/leave/view/widget/single_date_picker_calendar.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'sf_calendar.dart';
import '../../controller/timeline_controller.dart';
import '../widget/timelog_summary_working_gol_layout.dart';

class CustomTimelineCalendar extends StatelessWidget {
  const CustomTimelineCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Obx(() => Stack(
            children: [
              Get.find<TimelineController>()
                          .isTimelineSummaryByDateLoading
                          .isTrue &&
                      Get.find<TimelineController>()
                          .isTimelineCalendarByDateLoading
                          .isTrue
                  ? Center(child: Container(color: Colors.transparent))
                  : const SFCalendarScreen(),
              _summaryLayout(),
              _dateCalendarLayout(),
            ],
          )),
    );
  }
}

Widget _dateCalendarLayout() {
  var controller = Get.find<DateController>();
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: Card(
      elevation: 0,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: Get.context!,
            builder: (context) {
              return const Dialog(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  insetPadding: EdgeInsets.zero,
                  child: SingleDatePicker(
                    isCalledFormTimeLog: true,
                  ));
            },
          );
        },
        child: Padding(
          padding: marginLayout,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () async {
                        controller.decrementDate();

                        DateTime date =
                            DateTime.parse(controller.formattedDateTime);
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
                        : Get.find<DateTimeController>().requestedDate.value,
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.normalTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () async {
                        controller.incrementMonth();

                        DateTime date =
                            DateTime.parse(controller.formattedDateTime);

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
                controller.getOnlyDay().toString(),
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: Dimensions.fontSizeDefault - 1),
              ))
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _summaryLayout() {
  return Positioned(
      top: AppLayout.getHeight(40),
      child: Container(
        color: AppColor.backgroundColor,
        width: MediaQuery.of(Get.context!).size.width,
        child: workingScheduleLayout(
            schedule: Get.find<TimelineController>()
                    .timelineSummaryByDate
                    ?.getTimelogSummaryForApp
                    ?.totalSchedule ??
                "",
            balanceTime: Get.find<TimelineController>()
                    .timelineSummaryByDate
                    ?.getTimelogSummaryForApp
                    ?.balanced ??
                "",
            loggedTime: Get.find<TimelineController>()
                    .timelineSummaryByDate
                    ?.getTimelogSummaryForApp
                    ?.totalLogged ??
                "",
            paidLeave: Get.find<TimelineController>()
                    .timelineSummaryByDate
                    ?.getTimelogSummaryForApp
                    ?.paidLeave ??
                ""),
      ));
}
