import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_solid_layout_widget.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';

class TimelineCalendarView extends StatelessWidget {
   const TimelineCalendarView({super.key});
  @override
  Widget build(BuildContext context) {



    return DayView(
      showVerticalLine: false,
      minDay: DateTime(2021),
      maxDay: DateTime(2030),
      initialDay: DateTime.parse("2024-01-01"),
      timeLineOffset: 0,
      showHalfHours: true,
      showLiveTimeLineInAllDays: false,
      backgroundColor: AppColor.cardColor,
      heightPerMinute: 1.9,
      headerStyle: _headerStyle(),
      eventArranger: const SideEventArranger(),

      onEventTap: (events, date) => print(events),
      onDateLongPress: (date) => print(date),

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



      eventTileBuilder: (date, events, status, start, end) {

        return const TaskSolidLayout(
          duration: "0.0",
          status: "pending",
          startDateTime: "2023-01-02",
          endDateTime: "2023-01-02",
          taskName: "My task",
        );
      },
    );
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
