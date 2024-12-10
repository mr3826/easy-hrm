import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:table_calendar/table_calendar.dart';

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

            final selectedRange = await showDialog<Map<String, DateTime?>>(
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

class CustomCalendarPicker extends StatefulWidget {
  final bool isRangeSelectionEnabled;
  final List<int> weekendDays;
  final List<String> holidayDates;
  final String? cancelText;
  final String? selectionText;
  final String? clearText;

  const CustomCalendarPicker({
    Key? key,
    required this.isRangeSelectionEnabled,
    required this.weekendDays,
    required this.holidayDates,
    this.cancelText,
    this.selectionText,
    this.clearText,
  }) : super(key: key);

  @override
  _CustomCalendarPickerState createState() => _CustomCalendarPickerState();
}

class _CustomCalendarPickerState extends State<CustomCalendarPicker> {
  late String _cancelText;
  late String _selectionText;
  late String _clearText;

  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool isRangeSelected = false; // Dynamic range selection
  late final List<DateTime> parsedHolidays;

  @override
  void initState() {
    super.initState();
    _cancelText = widget.cancelText ?? 'Cancel';
    _selectionText = widget.selectionText ?? 'Select';
    _clearText = widget.clearText ?? 'Clear';
    parsedHolidays = widget.holidayDates.map((holiday) {
      return DateTime.parse(holiday);
    }).toList();
  }

  // Check if the user has selected both range start and end
  bool get isFullRangeSelected {
    return _rangeStart != null &&
        _rangeEnd != null &&
        !_rangeStart!.isAtSameMomentAs(_rangeEnd!);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: DateTime.now(),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarStyle: CalendarStyle(
                  defaultTextStyle: const TextStyle(fontSize: 16),
                  weekendDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.hintColor.withOpacity(.1)),
                  weekendTextStyle: TextStyle(
                      fontSize: 14, color: AppColor.hintColor.withOpacity(.5)),
                  selectedDecoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blueAccent),
                  todayDecoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  todayTextStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                  holidayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent.withOpacity(.25))),
              calendarFormat: CalendarFormat.month,

              rangeSelectionMode: widget.isRangeSelectionEnabled
                  ? RangeSelectionMode.enforced
                  : RangeSelectionMode.disabled,
              // Dynamically toggle between modes
              onRangeSelected: widget.isRangeSelectionEnabled
                  ? (start, end, focusedDay) {
                      setState(() {
                        _rangeStart = start;
                        _rangeEnd = end;
                      });
                    }
                  : null,
              onDaySelected: (selectedDay, focusedDay) {
                if (!widget.isRangeSelectionEnabled) {
                  setState(() {
                    _rangeStart = selectedDay;
                    _rangeEnd = null;
                  });
                }
              },

              // rangeSelectionMode: RangeSelectionMode.enforced,
              // onRangeSelected: (start, end, focusedDay) {
              //   setState(() {
              //     if (start != null && end != null) {
              //       _rangeStart = start;
              //       _rangeEnd = end;
              //     } else if (start != null) {
              //       _rangeStart = start;
              //       _rangeEnd = start; // Handle single date
              //     }
              //     isRangeSelected = _rangeStart != null;
              //   });
              // },
              headerStyle: const HeaderStyle(
                formatButtonShowsNext: false,
                formatButtonVisible: false,
              ),
              holidayPredicate: (day) {
                return parsedHolidays.any((holiday) => isSameDay(holiday, day));
              },
              weekendDays: widget.weekendDays,
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _rangeStart = null;
                      _rangeEnd = null;
                      isRangeSelected = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(_cancelText),
                ),
                if (isFullRangeSelected) // Show "Clear" button only if a full range is selected
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _rangeStart = null;
                        _rangeEnd = null;
                        isRangeSelected = false;
                      });
                    },
                    child: Text(_clearText),
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop({
                      "start": _rangeStart,
                      "end": _rangeEnd,
                    });
                  },
                  child: Text(_selectionText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
