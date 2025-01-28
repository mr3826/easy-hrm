import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../utils/utils.dart';
import '../../bindings/timeline_employee_bindings.dart';
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
    TimelineGlobalBindings().dependencies();
    Get.find<TimelineGlobalController>(). descriptionController.text="";
    Get.find<TimelineGlobalController>().projectId.value = '';
    Get.find<TimelineGlobalController>().taskName.value = '';
    Get.find<TimelineGlobalController>().projectColor.value = '';
    Get.find<TimelineGlobalController>().getProjectList();
  }
}
