import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/controller/timer_picker.dart';
import 'package:payrun_mobile/modules/leave/view/widget/timmer_text_field_dob.dart';
import 'package:payrun_mobile/utils/app_string.dart';

Widget startTimeFieldLayout({required BuildContext context}) {
  return timerTextField(
    hintText: Get.find<DateTimeController>().pickedInTime.isEmpty
        ? AppString.text_select_time
        : Get.find<DateTimeController>().pickedInTime.value,
    dobIcon: Icons.access_time_outlined,
    dobIconAction: () {
      Get.find<DateTimeController>().isInTimeClicked.value = true;
      timePicker(context, true);
    },
  );
}


Widget outTimeFieldLayout({required BuildContext context}) {
  return timerTextField(
    hintText: Get.find<DateTimeController>().pickedOutTime.isEmpty
        ? AppString.text_select_time
        : Get.find<DateTimeController>().pickedOutTime.value,
    dobIcon: Icons.access_time_outlined,
    dobIconAction: () {
      timePicker(context, true);
    },
  );
}

