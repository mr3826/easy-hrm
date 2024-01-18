import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_solid_layout_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_view_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/domain/last_input_model.dart';
import '../../controller/time_formate_controller.dart';

class TimeLineCalendar extends GetView<TimelineController> {
  const TimeLineCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    log("TimeLineCalendar build calendar",error: 100);
    return _calendarLayout(context);
  }

  _calendarLayout(context) {

    return
      Padding(
      padding: marginLayout,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: DayView(
          scrollPhysics: const AlwaysScrollableScrollPhysics(),
          eventTileBuilder: (date, events, status1, start, end) {
            //format DateTime
            DateTime startDateTime = DateTime.parse(start.toString());
            DateTime endDateTime = DateTime.parse(end.toString());
            Iterable<Object?> eventsName = events.map((e) => e.event);
            //total minute
            Iterable<String> totalMin = events.map((e) => e.title.toString());
            Iterable<String> status = events.map((e) => e.description);

            // Format the DateTime in 24-hour format
            String stateTime = timeFormatTo24h(startDateTime);
            String endTime = timeFormatTo24h(endDateTime);

            return TaskSolidLayout(
                title: eventsName.toString(),
                startTime: stateTime,
                endTime: endTime,
                status: "${status.map((String e) => ModelForDescription.fromJson(jsonDecode(e)).status)}",
                totalMin: totalMin.toString());
          },
          showVerticalLine: false,
          minDay: DateTime(1990),
          maxDay: DateTime(2050),
          initialDay: DateTime.now(),
          timeLineOffset: 0,
          showHalfHours: true,
          showLiveTimeLineInAllDays: false,
          heightPerMinute: 1.9,
          onEventTap: (events, date) {


            Iterable<Object?> eventsName = events.map((e) => e.event);
            Iterable<Object?> duration =
                events.map((e) => e.title); //total minute
            Iterable<DateTime?> startTime = events.map((e) => e.startTime);
            Iterable<DateTime?> endTime = events.map((e) => e.endTime);
            Iterable<DateTime> createAtDate =
                events.map((e) => e.endDate); //Date of application
            Iterable<String> status =
                events.map((e) => e.description); //status added here

            customButtonSheet(
                height: .6,
                context: context,
                child: TaskView(
                  projectName: eventsName.toString(),
                  date: createAtDate.toString(),
                  startTime: startTime.toString(),
                  endTime: endTime.toString(),
                  status: "${status.map((String e) => ModelForDescription.fromJson(jsonDecode(e)).status)}",
                  totalDur: duration.toString(),
                  description: "${status.map((String e) => ModelForDescription.fromJson(jsonDecode(e)).description)}",
                  timeLineId: "${status.map((String e) => ModelForDescription.fromJson(jsonDecode(e)).timeLId)}",

                ));
          },
          onDateLongPress: (date){
          },
          headerStyle: _headerStyle(),
          liveTimeIndicatorSettings: HourIndicatorSettings.none(),
          pageViewPhysics: const NeverScrollableScrollPhysics(),
          halfHourIndicatorSettings: const HourIndicatorSettings(
            dashWidth: 1.4,
            lineStyle: LineStyle.dashed,
            offset: 35,
          ),
          eventArranger: const SideEventArranger(),
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
          dateStringBuilder: (date, {secondaryDate}) {

            var formatDate = DateFormat('dd MMM yyyy').format(date);
            var now = DateFormat('dd MMM yyyy').format(DateTime.now());
            if (formatDate == now) {
              return "Today";
            } else {
              return formatDate;
            }
          },

        ),
      ),
    );
  }
}

_headerStyle() {
  return HeaderStyle(
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
        color: AppColor.normalTextColor,
      ));
}
