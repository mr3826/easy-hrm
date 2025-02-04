import 'dart:convert';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/widget/leave_record_details_view.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_solid_layout_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import '../../../../app/modules/hr_timeline/view/widgets/timeline_calender/calendar_timelog_details.dart';
import '../../../../app/modules/leave_hr/presentation/model/leave_details_by_id.dart';
import '../../../../common/domain/last_input_model.dart' as li;
import '../../../../common/widget/custom_drawer.dart';
import '../../../../utils/dimensions.dart';

class TimeLineCalendar extends StatelessWidget {
  const TimeLineCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    _modelHeightAccordingScreenSize();
    TimelineGlobalController controller = Get.find<TimelineGlobalController>();

    return SizedBox(
      height: MediaQuery.of(context).size.height + 2500,
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: DayView(
          showVerticalLine: false,
          minDay: DateTime(2021),
          maxDay: DateTime(2030),
          initialDay: DateTime.parse("2024-01-24"),
          timeLineOffset: 4,
          showHalfHours: true,
          headerStyle: const HeaderStyle(
              rightIconVisible: false,
              leftIconVisible: false,
              headerMargin: EdgeInsets.zero,
              headerPadding: EdgeInsets.zero,
              decoration: BoxDecoration(color: Colors.transparent)),
          heightPerMinute: 2,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          pageViewPhysics: const NeverScrollableScrollPhysics(),
          safeAreaOption: const SafeAreaOption(
              right: false, left: false, top: false, bottom: true),
          scrollOffset: 0,
          halfHourIndicatorSettings: HourIndicatorSettings(
              dashWidth: 3,
              offset: 20,
              lineStyle: LineStyle.dashed,
              color: AppColor.hintColor.withOpacity(0.6)),
          hourIndicatorSettings: HourIndicatorSettings(
              lineStyle: LineStyle.solid,
              height: .5,
              offset: 5,
              color: AppColor.hintColor.withOpacity(0.6)),
          timeStringBuilder: (date, {secondaryDate}) {
            String formattedTime = DateFormat.Hm().format(date);
            return formattedTime;
          },
          timeLineWidth: 55,
          onEventTap: (events, date) {
            Iterable<String> eventData = events.map((e) => e.description!);

            String timeLId = eventData
                .map((e) =>
                    li.ModelForDescription.fromJson(jsonDecode(e)).timeLId)
                .toString();

            String leaveId = eventData
                .map((e) =>
                    li.ModelForDescription.fromJson(jsonDecode(e)).leaveId)
                .toString();

            /// have to sub string
            /// otherwise it returns with (value) pattern

            if (leaveId.substring(1, leaveId.length - 1) == "null") {
              if (Get.find<TimelineGlobalController>()
                  .searchEmployeeId
                  .isNotEmpty) {
                controller.getTimeEntryDetails(
                    orgId:
                        Get.find<TimelineGlobalController>().searchEmployeeId,
                    timelindId: timeLId
                        .toString()
                        .substring(1, timeLId.toString().length - 1));
              } else {
                controller.getTimeEntryDetails(
                    timelindId: timeLId
                        .toString()
                        .substring(1, timeLId.toString().length - 1));
              }
            } else {
              Get.find<TimelineGlobalController>().getLeaveDetailsById(
                  leaveId: leaveId
                      .toString()
                      .substring(1, leaveId.toString().length - 1));
            }

            customAntButtonSheet(
              context: context,
              child: leaveId.substring(1, leaveId.length - 1) == "null"
                  ? const BuildTaskDetails()
                  : Obx(() => Get.find<TimelineGlobalController>()
                          .isLeaveDetailsByLoading
                          .isTrue
                      ? const LoadingIndicator()
                      : LeaveRecordDetailsById(
                          data: Get.find<TimelineGlobalController>()
                                  .leaveDetailsById
                                  ?.getLeaveDetailsById ??
                              GetLeaveDetailsById(),
                          isEmployee: Get.find<TimelineGlobalController>()
                              .isEmployee
                              .value,
                        )),
            );
          },
          eventTileBuilder: (date, events, status, start, end) {
            ///for building calendar uo

            List<String> eventData = events.map((e) => e.description!).toList();

            print("event length :: ${eventData.length}");

            /// have to sub string
            /// otherwise it returns with (value) pattern

            String status = eventData
                .map((e) =>
                    li.ModelForDescription.fromJson(jsonDecode(e)).status)
                .toString();
            String startDate = eventData
                .map((e) =>
                    li.ModelForDescription.fromJson(jsonDecode(e)).startDate)
                .toString();
            String endDate = eventData
                .map((e) =>
                    li.ModelForDescription.fromJson(jsonDecode(e)).endDate)
                .toString();

            String taskName = eventData
                .map((e) =>
                    li.ModelForDescription.fromJson(jsonDecode(e)).taskName)
                .toString();
            String leaveId = eventData
                .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                    .leaveType
                    ?.leaveId)
                .toString();

            String projectName = eventData
                .map((e) =>
                    li.ModelForDescription.fromJson(jsonDecode(e)).projectName)
                .toString();
            String projectColor = eventData
                .map((e) =>
                    li.ModelForDescription.fromJson(jsonDecode(e)).projectColor)
                .toString();

            return Padding(
              padding: events.isNotEmpty && events.length > 1
                  ? const EdgeInsets.only(left: 8.0)
                  : const EdgeInsets.only(left: 0.0),
              child: TaskSolidLayout(
                isForLeave: leaveId.substring(1, leaveId.length - 1) == 'null'
                    ? false
                    : true,
                status: status.substring(1, status.length - 1),
                startDateTime: startDate.substring(1, startDate.length - 1),
                endDateTime: endDate.substring(1, endDate.length - 1),
                taskName: taskName.substring(1, taskName.length - 1),
                projectName: projectName.substring(1, projectName.length - 1),
                projectColors:
                    projectColor.substring(1, projectColor.length - 1),
              ),
            );
          },
        ),
      ),
    );
  }
}

customAntButtonSheet({required BuildContext context, child, double? height}) {
  return showCustomAtmBtnSheet(
      height: height ?? _modelHeightAccordingScreenSize(),
      context: context,
      child: Material(
        color: AppColor.noColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radiusMid),
                topLeft: Radius.circular(Dimensions.radiusMid)),
            color: AppColor.cardColor,
          ),
          child: child,
        ),
      ));
}

double _modelHeightAccordingScreenSize() {
  double value = MediaQuery.of(Get.context!).size.width;
  if (value <= 360.0) {
    return 480;
  } else {
    return 500;
  }
}
