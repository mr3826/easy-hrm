import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RangeCalendarExample extends StatefulWidget {
  @override
  _RangeCalendarExampleState createState() => _RangeCalendarExampleState();
}

class _RangeCalendarExampleState extends State<RangeCalendarExample> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Range Calendar Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          rangeSelectionMode: _rangeSelectionMode,
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
          onRangeSelected: (start, end, focusedDay) {
            setState(() {
              _rangeStart = start;
              _rangeEnd = end;
              _focusedDay = focusedDay;
              _rangeSelectionMode = RangeSelectionMode.toggledOn;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          selectedDayPredicate: (day) {
            if (_rangeStart != null && _rangeEnd != null) {
              return day.isAfter(_rangeStart!.subtract(const Duration(days: 1))) &&
                  day.isBefore(_rangeEnd!.add(const Duration(days: 1)));
            }
            return false;
          },
          calendarStyle: CalendarStyle(
            rangeHighlightColor: Colors.blue.withOpacity(0.5),
            rangeStartDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            rangeEndDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        ),
      ),
    );
  }
}
