import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_helper_controller.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
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
  DateTime today = DateTime.now().toUtc();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppLayout.getHeight(550),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 3),
            )
          ]),
      margin: EdgeInsets.symmetric(
          horizontal: AppLayout.getWidth(Dimensions.paddingLarge)),
      child: Column(
        children: [

          customButtonSheetAppbar(text: AppString.text_select_date.tr,subtext: ""),

          TableCalendar(
            calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.primaryColor),
                todayDecoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                todayTextStyle: AppStyle.extra_large_text_black.copyWith(
                    color: AppColor.primaryColor, fontWeight: FontWeight.bold)),
            headerStyle: HeaderStyle(
                titleTextStyle: AppStyle.normal_text.copyWith(
                    color: AppColor.primaryColor, fontWeight: FontWeight.bold),
                titleCentered: true,
                formatButtonVisible: false),
            focusedDay: today,
            firstDay: DateTime.utc(2010, 01, 01),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(day, today),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                today = selectedDay;
              });
            },
          ),
          const Spacer(),
          Padding(
            padding: marginLayout,
            child: CustomDoubleAppButton(buttonText: AppString.text_save.tr, onAction: (){
              Navigator.pop(Get.context!);
              Get.find<DateTimeController>().requestedDate.value = DateFormat('yyyy-MM-dd').format(today);
            }, cancelAction: ()=>Get.back()),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}



