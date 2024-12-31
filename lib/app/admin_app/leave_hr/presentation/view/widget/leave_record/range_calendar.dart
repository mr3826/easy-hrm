import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/controller/hr_leave_controller.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/timePicker/custom_date_picker.dart';
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
                      Get.find<CalendarController>().onDaySelected("$index");

                      if (controller.dayList[index] == "Custom" &&
                          controller.listIndex.value == 6) {
                        calendarController.clearRange();
                        _showCustomDateRangeDialog(index, context);

                      } else {
                        Get.find<HrLeaveController>().getLeaveRecord(
                            startDate: "${calendarController.rangeStart}",
                            endDate: "${calendarController.rangeEnd}");

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

void _showCustomDateRangeDialog(int index, context) async {
  final weekendDays = [DateTime.saturday, DateTime.sunday];

  final selectedRange = await showDialog<Map<String, DateTime?>>(
    context: context,
    builder: (BuildContext context) => CustomCalendarPicker(
        isRangeSelectionEnabled: true,
        weekendDays: weekendDays,
        cancelTextStyle: AppStyle.normal_text.copyWith(
            color: AppColor.secondaryColor,
            fontSize: Dimensions.fontSizeDefault + 1),
        baseColor: AppColor.primaryColor,
        holidayDates: const []),
  );
  if (selectedRange != null) {
    var startDate = selectedRange["start"];
    var endDate = selectedRange["end"];

    if (endDate != null) {
      Get.find<HrLeaveController>().getLeaveRecord(
        startDate: startDate.toString(),
        endDate: endDate.toString(),
      );
      Get.back(canPop: false);
    }
  }
}
