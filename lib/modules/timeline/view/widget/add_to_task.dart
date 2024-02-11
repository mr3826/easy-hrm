import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_field_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_view_layout.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../common/widget/custom_dialog.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/utils.dart';
import '../../../leave/view/widget/custom_title_text_widget.dart';
import '../../../starting/view/onboarding_screen.dart';

class AddToTaskScreen extends StatelessWidget {
  const AddToTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExitAppController exitAppController = Get.put(ExitAppController());
    return WillPopScope(
      onWillPop: () => exitAppController.willPopForTimeLog(),
      child: Padding(
        padding: marginLayout.copyWith(top: 30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTitleText(
                    text: AppString.text_project_task.tr, isRequired: true),
                customSpacerHeight(height: 8),
                _selectedTaskLayout(context),
                customSpacerHeight(height: 20),
                customTitleText(text: AppString.text_description.tr),
                customSpacerHeight(height: 8),
                InputNote(
                  controller: descriptionController,
                ),
                customSpacerHeight(height: 50),
                Obx(
                  () => Get.find<TimelineController>()
                          .isTimelogEntryOrRemoveLoading
                          .isTrue
                      ? const Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.blueAccent,
                            radius: 16,
                          ),
                        )
                      : CustomDoubleAppButton(
                          buttonText: AppString.text_save.tr,
                          onAction: () async {
                            Get.find<TimelineController>().saveTimeEntry();
                          },
                          cancelText: AppString.text_remove,
                          cancelAction: () {
                            Get.find<TimelineController>().removeTimeEntry();
                          }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _removeText() {
    return Get.find<TimelineController>().isTimelogRemoveLoading.isTrue
        ? const CupertinoActivityIndicator(
            color: AppColor.cardColor,
          )
        : Text(AppString.text_remove.tr,
            style: AppStyle.normal_text.copyWith(
                color: AppColor.cardColor,
                fontSize: Dimensions.fontSizeMid - 3,
                fontWeight: FontWeight.w700));
  }

  _selectedTaskLayout(context) {
    return taskInputFieldLayout(onAction: () {
      customButtonSheet(
          context: context, child: const TaskViewLayout(), height: .6);
    });
  }
}
