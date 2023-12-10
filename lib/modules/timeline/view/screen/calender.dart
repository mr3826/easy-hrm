import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class Calender extends StatelessWidget {
  const Calender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SfCalendar(
          view: CalendarView.month,
        ),
      ),
    );
  }
}
