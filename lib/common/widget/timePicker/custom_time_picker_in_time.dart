import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_style.dart';
import '../../../utils/dimensions.dart';

class CustomTimePickerInTime extends StatelessWidget {
  final String? inDate;
  final String? inTime;

  const CustomTimePickerInTime({this.inDate, this.inTime, super.key});

  @override
  Widget build(BuildContext context) {
    _setDefaultData();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          _datePicker(context),
          customSpacerWidth(width: 10),
          _timePicker(context),
        ],
      ),
    );
  }

  _datePicker(BuildContext context) {
    return Expanded(
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
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InDatePicker(),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.parse(
                      Get.find<DateTimePickerController>().inDateTime.value)),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                )),
            const Icon(
              CupertinoIcons.calendar,
              color: Colors.grey,
              size: 28,
            ),
          ],
        ),
      ),
    ));
  }

  _timePicker(BuildContext context) {
    return Expanded(
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
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InTimePicker(),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                DateFormat('HH:mm:ss').format(DateTime.parse(
                    Get.find<DateTimePickerController>().inDateTime.value)),
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            const Icon(
              CupertinoIcons.clock,
              color: Colors.grey,
              size: 28,
            ),
          ],
        ),
      ),
    ));
  }

  void _setDefaultData() {
    if (inDate != null) {
      Get.find<DateTimePickerController>().inDate.value =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(inDate!));
      Get.find<DateTimePickerController>().getInDateTime();
    }
    if (inTime != null) {
      Get.find<DateTimePickerController>().inTime.value =
          DateFormat('HH:mm:ss').format(DateTime.parse(inTime!));
      Get.find<DateTimePickerController>().getInDateTime();
    }
  }
}

class InDatePicker extends StatefulWidget {
  const InDatePicker({super.key});

  @override
  State<InDatePicker> createState() => _InDatePickerState();
}

class _InDatePickerState extends State<InDatePicker> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TableCalendar(
            calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(fontSize: 16),
                weekendTextStyle: TextStyle(fontSize: 16),
                selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blueAccent),
                todayDecoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                todayTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold)),
            calendarFormat: CalendarFormat.month,
            focusedDay: today,
            headerStyle: HeaderStyle(
              formatButtonShowsNext: false,
              formatButtonVisible: false,
              titleTextStyle: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
            firstDay: DateTime.utc(2010, 01, 01),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(day, today),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                today = selectedDay;
              });
            },
          ),
        ),
        const Divider(color: Colors.grey),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: const SizedBox(
                width: 50,
                child: Text('Close'),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 40),
            GestureDetector(
              child: const SizedBox(width: 50, child: Text('Ok')),
              onTap: () {
                Get.find<DateTimePickerController>().inDate.value =
                    DateFormat('yyyy-MM-dd').format(today);
                Get.find<DateTimePickerController>().getInDateTime();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class InTimePicker extends StatelessWidget {
  const InTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    String time = '';
    return Column(
      children: [
        CupertinoTimerPicker(
          mode: CupertinoTimerPickerMode.hms,
          backgroundColor: Colors.white,
          onTimerDurationChanged: (value) {
            time = value.toString();
          },
        ),
        const Divider(color: Colors.grey),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: const SizedBox(
                width: 50,
                child: Text('Close'),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 40),
            GestureDetector(
              child: const SizedBox(width: 50, child: Text('Ok')),
              onTap: () {
                if (time.isNotEmpty) {
                  // set time in 00:00:00 format
                  if (time.length < 15) {
                    Get.find<DateTimePickerController>().inTime.value =
                        "0${time.toString()}";
                    Get.find<DateTimePickerController>().getInDateTime();
                  } else {
                    Get.find<DateTimePickerController>().inTime.value =
                        time.toString();
                    Get.find<DateTimePickerController>().getInDateTime();
                  }
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}




