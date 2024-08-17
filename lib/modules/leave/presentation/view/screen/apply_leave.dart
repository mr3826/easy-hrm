import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/widget/apply_leave_button_layout.dart';
import '../../../../../common/widget/custom_buttom_sheet.dart';

class ApplyLeaveScreen extends StatelessWidget {
  const ApplyLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => customButtonSheetAppbar(
            text: DateTime.parse(
                            Get.find<DateTimePickerController>().inDate.value)
                        .day ==
                    DateTime.parse(
                            Get.find<DateTimePickerController>().outDate.value)
                        .day
                ? DateFormat('d MMMM').format(DateTime.parse(
                    Get.find<DateTimePickerController>().inDate.value))
                : "${DateFormat('d MMMM').format(DateTime.parse(Get.find<DateTimePickerController>().inDate.value))} - ${DateFormat('d MMMM').format(DateTime.parse(Get.find<DateTimePickerController>().outDate.value))}",
            subtext: DateTime.parse(
                            Get.find<DateTimePickerController>().inDate.value)
                        .day ==
                    DateTime.parse(
                            Get.find<DateTimePickerController>().outDate.value)
                        .day
                ? DateFormat('EEEE').format(DateTime.parse(
                    Get.find<DateTimePickerController>().inDate.value))
                : "${DateFormat('EEEE').format(DateTime.parse(Get.find<DateTimePickerController>().inDate.value))} - ${DateFormat('EEEE').format(DateTime.parse(Get.find<DateTimePickerController>().outDate.value))}",
          ),
        ),
        Expanded(child: ApplyLeaveButtonLayout())
      ],
    );
  }
}
