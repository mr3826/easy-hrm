import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../common/domain/last_input_model.dart';
import '../widget/task_view_widget.dart';

class TimeLineCalendar extends StatelessWidget {
  const TimeLineCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    log("SFCalendarScreen build called", error: 100);
    return Obx(() =>
        Get.find<TimelineController>().isTimelineCalendarByDateLoading.isTrue
            ? Container(
                color: Colors.transparent,
              )
            : Padding(
                padding: const EdgeInsets.only(
                    top: 90.0, bottom: 110, left: 14, right: 14),
                child: SfCalendar(
                  view: CalendarView.day,
                  dataSource: _getCalendarDataSource(),
                  backgroundColor: AppColor.cardColor,
                  appointmentTextStyle:
                      const TextStyle(color: AppColor.normalTextColor),
                  selectionDecoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  viewHeaderStyle: const ViewHeaderStyle(
                      backgroundColor: Colors.transparent,
                      dateTextStyle: TextStyle(color: Colors.transparent),
                      dayTextStyle: TextStyle(color: Colors.transparent)),
                  viewHeaderHeight: 0,
                  onTap: (CalendarTapDetails details) {
                    Appointment tappedAppointment = details.appointments![0];
                    if (details.targetElement != CalendarElement.calendarCell) {
                      Map<String, dynamic> jsonMap =
                          json.decode(tappedAppointment.location.toString());
                      ModelForDescription eventVal =
                          ModelForDescription.fromJson(jsonMap);

                      customButtonSheet(
                          height: .6,
                          context: context,
                          child: TaskView(
                            projectName: eventVal.taskName.toString(),
                            date: eventVal.startDate.toString(),
                            startTime: eventVal.startDate.toString(),
                            endTime: eventVal.endDate.toString(),
                            status: eventVal.status.toString(),
                            totalDur: eventVal.duration.toString(),
                            description: eventVal.description.toString(),
                            timeLineId: eventVal.timeLId.toString(),
                          ));
                    }
                  },
                  headerHeight: 0,
                  showDatePickerButton: false,
                  showNavigationArrow: false,
                  cellEndPadding: 4,
                  allowViewNavigation: false,
                  appointmentTimeTextFormat: "HH:mm",
                  timeSlotViewSettings: const TimeSlotViewSettings(
                    timeFormat: "HH:mm",
                  ),
                  showCurrentTimeIndicator: false,
                  initialDisplayDate: DateTime.now(),
                  headerStyle:
                      const CalendarHeaderStyle(textAlign: TextAlign.center),
                  monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                ),
              )

    );
  }

  // Create a calendar data source using the appointments list
  _DataSource _getCalendarDataSource() {
    return _DataSource(Get.find<TimelineController>().meetings);
  }
}

// Data source class for the calendar
class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
