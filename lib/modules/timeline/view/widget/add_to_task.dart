import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_field_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_view_layout.dart';
import '../../../../app/global/controller/exit_app_controller.dart';
import '../../../../app/global/view/widget/app_margin.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../common/widget/custom_dialog.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/utils.dart';
import '../../../../common/widget/custom_title_text_widget.dart';
import '../../../leave/presentation/view/widget/status_btn_widget.dart';

class AddToTaskScreen extends StatelessWidget {
  const AddToTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.find<ExitAppController>().willPopForTimeLog(),
      child: Padding(
        padding: marginLayout.copyWith(top: 30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Obx(
                () => Get.find<TimelineController>().isLoading.isTrue
                    ? _loader()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTitleText(
                              text: AppString.text_project_task.tr,
                              isRequired: true),
                          customSpacerHeight(height: 8),
                          _selectedTaskLayout(context),
                          customSpacerHeight(height: 20),
                          customTitleText(text: AppString.text_description.tr),
                          customSpacerHeight(height: 8),
                          InputNote(controller: descriptionController),
                          customSpacerHeight(height: 50),
                          Get.find<TimelineController>()
                                  .isTimelogEntryOrRemoveLoading
                                  .isTrue
                              ? const Center(
                                  child: CupertinoActivityIndicator(
                                    color: AppColor.primaryColor,
                                    radius: 15,
                                  ),
                                )
                              : CustomDoubleAppButton(
                                  buttonText: AppString.text_save.tr,
                                  onAction: () async {
                                    Get.find<TimelineController>()
                                        .saveTimeEntry();
                                  },
                                  cancelText: AppString.text_remove,
                                  cancelAction: () {
                                    showCustomAlertDialog(
                                        context: context,
                                        onConfirm: () async {
                                          Get.find<TimelineController>()
                                              .removeTimeEntry()
                                              .then((value) {
                                            if (value == true) {
                                              Navigator.pop(context);
                                            }
                                          });
                                        },
                                        iconData: CupertinoIcons.delete,
                                        titleText:
                                            AppString.text_remove_timelog.tr,
                                        descriptionText: AppString
                                            .text_sure_you_want_to_delete_timelog
                                            .tr,
                                        iconBackgroundColor: AppColor.errorColorLight,
                                        confirmButtonColor: AppColor.errorColorLight,
                                        confirmButtonText: "",
                                        extraInfoText: "",
                                        descriptionFontSize: Dimensions.fontSizeDefault,
                                        confirmButtonChild:
                                            Obx(() => removeTextLayout()));
                                  }),
                        ],
                      ),
              )),
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

  _loader() {
    return const Column(
      children: [
        Spacer(),
        CupertinoActivityIndicator(
          color: AppColor.primaryColor,
          radius: 15,
        ),
        Spacer(
          flex: 3,
        ),
      ],
    );
  }
}
