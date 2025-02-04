import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../app/modules/leave_hr/presentation/controller/hr_leave_controller.dart';
import '../../../modules/leave/presentation/controller/leave_screen_controller.dart';
import '../../../modules/leave/presentation/controller/update_leave_controller.dart';
import '../../../modules/timeline/controller/timeline_controller.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_style.dart';
import '../../../utils/dimensions.dart';
import '../../controller/date_time_controller.dart';

class CustomTimePickerInTime extends StatelessWidget {
  final String? inDate;
  final String? inTime;

  const CustomTimePickerInTime({this.inDate, this.inTime, super.key});

  @override
  Widget build(BuildContext context) {
    _setDefaultData();
    return Row(
      children: [

        _datePicker(context),
        customSpacerWidth(width: 10),
        _timePicker(context),


      ],
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
      child: Obx(() {
        final inDateTime =
            Get.find<DateTimePickerController>().inDateTime.value;
        final inDate = Get.find<DateTimePickerController>().inDate.value;
        final outDate = Get.find<DateTimePickerController>().outDate.value;

        return GestureDetector(
          onTap: () {
            if (inDate == outDate) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
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
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat('HH:mm').format(DateTime.parse(inDateTime)),
                  style: TextStyle(
                      color: inDate == outDate ? Colors.black : Colors.grey,
                      fontSize: 16),
                ),
                const Icon(
                  CupertinoIcons.clock,
                  color: Colors.grey,
                  size: 28,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _setDefaultData() {
    if (inDate != null) {
      Get.find<DateTimePickerController>().inDate.value =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(inDate!));
      Get.find<DateTimePickerController>().getInDateTime();
    }
    if (inTime != null) {
      Get.find<DateTimePickerController>().inTime.value =
          DateFormat('HH:mm').format(DateTime.parse(inTime!));
      Get.find<DateTimePickerController>().getInDateTime();
    }
  }
}

class InDatePicker extends StatefulWidget {
  final bool? isFromIndividualLeave;

  const InDatePicker({this.isFromIndividualLeave, super.key});

  @override
  State<InDatePicker> createState() => _InDatePickerState();
}

class _InDatePickerState extends State<InDatePicker> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Get.put(HrLeaveController());
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
                Get.find<HrLeaveController>().isUpdateLeaveChangeValue(true);

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
                ///For active timelog details button
                Get.find<TimelineController>().isSelectDate.value = Get.find<DateTimePickerController>().inDate.value;
                ///For active update leave details button
                Get.find<UpDateLeaveController>().isSelectDate.value = Get.find<DateTimePickerController>().inDate.value;


                ///others
                if (!Get.find<LeaveScreenController>().holidays.contains(today.weekday)) {

                  if (widget.isFromIndividualLeave != null && widget.isFromIndividualLeave == true) {
                    Get.find<LeaveScreenController>().date.value = DateFormat('yyyy-MM-dd').format(today);

                    if (!Get.isRegistered<DateTimePickerController>()) {
                      Get.put(DateTimePickerController());
                    }

                    Get.find<DateTimePickerController>().getInDateTime();
                    Get.find<LeaveScreenController>().getLeaveDetailsByDate();
                  } else {
                    if (Get.find<DateTimePickerController>().inDate.value !=
                        DateFormat('yyyy-MM-dd').format(today)) {
                      Get.find<TimelineController>()
                          .isValueChangeForTimeLogUpdate(true);
                    }

                    Get.find<DateTimePickerController>().inDate.value =
                        DateFormat('yyyy-MM-dd').format(today);

                    Get.find<DateTimePickerController>().getInDateTime();
                    setIndexForPrevTdayOrTomListTimelog(today);
                  }
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

class InTimePicker extends StatelessWidget {
  const InTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    String time = '';
    return Column(
      children: [
        CupertinoTimerPicker(
          initialTimerDuration: Duration(
              hours: int.parse(Get.find<DateTimePickerController>()
                  .inTime
                  .value
                  .substring(0, 2)),
              minutes: int.parse(Get.find<DateTimePickerController>()
                  .inTime
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
                    Get.find<DateTimePickerController>().inTime.value =
                        "0${time.toString()}";
                    Get.find<DateTimePickerController>().getInDateTime();
                  } else {
                    Get.find<DateTimePickerController>().inTime.value =
                        time.toString();
                    Get.find<DateTimePickerController>().getInDateTime();
                  }
                  Get.find<UpDateLeaveController>().isSelectDate.value =
                      Get.find<DateTimePickerController>().inTime.value;
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

void setIndexForPrevTdayOrTomListTimelog(DateTime selectedDate) {
  // Get the current date
  DateTime currentDate = DateTime.now();

  // Get yesterday's date
  DateTime yesterdayDate = currentDate.subtract(const Duration(days: 1));
  // Get tomorrow's date
  DateTime tomorrowDate = currentDate.add(const Duration(days: 1));

  // Check if the given date is yesterday
  bool isYesterday = selectedDate.year == yesterdayDate.year &&
      selectedDate.month == yesterdayDate.month &&
      selectedDate.day == yesterdayDate.day;

  bool isTomorrow = selectedDate.year == tomorrowDate.year &&
      selectedDate.month == tomorrowDate.month &&
      selectedDate.day == tomorrowDate.day;

  bool isToday = selectedDate.year == currentDate.year &&
      selectedDate.month == currentDate.month &&
      selectedDate.day == currentDate.day;

  if (isToday) {
    Get.find<DateTimeController>().currentIndex.value = 1;
  } else if (isYesterday) {
    Get.find<DateTimeController>().currentIndex.value = 0;
  } else if (isTomorrow) {
    Get.find<DateTimeController>().currentIndex.value = 2;
  } else {
    Get.find<DateTimeController>().currentIndex.value = 4;
  }
}
