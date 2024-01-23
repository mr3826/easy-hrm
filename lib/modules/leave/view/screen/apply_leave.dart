import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/leave/controller/apply_leave_controller.dart';
import 'package:payrun_mobile/modules/leave/view/widget/apply_leave_button_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../model/leave_records.dart';

class ApplyLeaveScreen extends StatelessWidget {
  String? startDate;
  String? endDate;
  GetLeaveRecords? leaveRecords;

  ApplyLeaveScreen(
      {this.startDate, this.endDate, this.leaveRecords, super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ApplyLeaveController>()) {
      Get.lazyPut(() => ApplyLeaveController(), fenix: true);
    }
    if (Get.isRegistered<DateTimePickerController>()) {
      Get.delete<DateTimePickerController>();
    }
    Get.put(DateTimePickerController());

    return Column(
      children: [
        customButtonSheetAppbar(
            text: DateFormat('d MMMM').format(DateTime.parse(
                Get.find<DateTimePickerController>().inDateTime.value)),
            subtext: DateFormat('EEEE').format(DateTime.parse(
                Get.find<DateTimePickerController>().inDateTime.value))),
        Expanded(child: ApplyLeaveButtonLayout())
      ],
    );
  }
}
