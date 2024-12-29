import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../utils/app_color.dart';

class CustomCalendarPicker extends StatefulWidget {
  final bool isRangeSelectionEnabled;
  final List<int> weekendDays;
  final List<String> holidayDates;
  final String? cancelText;
  final String? selectionText;
  final String? clearText;

  CustomCalendarPicker({
    Key? key,
    required this.isRangeSelectionEnabled,
    required this.weekendDays,
    required this.holidayDates,
    this.cancelText,
    this.selectionText,
    this.clearText,
  })  : assert(weekendDays.isNotEmpty, 'Weekend days cannot be empty.'),
        assert(
          weekendDays
              .every((day) => day >= DateTime.monday && day <= DateTime.sunday),
          'Weekend days must be within the range of 1 (Monday) to 7 (Sunday).',
        ),
        assert(
          holidayDates.every((date) => DateTime.tryParse(date) != null),
          'Holiday dates must be in a valid date format (e.g., "yyyy-MM-dd").',
        ),
        super(key: key);

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
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(DateTime.now().year - 5, 01, 01),
              lastDay: DateTime.utc(DateTime.now().year + 5, 12, 31),
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
                    if (widget.isRangeSelectionEnabled == true) {
                      if (_rangeEnd !=null) {
                        Navigator.of(context).pop({
                          "start": _rangeStart,
                          "end": _rangeEnd,
                        });
                      }
                    } else if (widget.isRangeSelectionEnabled == false) {
                      Navigator.of(context).pop({
                        "start": _rangeStart,
                        "end": _rangeEnd,
                      });
                    }
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
