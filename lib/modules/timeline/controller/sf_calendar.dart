import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SFCalendarScreen extends StatelessWidget {
  const SFCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print( "evens :: ${Get.find<TimelineController>().meetings.length}");

    return Scaffold(
      appBar: AppBar(),
      body: Obx(() =>
      Get
          .find<TimelineController>()
          .isTimelineCalendarByDateLoading
          .isTrue ? const CupertinoActivityIndicator() : Scaffold(
        body: SfCalendar(
          view: CalendarView.day,
          dataSource: MeetingDataSource(Get
              .find<TimelineController>()
              .meetings),
          selectionDecoration:
          BoxDecoration(borderRadius: BorderRadius.circular(23)),

          // onTap: (value){
          //   print("onTap  ${value.date}");
          //
          // },
          // onAppointmentResizeUpdate: (appointmentResizeUpdateDetails) {
          //   print("appointmentResizeUpdateDetails :: ${appointmentResizeUpdateDetails.resource?.displayName}");
          // },
          // onAppointmentResizeEnd: (appointmentResizeEndDetails) {
          //   print("onAppointmentResizeEnd :: $appointmentResizeEndDetails");
          // },
          //
          // onAppointmentResizeStart: (appointmentResizeStartDetails) {
          //   print("onAppointmentResizeStart :: $appointmentResizeStartDetails");
          //
          // },
          // appointmentBuilder: (context, calendarAppointmentDetails) {
          //   print("appointmentBuilder :: ${calendarAppointmentDetails.appointments.length}");
          //   print("appointmentBuilder :: ${calendarAppointmentDetails.date}");
          //   print("appointmentBuilder :: ${calendarAppointmentDetails}");
          //   return Container(
          //     color: Colors.yellow.shade400,
          //
          //
          //   );
          //
          // },










          scheduleViewSettings: const ScheduleViewSettings(
            appointmentItemHeight: 12,
              weekHeaderSettings: WeekHeaderSettings(
                backgroundColor: Colors.yellow
              ),
              dayHeaderSettings: DayHeaderSettings(
            width: 18
          )),

          showDatePickerButton: true,
          showNavigationArrow: true,
          appointmentTimeTextFormat: "HH:mm",
          timeSlotViewSettings: const TimeSlotViewSettings(
            timeFormat: "HH:mm",
          ),
          showCurrentTimeIndicator: false,
          initialDisplayDate: DateTime.now(),
          headerStyle: const CalendarHeaderStyle(textAlign: TextAlign.center),
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ),
      )),
    );
    }

}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
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
