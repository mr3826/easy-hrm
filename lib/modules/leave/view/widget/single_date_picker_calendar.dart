import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_helper_controller.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/calendar_date_controller.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';

class SingleDatePicker extends StatefulWidget {
  const SingleDatePicker({Key? key}) : super(key: key);

  @override
  State<SingleDatePicker> createState() => _SingleDatePickerState();
}

class _SingleDatePickerState extends State<SingleDatePicker> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppLayout.getHeight(460),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 3),
            )
          ]),
      margin: EdgeInsets.symmetric(
          horizontal: AppLayout.getWidth(Dimensions.paddingLarge)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TableCalendar(
              calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.primaryColor),
                  todayDecoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  todayTextStyle: AppStyle.extra_large_text_black.copyWith(
                      color: AppColor.primaryColor,
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
                  Get.find<DateTimeController>().requestedDate.value =
                      DateFormat('yyyy-MM-dd').format(selectedDay);
                  //new entry button change
                  Get.find<DateTimeController>().currentIndex.value = 5;
                });
              },
            ),
            Divider(
              color: AppColor.hintColor.withOpacity(0.5),
            ),
            const Spacer(),
            _buttonLayout(onAction: () {
              Get.find<DateController>().currentDate.value = today;
              Get.find<DateTimeController>().timeLogDate.value =
                  today.toString();
              Get.find<LeaveScreenController>().getLeaveDetailsByDate();
              Navigator.pop(context);
            }),
            customSpacerHeight(height: 6),
          ],
        ),
      ),
    );
  }

  _buttonLayout({required onAction}) {
    return Row(
      children: [
        const Spacer(),
        InkWell(
            onTap: () => Get.back(),
            child: Text(
              AppString.text_cancel.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            )),
        customSpacerWidth(width: 40),
        InkWell(
            onTap: () => onAction(),
            child: Text(
              AppString.text_ok.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.primaryColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            )),
        customSpacerWidth(width: 40),
      ],
    );
  }
}

class FromDatePicker extends StatefulWidget {
  const FromDatePicker({super.key});

  @override
  State<FromDatePicker> createState() => _FromDatePickerState();
}

class _FromDatePickerState extends State<FromDatePicker> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppLayout.getHeight(460),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 3),
            )
          ]),
      margin: EdgeInsets.symmetric(
          horizontal: AppLayout.getWidth(Dimensions.paddingLarge)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TableCalendar(
              calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.primaryColor),
                  todayDecoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  todayTextStyle: AppStyle.extra_large_text_black.copyWith(
                      color: AppColor.primaryColor,
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
                  //apply leave requested date
                  Get.find<DateTimeController>().requestedInDate.value =
                      DateFormat('yyyy-MM-dd').format(selectedDay);
                });
              },
            ),
            const Spacer(),
            Divider(
              color: AppColor.hintColor.withOpacity(0.5),
            ),
            _buttonLayout(onAction: () {
              Get.find<DateController>().fromDate.value = today;
              Navigator.pop(context);
            }),
            customSpacerHeight(height: 6),
          ],
        ),
      ),
    );
  }

  _buttonLayout({required onAction}) {
    return Row(
      children: [
        const Spacer(),
        InkWell(
            onTap: () => Get.back(),
            child: Text(
              AppString.text_cancel.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            )),
        customSpacerWidth(width: 40),
        InkWell(
            onTap: () => onAction(),
            child: Text(
              AppString.text_ok.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.primaryColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            )),
        customSpacerWidth(width: 40),
      ],
    );
  }
}

class ToDatePiker extends StatefulWidget {
  const ToDatePiker({super.key});

  @override
  State<ToDatePiker> createState() => _ToDatePikerState();
}

class _ToDatePikerState extends State<ToDatePiker> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppLayout.getHeight(460),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 3),
            )
          ]),
      margin: EdgeInsets.symmetric(
          horizontal: AppLayout.getWidth(Dimensions.paddingLarge)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TableCalendar(
              calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.primaryColor),
                  todayDecoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  todayTextStyle: AppStyle.extra_large_text_black.copyWith(
                      color: AppColor.primaryColor,
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
                  //apply leave requested date
                  Get.find<DateTimeController>().requestedOutDate.value =
                      DateFormat('yyyy-MM-dd').format(selectedDay);
                });
              },
            ),
            Divider(
              color: AppColor.hintColor.withOpacity(0.5),
            ),
            const Spacer(),
            _buttonLayout(onAction: () {
              Get.find<DateController>().toDate.value = today;
              Navigator.pop(context);
            }),
            customSpacerHeight(height: 6),
          ],
        ),
      ),
    );
  }

  _buttonLayout({required onAction}) {
    return Row(
      children: [
        const Spacer(),
        InkWell(
            onTap: () => Get.back(),
            child: Text(
              AppString.text_cancel.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            )),
        customSpacerWidth(width: 40),
        InkWell(
            onTap: () => onAction(),
            child: Text(
              AppString.text_ok.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.primaryColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            )),
        customSpacerWidth(width: 40),
      ],
    );
  }
}
