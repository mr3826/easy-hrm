import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/controller/date_time_helper_controller.dart';
import 'package:payrun_mobile/modules/leave/view/widget/apply_leave_button_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../model/leave_records.dart';

class ApplyLeaveScreen extends StatelessWidget {
  String? startDate;
  String? endDate;
  bool? isForUpdateLeave;
  GetLeaveRecords? leaveRecords;

  ApplyLeaveScreen(
      {this.startDate,
      this.endDate,
      this.isForUpdateLeave,
      this.leaveRecords,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<DateTimeController>()) {
      Get.delete<DateTimeController>();
    }
    Get.put(DateTimeController());
    if (isForUpdateLeave == true) {
      _updateTimeAccourdingWithData();
    }
    return Column(
      children: [
        customButtonSheetAppbar(
            text: isForUpdateLeave == true
                ? AppString.updateLeaveTest.tr
                : AppString.text_apply_leve.tr,
            subtext: ""),
        Expanded(
            child: ApplyLeaveButtonLayout(isForUpdateLeave: isForUpdateLeave))
      ],
    );
  }

  void _updateTimeAccourdingWithData() {
    Get.find<DateTimeController>().requestedInDate.value =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(
            leaveRecords?.startDate ?? DateTime.now().toString()));
    Get.find<DateTimeController>().requestedOutDate.value =
        DateFormat('yyyy-MM-dd').format(
            DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()));

    Get.find<DateTimeController>().pickedInTime.value =
        "${(DateTime.parse(leaveRecords?.startDate ?? DateTime.now().toString()).hour >= 12 ? DateTime.parse(leaveRecords?.startDate ?? DateTime.now().toString()).hour - 12 : DateTime.parse(leaveRecords?.startDate ?? DateTime.now().toString()).hour).toString().padLeft(2, '0')}:${(DateTime.parse(leaveRecords?.startDate ?? DateTime.now().toString()).minute.toString()).padLeft(2, "0")}${DateTime.parse(leaveRecords?.startDate ?? DateTime.now().toString()).hour >= 12 ? "PM" : "AM"}";
    Get.find<DateTimeController>().pickedOutTime.value =
        "${(DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()).hour >= 12 ? DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()).hour - 12 : DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()).hour).toString().padLeft(2, '0')}:${(DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()).minute.toString()).padLeft(2, "0")}${DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()).hour >= 12 ? "PM" : "AM"}";

    Get.find<DateTimeController>().getUpdateLeaveTime();
  }
}
