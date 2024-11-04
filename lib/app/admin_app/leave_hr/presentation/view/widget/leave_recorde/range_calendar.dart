import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../controller/calender_controller.dart';
import '../../../controller/leave_controller.dart';

leaveRecodeFilterDialog() {
  var controller = Get.put(LeaveController());
  final CalendarController calendarController = Get.put(CalendarController());

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Obx(() => _createDialogTitle(_retrieveSelectedDate(controller))),

        customSpacerHeight(height: 16),

        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: controller.dayList.length <= 5
                ? controller.dayList.length * 60.0
                : 310,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.dayList.length,
            itemBuilder: (context, index) {
              return Obx(() => InkWell(
                    onTap: () {
                      controller.currentDate.value = controller.dayList[index];
                      controller.listIndex.value = index;

                      print("object ::  ${calendarController.rangeStart}");
                      print("object ::  ${calendarController.rangeEnd}");

                      if (controller.dayList[index] == "Custom" &&
                          controller.listIndex.value == 6) {
                        calendarController.clearRange();
                        _showCustomDateRangeDialog(index);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Container(
                        color: controller.listIndex.value == index
                            ? AppColor.primaryColor.withOpacity(0.1)
                            : AppColor.cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.dayList[index],
                            style: AppStyle.mid_large_text.copyWith(
                              color: controller.listIndex.value == index
                                  ? AppColor.secondaryColor
                                  : AppColor.normalTextColor,
                              fontSize: Dimensions.fontSizeDefault + 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            },
          ),
        ),

        customSpacerHeight(height: 4),

      ],
    ),
  );
}

_createDialogTitle(String text) {
  return Column(
    children: [
      Text(
        text,
        style: AppStyle.mid_large_text.copyWith(
          color: AppColor.secondaryColor,
          fontSize: Dimensions.fontSizeMid - 3,
          fontWeight: FontWeight.bold,
        ),
      ),
      Center(
        child: Text(
          DateFormat('EEEE').format(DateTime.now()),
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault - 1,
          ),
        ),
      ),
    ],
  );
}

String _retrieveSelectedDate(LeaveController controller) {
  return controller.dayList[controller.listIndex.value];
}

void _showCustomDateRangeDialog(int index) {
  final CalendarController calendarController = Get.put(CalendarController());
  showDialog<String>(
    context: Get.context!,
    builder: (BuildContext context) => Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: calendarController.focusedDay.value,
                  rangeSelectionMode:
                      calendarController.rangeSelectionMode.value,
                  rangeStartDay: calendarController.rangeStart.value,
                  rangeEndDay: calendarController.rangeEnd.value,
                  onDaySelected: (selectedDay, focusedDay) {
                    calendarController.selectDay(selectedDay, focusedDay);
                  },
                  onRangeSelected: (start, end, focusedDay) {
                    calendarController.selectRange(start, end, focusedDay);
                  },
                  onPageChanged: (focusedDay) {
                    calendarController.updateFocusedDay(focusedDay);
                  },
                  selectedDayPredicate: (day) {
                    if (calendarController.rangeStart.value != null &&
                        calendarController.rangeEnd.value != null) {
                      return day.isAfter(calendarController.rangeStart.value!
                                  .subtract(const Duration(days: 1))) &&
                              day.isBefore(calendarController.rangeEnd.value!
                                  .add(const Duration(days: 1))) ||
                          day.isAtSameMomentAs(
                              calendarController.rangeStart.value!) ||
                          day.isAtSameMomentAs(
                              calendarController.rangeEnd.value!);
                    }
                    return false;
                  },
                  calendarStyle: CalendarStyle(
                      rangeHighlightColor:
                          AppColor.primaryColor.withOpacity(0.3),
                      rangeStartDecoration: const BoxDecoration(
                        color: AppColor.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      rangeEndDecoration: const BoxDecoration(
                        color: AppColor.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: AppColor.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      isTodayHighlighted: true,
                      holidayDecoration:
                          const BoxDecoration(color: Colors.grey),
                      todayDecoration: const BoxDecoration(
                          color: AppColor.primaryColor,
                          shape: BoxShape.circle)),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                )),
            customSpacerHeight(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    calendarController.clearRange();
                  },
                  child: Text(
                    AppString.textClear.tr,
                    style: AppStyle.normal_text_black,
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: Card(
                      color: AppColor.primaryColor,
                      shape: roundedRectangleBorder.copyWith(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                      child: InkWell(
                        onTap: () {
                          print("object ::  ${calendarController.rangeStart}");
                          print("object ::  ${calendarController.rangeEnd}");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8, left: 20, right: 20),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.done,
                                color: AppColor.cardColor,
                                size: 20,
                              ),
                              customSpacerWidth(width: 8),
                              Text(
                                AppString.text_apply.tr,
                                style: AppStyle.normal_text_black
                                    .copyWith(color: AppColor.cardColor),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
