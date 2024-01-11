import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_helper_controller.dart';
import 'package:payrun_mobile/modules/leave/controller/apply_leave_controller.dart';
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
    if (!Get.isRegistered<ApplyLeaveController>()) {
      Get.lazyPut(() => ApplyLeaveController(), fenix: true);
    }
    if (Get.isRegistered<DateTimeController>()) {
      Get.delete<DateTimeController>();
    }
    Get.put(DateTimeController());
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

}
