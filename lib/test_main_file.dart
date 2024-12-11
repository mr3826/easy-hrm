import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:table_calendar/table_calendar.dart';

import 'common/widget/timePicker/custom_date_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag-to-Select Range'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final weekendDays = [DateTime.saturday, DateTime.sunday];
            final holidays = [
              '2024-12-25T00:00:00',
              '2025-01-01T00:00:00',
            ];

            final Map<String, DateTime?>? selectedRange = await showDialog<Map<String, DateTime?>>(
              context: context,
              builder: (BuildContext context) {
                return CustomCalendarPicker(
                  isRangeSelectionEnabled: false,
                  weekendDays: weekendDays,
                  holidayDates: holidays,
                );
              },
            );




            if (selectedRange != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Selected Range: ${selectedRange["start"]} - ${selectedRange["end"]}',
                  ),
                ),
              );
            }
          },
          child: Text('Open Calendar'),
        ),
      ),
    );
  }
}

