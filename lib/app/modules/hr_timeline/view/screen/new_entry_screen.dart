import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../utils/utils.dart';
import '../widgets/timeline_calender/new_entry/build_new_entry_text_field.dart';


class AddTimeEntryScreen extends StatelessWidget {
  const AddTimeEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    _updatedTimeEntry();
    return Scaffold(
      appBar: customAppbar(title: AppString.text_new_entry.tr),
      backgroundColor: AppColor.bgColorWithTimeline,
      body: const BuildNewEntryTextField(),
    );
  }

  void _updatedTimeEntry() {
    descriptionController.text="";
    Get.find<TimelineController>().projectId.value = '';
    Get.find<TimelineController>().taskName.value = '';
    Get.find<TimelineController>().projectColor.value = '';
    Get.find<TimelineController>().getProjectDropdown();
  }
}
