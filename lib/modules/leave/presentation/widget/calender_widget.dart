import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:table_calendar/table_calendar.dart';


class HorizontalCalendar extends StatefulWidget {
  const HorizontalCalendar({Key? key}) : super(key: key);

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime today = DateTime.now();
  final firstDate = DateTime.utc(2012);
  final lastDate = DateTime.utc(2040);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: "en_US",
      rowHeight: AppLayout.getHeight(70),
      availableGestures: AvailableGestures.all,
      firstDay: firstDate,
      lastDay: lastDate,
      focusedDay: today,
      calendarFormat: CalendarFormat.week,
      calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          outsideTextStyle: AppStyle.normal_text_black.copyWith(fontSize: 26),
          outsideDecoration: defaultTableDecoration,
          weekNumberTextStyle:
          AppStyle.normal_text_black.copyWith(fontSize: 26),
          weekendDecoration: defaultTableDecoration,
          disabledTextStyle: AppStyle.normal_text_black.copyWith(fontSize: 26),
          disabledDecoration: defaultTableDecoration,
          weekendTextStyle: AppStyle.normal_text_black.copyWith(fontSize: 26),
          withinRangeDecoration: defaultTableDecoration,
          holidayTextStyle: AppStyle.normal_text_black.copyWith(fontSize: 26),
          holidayDecoration: defaultTableDecoration,
          defaultTextStyle: AppStyle.normal_text_black.copyWith(fontSize: 26),
          defaultDecoration: defaultTableDecoration,
          selectedTextStyle: AppStyle.normal_text_black
              .copyWith(fontSize: 30, color: Colors.white),
          selectedDecoration:
          defaultTableDecoration.copyWith(color: AppColor.primaryColor),
          todayDecoration: const BoxDecoration(color: Colors.transparent),
          todayTextStyle: AppStyle.normal_text_black.copyWith(fontSize: 26)),
      onHeaderTapped: (focusedDay) {},
      headerStyle: HeaderStyle(
          titleTextStyle: AppStyle.normal_text.copyWith(
              fontSize: 18,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold),
          titleCentered: true,
          formatButtonVisible: false),
      selectedDayPredicate: (day) => isSameDay(day, today),
      onDaySelected: (selectedDay, focusedDay) async {
        setState(() {
          today = selectedDay;
        });
      },
    );
  }
}

BoxDecoration defaultTableDecoration = BoxDecoration(
    shape: BoxShape.rectangle,
    border: Border.all(color: Colors.transparent),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    color: Colors.transparent);