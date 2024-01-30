import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_solid_layout_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_view_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import '../../../../common/domain/last_input_model.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../controller/time_formate_controller.dart';

class TimeLineCalendar extends StatelessWidget {
  const TimeLineCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Get.find<TimelineController>()
            .isTimelineCalendarByDateLoading
            .isTrue
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(
                top: 0.0, bottom: 110, left: 14, right: 14),
            child: DayView(
              showVerticalLine: false,
              minDay: DateTime(2021),
              maxDay: DateTime(2030),
              initialDay: DateTime.parse("2024-01-24"),
              timeLineOffset: 0,
              showHalfHours: true,
              showLiveTimeLineInAllDays: false,
              backgroundColor: AppColor.cardColor,
              heightPerMinute: 1.9,
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
              minuteSlotSize: MinuteSlotSize.minutes30,
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

                var durationData = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).duration)
                    .toString();

                var statusData = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).status)
                    .toString();

                var startDateTimeData = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).startDate)
                    .toString();

                var endDateTimeData = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).endDate)
                    .toString();

                var taskNameData = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).taskName)
                    .toString();

                var timelineId = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).timeLId)
                    .toString();

                var description = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).description)
                    .toString();

                customButtonSheet(
                    height: .6,
                    context: context,
                    child: TaskView(
                      projectName: taskNameData
                          .toString()
                          .substring(1, taskNameData.toString().length - 1),
                      date: startDateTimeData.toString().substring(
                          1, startDateTimeData.toString().length - 1),
                      startTime: startDateTimeData.toString().substring(
                          1, startDateTimeData.toString().length - 1),
                      endTime: endDateTimeData
                          .toString()
                          .substring(1, endDateTimeData.toString().length - 1),
                      status: statusData
                          .toString()
                          .substring(1, statusData.toString().length - 1),
                      totalDur: durationData
                          .toString()
                          .substring(1, durationData.toString().length - 1),
                      description: description
                          .toString()
                          .substring(1, description.toString().length - 1),
                      timeLineId: timelineId
                          .toString()
                          .substring(1, durationData.toString().length - 1),
                    ));

              },
              eventTileBuilder: (
                date,
                events,
                status,
                start,
                end,
              ) {
                Iterable<String> eventData = events.map((e) => e.description);

                var durationData = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).duration)
                    .toString();

                var statusData = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).status)
                    .toString();

                var startDateTimeData = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).startDate)
                    .toString();

                var endDateTimeData = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).endDate)
                    .toString();

                var taskNameData = eventData
                    .map((e) =>
                        ModelForDescription.fromJson(jsonDecode(e)).taskName)
                    .toString();

                return TaskSolidLayout(
                  duration: durationData
                      .toString()
                      .substring(1, durationData.toString().length - 1),
                  status: statusData
                      .toString()
                      .substring(1, statusData.toString().length - 1),
                  startDateTime: startDateTimeData
                      .toString()
                      .substring(1, startDateTimeData.toString().length - 1),
                  endDateTime: endDateTimeData
                      .toString()
                      .substring(1, endDateTimeData.toString().length - 1),
                  taskName: taskNameData
                      .toString()
                      .substring(1, taskNameData.toString().length - 1),
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
}
