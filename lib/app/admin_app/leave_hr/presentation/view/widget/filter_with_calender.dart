import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';

class DateNavigatorWidget extends StatefulWidget {
  final ValueChanged<String> onDateChanged;

  const DateNavigatorWidget({
    Key? key,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  _DateNavigatorWidgetState createState() => _DateNavigatorWidgetState();
}

class _DateNavigatorWidgetState extends State<DateNavigatorWidget> {
  late String currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    widget.onDateChanged(currentDate);
  }

  void _updateDate(int daysToAdd) {
    final date = DateTime.parse(currentDate).add(Duration(days: daysToAdd));
    setState(() {
      currentDate = DateFormat('yyyy-MM-dd').format(date);
    });
    widget.onDateChanged(currentDate);
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
      child: GestureDetector(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalendar(
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: const TextStyle(fontSize: 16),
                        weekendDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.hintColor.withOpacity(.1),
                        ),
                        weekendTextStyle: TextStyle(
                          fontSize: 14,
                          color: AppColor.hintColor.withOpacity(.5),
                        ),
                        selectedDecoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent,
                        ),
                        todayDecoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        todayTextStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      focusedDay: DateTime.parse(currentDate),
                      headerStyle: HeaderStyle(
                        formatButtonShowsNext: false,
                        formatButtonVisible: false,
                        titleTextStyle: AppStyle.mid_large_text.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeDefault + 1,
                        ),
                      ),
                      firstDay: DateTime.utc(DateTime.now().year - 2, 01, 01),
                      lastDay: DateTime.utc(DateTime.now().year + 2, 12, 31),
                      selectedDayPredicate: (day) => isSameDay(day, DateTime.parse(currentDate)),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          currentDate = _formatDate(selectedDay);
                        });
                        widget.onDateChanged(currentDate);
                      },
                    ),
                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                        const SizedBox(width: 40),
                        TextButton(
                          onPressed: () {
                            widget.onDateChanged(currentDate);
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _updateDate(-1),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.normalTextColor,
                      size: 20,
                    ),
                  ),
                  Text(
                    DateFormat("dd MMM yyyy").format(DateTime.now()) == currentDate
                        ? AppString.text_today.tr
                        : DateFormat("dd MMM yyyy").format(DateTime.parse(currentDate)),
                    style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.normalTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _updateDate(1),
                    child: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColor.normalTextColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  DateFormat('EEEE').format(DateTime.parse(currentDate)),
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: Dimensions.fontSizeDefault - 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


