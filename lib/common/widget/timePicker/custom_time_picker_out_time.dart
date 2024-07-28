import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../modules/leave/controller/leave_screen_controller.dart';
import '../../../modules/leave/controller/update_leave_controller.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_style.dart';
import '../../../utils/dimensions.dart';

class CustomTimePickerOutTime extends StatelessWidget {
  final String? outDate;
  final String? outTime;

  const CustomTimePickerOutTime({this.outDate, this.outTime, super.key});

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
                  OutDatePicker(),
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
                      Get.find<DateTimePickerController>().outDateTime.value)),
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
                  OutTimePicker(),
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
                DateFormat('HH:mm').format(DateTime.parse(
                    Get.find<DateTimePickerController>().outDateTime.value)),
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
    if (outDate != null) {
      Get.find<DateTimePickerController>().inDate.value =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(outDate!));
      Get.find<DateTimePickerController>().getOutDateTime();
    }
    if (outTime != null) {
      Get.find<DateTimePickerController>().outTime.value =
          DateFormat('HH:mm').format(DateTime.parse(outTime!));
      Get.find<DateTimePickerController>().getOutDateTime();
    }
  }
}

class OutDatePicker extends StatefulWidget {
  const OutDatePicker({super.key});

  @override
  State<OutDatePicker> createState() => _OutDatePickerState();
}

class _OutDatePickerState extends State<OutDatePicker> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TableCalendar(
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
            firstDay: DateTime.utc(DateTime.now().year - 2, 01, 01),
            lastDay: DateTime.utc(DateTime.now().year + 2, 12, 31),
            selectedDayPredicate: (day) => isSameDay(day, today),
            weekendDays: Get.find<LeaveScreenController>().holidays,
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

                if (!Get.find<LeaveScreenController>()
                    .holidays
                    .contains(today.weekday)) {
                  Get.find<DateTimePickerController>().outDate.value =
                      DateFormat('yyyy-MM-dd').format(today);
                  Get.find<DateTimePickerController>().getOutDateTime();
                  ///For active update leave details button
                  Get.find<UpDateLeaveController>().isSelectDate.value= Get.find<DateTimePickerController>().outDate.value;
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class OutTimePicker extends StatelessWidget {
  const OutTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    String time = '';
    return Column(
      children: [
        CupertinoTimerPicker(
          initialTimerDuration: Duration(
              hours: int.parse(Get.find<DateTimePickerController>()
                  .outDate
                  .value
                  .substring(0, 2)),
              minutes: int.parse(Get.find<DateTimePickerController>()
                  .outTime
                  .value
                  .substring(3, 5))),
          mode: CupertinoTimerPickerMode.hm,
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
                    Get.find<DateTimePickerController>().outTime.value =
                        "0${time.toString()}";
                    Get.find<DateTimePickerController>().getOutDateTime();
                  } else {
                    Get.find<DateTimePickerController>().outTime.value =
                        time.toString();
                    Get.find<DateTimePickerController>().getOutDateTime();
                  }
                  Get.find<UpDateLeaveController>().isSelectDate.value= Get.find<DateTimePickerController>().outTime.value;

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
