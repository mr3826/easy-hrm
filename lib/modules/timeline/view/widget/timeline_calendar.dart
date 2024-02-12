import 'dart:convert';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/modules/leave/model/leave_record_response.dart';
import 'package:payrun_mobile/modules/leave/view/widget/leave_record_details_view.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_solid_layout_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import '../../../../common/domain/last_input_model.dart' as li;
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../leave/model/leave_records.dart';
import '../widget/task_view_widget.dart';

class TimeLineCalendar extends StatelessWidget {
  const TimeLineCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    _modelHeightAccordingScreenSize();
    return Obx(() => Get.find<TimelineController>()
            .isTimelineCalendarByDateLoading
            .isTrue
        ? Container()
        : Padding(
            padding: EdgeInsets.only(
                top: 0.0,
                bottom: AppLayout.getHeight(400),
                left: 14,
                right: 14),
            child: DayView(
              showVerticalLine: false,
              minDay: DateTime(2021),
              maxDay: DateTime(2030),
              initialDay: DateTime.parse("2024-01-24"),
              timeLineOffset: 0,
              showHalfHours: true,
              showLiveTimeLineInAllDays: false,
              backgroundColor: AppColor.cardColor,
              heightPerMinute: 2,
              headerStyle: _headerStyle(),
              eventArranger: const SideEventArranger(),
              scrollPhysics: const NeverScrollableScrollPhysics(),
              liveTimeIndicatorSettings: HourIndicatorSettings.none(),
              pageViewPhysics: const NeverScrollableScrollPhysics(),
              halfHourIndicatorSettings: const HourIndicatorSettings(
                dashWidth: 1.4,
                lineStyle: LineStyle.dashed,
                offset: 35,
              ),
              hourIndicatorSettings: HourIndicatorSettings(
                  lineStyle: LineStyle.solid,
                  offset: 12,
                  height: .5,
                  color: AppColor.hintColor.withOpacity(0.6)),
              timeStringBuilder: (date, {secondaryDate}) {
                String formattedTime = DateFormat.Hm().format(date);
                return formattedTime;
              },
              onEventTap: (events, date) {
                Iterable<String> eventData = events.map((e) => e.description);

                String timeLId = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).timeLId)
                    .toString();
                String startDate = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .startDate)
                    .toString();
                String endDate = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).endDate)
                    .toString();
                String taskName = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).taskName)
                    .toString();
                String status = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).status)
                    .toString();
                String leaveName = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .leaveType
                        ?.leaveName)
                    .toString();

                String leaveTypeId = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .leaveType
                        ?.leaveId)
                    .toString();

                String isAttachDocumentRequired = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .leaveType
                        ?.isAttachDocumentRequired)
                    .toString();

                String isAddNoteRequired = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .leaveType
                        ?.isAddNoteRequired)
                    .toString();
                String type = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .leaveType
                        ?.type)
                    .toString();

                String leaveId = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).leaveId)
                    .toString();
                String duration = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).duration)
                    .toString();
                String description = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .description)
                    .toString();
                String numberOfDays = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .numberOfDays)
                    .toString();
                String createdAt = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .createdAt)
                    .toString();
                String taskId = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).taskId)
                    .toString();
                String projectId = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .projectId)
                    .toString();
                String projectName = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .projectName)
                    .toString();
                String projectColor = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .projectColor)
                    .toString();

                /// have to sub string
                /// otherwise it returns with (value) pattern

                customButtonSheet(
                    height: _modelHeightAccordingScreenSize(),
                    context: context,
                    child: leaveId.substring(1, leaveId.length - 1) == "null"
                        ? TaskView(
                            taskName: taskName.substring(
                                1, taskName.toString().length - 1),
                            date: startDate
                                .toString()
                                .substring(1, startDate.toString().length - 1),
                            startTime: startDate
                                .toString()
                                .substring(1, startDate.toString().length - 1),
                            endTime: endDate
                                .toString()
                                .substring(1, endDate.toString().length - 1),
                            status: status
                                .toString()
                                .substring(1, status.toString().length - 1),
                            totalDur: duration
                                .toString()
                                .substring(1, duration.toString().length - 1),
                            description: description.toString().substring(
                                1, description.toString().length - 1),
                            timeLineId: timeLId
                                .toString()
                                .substring(1, timeLId.toString().length - 1),
                            taskId: taskId
                                .toString()
                                .substring(1, taskId.toString().length - 1),
                            projectId: projectId
                                .toString()
                                .substring(1, projectId.toString().length - 1),
                            projectName: projectName.toString().substring(
                                1, projectName.toString().length - 1),
                            projectColor: projectColor.toString().substring(
                                1, projectColor.toString().length - 1),
                          )
                        : LeaveRecordDetails(
                            status: status
                                .toString()
                                .substring(1, status.toString().length - 1),
                            leaveRecords: GetLeaveRecords(
                              id: leaveId
                                  .toString()
                                  .substring(1, leaveId.toString().length - 1),
                              status: status
                                  .toString()
                                  .substring(1, status.toString().length - 1),
                              createdAt: createdAt
                                  .toString()
                                  .substring(1, createdAt.toString().length - 1)
                                  .toString(),
                              startDate: startDate
                                  .toString()
                                  .substring(1, startDate.toString().length - 1)
                                  .toString(),
                              endDate: endDate
                                  .toString()
                                  .substring(1, endDate.toString().length - 1)
                                  .toString(),
                              duration: double.parse(numberOfDays.substring(
                                  1, numberOfDays.length - 1)),
                              description: description.toString().substring(
                                  1, description.toString().length - 1),
                              leaveType: LeaveType(
                                  leaveName: leaveName.substring(
                                      1, leaveName.length - 1),
                                  leaveId: leaveTypeId.substring(
                                      1, leaveTypeId.length - 1),
                                  isAttachDocumentRequired:
                                      isAttachDocumentRequired
                                                  .substring(
                                                      1,
                                                      isAttachDocumentRequired
                                                              .length -
                                                          1)
                                                  .toLowerCase() ==
                                              "true"
                                          ? true
                                          : false,
                                  isAddNoteRequired: isAddNoteRequired
                                              .substring(1,
                                                  isAddNoteRequired.length - 1)
                                              .toLowerCase() ==
                                          "true"
                                      ? true
                                      : false,
                                  type: type.substring(1, type.length - 1)),
                            ),
                          ));
              },
              eventTileBuilder: (date, events, status, start, end) {
                ///for building calendar uo

                Iterable<String> eventData = events.map((e) => e.description);

                /// have to sub string
                /// otherwise it returns with (value) pattern

                String status = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).status)
                    .toString();
                String startDate = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .startDate)
                    .toString();
                String endDate = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).endDate)
                    .toString();

                String taskName = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).taskName)
                    .toString();

                String duration = eventData
                    .map((e) =>
                        li.ModelForDescription.fromJson(jsonDecode(e)).duration)
                    .toString();

                String leaveId = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .leaveType
                        ?.leaveId)
                    .toString();

                String projectName = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .projectName)
                    .toString();
                String projectColor = eventData
                    .map((e) => li.ModelForDescription.fromJson(jsonDecode(e))
                        .projectColor)
                    .toString();

                return TaskSolidLayout(
                  isForLeave: leaveId.substring(1, leaveId.length - 1) == 'null'
                      ? false
                      : true,
                  status: status.substring(1, status.length - 1),
                  startDateTime: startDate.substring(1, startDate.length - 1),
                  endDateTime: endDate.substring(1, endDate.length - 1),
                  taskName: taskName.substring(1, taskName.length - 1),
                  duration: duration.substring(1, duration.length - 1),
                  projectName: projectName.substring(1, projectName.length - 1),
                  projectColors:
                      projectColor.substring(1, projectColor.length - 1),
                );
              },
            ),
          ));
  }

  _headerStyle() {
    return HeaderStyle(
        headerPadding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(color: Colors.transparent),
        headerMargin: const EdgeInsets.only(bottom: 0),
        headerTextStyle: AppStyle.normal_text_grey.copyWith(
            color: AppColor.noColor, fontSize: Dimensions.fontSizeMid),
        leftIcon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 0,
          color: AppColor.noColor,
        ),
        rightIcon: const Icon(
          Icons.arrow_forward_ios,
          size: 0,
          color: AppColor.noColor,
        ));
  }

  double _modelHeightAccordingScreenSize() {
    double value = MediaQuery.of(Get.context!).size.width;
    if (value <= 360.0) {
      return 0.7;
    } else {
      return 0.6;
    }
  }
}
