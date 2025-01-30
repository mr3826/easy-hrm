import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../common/controller/date_time_controller.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../global/view/widgets/custom_date_picker.dart';
import '../../../controllers/time_sheet_controller.dart';

class BuildSelectMonth extends GetView<TimeSheetController> {
  const BuildSelectMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 10),
      child: GestureDetector(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                Dialog(child: _openDateRangeDialog()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        Dialog(child: _openDateRangeDialog()),
                  );
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.normalTextColor,
                  size: 18,
                ),
              ),
              Obx(
                () => Column(
                  children: [
                    Text(
                      controller.currentDate.value,
                      style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.secondaryColor,
                        fontSize: Dimensions.fontSizeDefault + 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        Dialog(child: _openDateRangeDialog()),
                  );
                },
                child: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColor.normalTextColor,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openDateRangeDialog() {
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
                    : 310),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.dayList.length,
              itemBuilder: (context, index) {
                return Obx(() => InkWell(
                      onTap: () {
                        controller.currentDate.value = controller.dayList[index];
                        controller.listIndex.value = index;
                        controller.onDaySelected(index.toString());
                        if (controller.dayList[index] == "Custom" &&
                            controller.listIndex.value == 6) {
                          controller.clearRange();
                          _showCustomDateRangeDialog(index, context);
                        } else {

                          Get.find<DateTimeController>().requestedDate.value=formatDate(date: controller.rangeStart.toString(),format: "yyyy-MM-dd");
                          Get.find<DateTimeController>().requestedEndDate.value=formatDate(date: controller.rangeStart.toString(),format: "yyyy-MM-dd");
                          controller.getTimesheetByDate();
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

String _retrieveSelectedDate(TimeSheetController controller) {
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
    DateTime? startDate = selectedRange["start"];
    DateTime? endDate = selectedRange["end"];
    Get.find<DateTimeController>().requestedDate.value=formatDate(date: startDate.toString(),format: "yyyy-MM-dd");
    Get.find<DateTimeController>().requestedEndDate.value=formatDate(date: endDate.toString(),format: "yyyy-MM-dd");
    Get.find<TimeSheetController>().getTimesheetByDate();
    Get.back(canPop: false);
  }
}
