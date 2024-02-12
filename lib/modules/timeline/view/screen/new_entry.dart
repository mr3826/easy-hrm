import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/new_entry_text_field_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';

class NewEntryScreen extends StatelessWidget {
  const NewEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<DateTimePickerController>()) {
      Get.delete<DateTimePickerController>();
    }

    Get.put(DateTimePickerController());

    Get.find<TimelineController>().projectId.value='';
    Get.find<TimelineController>().taskName.value='';
    Get.find<TimelineController>().projectColor.value='';

    if (Get.find<TimelineController>()
        .projectDropDownResponse
        ?.getProjectsDropdown ==
        null) {
      Get.find<TimelineController>().getProjectDropdown();
    }

    return Scaffold(
      appBar: customAppbar(title: AppString.text_new_entry.tr),
      backgroundColor: AppColor.bgColorWithTimeline,
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TimeLogEntryTextField()],
        ),
      ),
    );
  }
}
