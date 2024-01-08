import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_view_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../controller/time_formate_controller.dart';
import '../../model/calendar_timeline.dart';

class TimeLineCalendar extends GetView<TimelineController> {
  const TimeLineCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => _calendarLayout(context),
        onLoading: const LoadingIndicator());
  }

  _headerStyle() {
    return HeaderStyle(
        decoration: const BoxDecoration(color: Colors.transparent),
        headerMargin: const EdgeInsets.only(bottom: 30),
        headerTextStyle: AppStyle.normal_text_grey.copyWith(
            color: AppColor.secondaryColor, fontSize: Dimensions.fontSizeMid),
        leftIcon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: AppColor.normalTextColor,
        ),
        rightIcon: const Icon(
          Icons.arrow_forward_ios,
          size: 20,
          color: AppColor.normalTextColor,
        ));
  }

  _calendarLayout(context) {
    CalendarControllerProvider.of(context)
        .controller
        .addAll(Get.find<TimelineController>().eventsData??[]);
    return Padding(
      padding: marginLayout,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 84.0),
        child: DayView(
          scrollPhysics: const AlwaysScrollableScrollPhysics(),
          eventTileBuilder: (date, events, boundry, start, end,) {
            //format DateTime
            DateTime startDateTime = DateTime.parse(start.toString());
            DateTime endDateTime = DateTime.parse(end.toString());

            // Format the DateTime in 24-hour format
            String stateTime = formatTime(startDateTime);
            String endTime = formatTime(endDateTime);

            return _taskSlidLayout(
                bgColor: AppColor.primaryColor,
                title: events.first.event,
                icon: Icons.done,
                startTime: stateTime,
                endTime:endTime,
                context: context);
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
            customButtonSheet(
                height: .6, context: context, child: const TaskView());
          },
          onDateLongPress: (date) => print(date),
          headerStyle: _headerStyle(),
          liveTimeIndicatorSettings: HourIndicatorSettings.none(),
          pageViewPhysics: const NeverScrollableScrollPhysics(),
          halfHourIndicatorSettings: const HourIndicatorSettings(
            dashWidth: 1.4,
            lineStyle: LineStyle.dashed,
            offset: 35,
          ),
          eventArranger: const SideEventArranger(),
          minuteSlotSize: MinuteSlotSize.minutes60,
          hourIndicatorSettings: HourIndicatorSettings(
              lineStyle: LineStyle.solid,
              offset: 12,
              height: .5,
              color: AppColor.hintColor.withOpacity(0.6)),
          timeStringBuilder: (date, {secondaryDate}) {
        //    print("time:: $date");
            String formattedTime = DateFormat.Hm().format(date);
            return formattedTime;
          },
          dateStringBuilder: (date, {secondaryDate}) {
            print(date.toString());

            WidgetsBinding.instance.addPostFrameCallback((_){

              Get.find<TimelineController>().getTimelineSummaryByDate(
                  startDate:
                  "${DateTime(date.year, date.month, date.day, 0, 0, 0)}",
                  endDate:
                  "${DateTime(date.year, date.month, date.day, 0, 0, 0)}");

              Get.find<TimelineController>().getCalendarTimelineDataByDate(
                  startDate:
                  "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0)}",
                  endDate:
                  "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59)}");

            });




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

Widget _taskSlidLayout({required title, required startTime, required endTime, required IconData? icon, required Color? bgColor, required context}) {

 String totalTime= totalTimeByTimeline(startTime,endTime);
 print(totalTime);

  return Card(
    elevation: 0,
    color: AppColor.primaryColor.withOpacity(0.09),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        side: const BorderSide(width: .5, color: AppColor.primaryColor)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$startTime",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                fontSize: Dimensions.fontSizeDefault - 2,
                overflow: TextOverflow.ellipsis),
          ),
          customSpacerHeight(height: 6),
          Text(
            title,
            maxLines: 2,
            style: AppStyle.mid_large_text.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: bgColor,
                overflow: TextOverflow.ellipsis),
          ),
          customSpacerHeight(height: 6),
          Text(
            totalTime,
            style: AppStyle.mid_large_text.copyWith(
                fontSize: Dimensions.fontSizeDefault - 2,
                color: bgColor,
                overflow: TextOverflow.ellipsis),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$endTime",
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeDefault - 2,
                    overflow: TextOverflow.ellipsis),
              ),
              Icon(
                icon,
                color: bgColor,
                size: 20,
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget nullContainer({required bgColor, required taskText}) {
  return Card(
    elevation: 0,
    color: AppColor.primaryColor.withOpacity(0.09),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        side: const BorderSide(width: .5, color: AppColor.primaryColor)),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        "$taskText",
        maxLines: 2,
        style: AppStyle.mid_large_text.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: bgColor,
            overflow: TextOverflow.ellipsis),
      ),
    ),
  );
}


String totalTimeByTimeline(String startTimeString, String endTimeString) {
  // Parse the input strings into hours and minutes
  double startTime = double.parse(startTimeString);
  double endTime = double.parse(endTimeString);

  // Calculate the time difference
  double timeDifference = endTime - startTime;

  // Extract hours and minutes
  int hours = timeDifference.floor();
  int minutes = ((timeDifference - hours) * 60).round();

  // Format the hours and minutes
  String formattedHours = hours.toString().padLeft(2, '0');
  String formattedMinutes = minutes.toString().padLeft(2, '0');

  // Return the formatted string
  return '$formattedHours h $formattedMinutes m';
}
