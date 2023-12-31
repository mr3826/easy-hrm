import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/home/view/screen/main_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/controller/timer_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_field_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_view_layout.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../enum.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/utils.dart';
import '../../../leave/view/widget/custom_title_text_widget.dart';
import '../../controller/timer_controller.dart';

class AddToTaskScreen extends StatelessWidget {
  const AddToTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TimeCounterController _timeCounterController =
    Get.put(TimeCounterController());
    return Padding(
      padding: marginLayout.copyWith(top: 30),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTitleText(text: AppString.text_project_or_task.tr),
              customSpacerHeight(height: 8),
              _selectedTaskLayout(context),
              customSpacerHeight(height: 20),
              customTitleText(text: AppString.text_description.tr),
              customSpacerHeight(height: 8),
              InputNote(
                controller: descriptionController,
              ),
              customSpacerHeight(height: 50),
              CustomDoubleAppButton(
                  buttonText: AppString.text_save.tr,
                  onAction: () async {
                    if (Get.find<TimeCounterController>().isRunning.isTrue) {
                      await Get.find<TimelineController>()
                          .startOrEndTimer(timerType: StartOrEndTimer.end.name);
                    }
                    Get.find<TimelineController>().saveTimeEntry();
                    Get.to(() => MainScreen(
                          routeIndex: 0,
                        ));
                  },
                  cancelAction: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  _selectedTaskLayout(context) {
    return taskInputFieldLayout(onAction: () {
      customButtonSheet(
          context: context, child: const TaskViewLayout(), height: .6);
    });
  }
}
