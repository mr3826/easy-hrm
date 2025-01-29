import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/employee_timeline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_field_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_view_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../global/controller/exit_app_controller.dart';
import '../../../controllers/global_timline_controller.dart';
import '../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../../modules/leave/presentation/view/widget/custom_title_text_widget.dart';
import '../../../../../../modules/leave/presentation/view/widget/status_btn_widget.dart';

class AddToTaskScreen extends StatelessWidget {
  final bool isEmployee;
  const AddToTaskScreen({super.key, required this.isEmployee});

  @override
  Widget build(BuildContext context) {
    print("isEmployee : $isEmployee");
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
                () => Get.find<TimelineGlobalController>()
                        .isProjectListLoading
                        .isTrue
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
                          _buildButton(context)
                        ],
                      ),
              )),
        ),
      ),
    );
  }

  _selectedTaskLayout(BuildContext context) {
    return taskInputFieldLayout(
        onAction: () {
          customButtonSheet(
              context: context,
              child: TaskViewLayout(
                isEmployee: isEmployee,
              ),
              height: .6);
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

  _buildButton(BuildContext context) {
    ///For employee only save button
    if (isEmployee) {
      return Get.find<EmployeeTimelineController>()
              .isTimelogEntryOrRemoveLoading
              .isTrue
          ? const Center(
              child: CupertinoActivityIndicator(
                color: AppColor.primaryColor,
                radius: 15,
              ),
            )
          : CustomAppButton(
              borderRadius: 50,
              buttonText: Text(
                AppString.text_save.tr,
                style: AppStyle.normal_text_grey
                    .copyWith(color: AppColor.cardColor),
              ),
              onPressed: () {
                Get.find<EmployeeTimelineController>().saveTimeEntry();
              },
              buttonColor: AppColor.primaryColor);
    } else {
      ///For admin  save button and remove button
      return Get.find<TimelineGlobalController>()
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
                Get.find<TimelineGlobalController>().saveTimelineEntry();
              },
              cancelText: AppString.text_remove,
              cancelAction: () {
                showCustomAlertDialog(
                    context: context,
                    onConfirm: () async {
                      Get.find<HrTimelineController>()
                          .removeTimelineEntry()
                          .then((value) {
                        if (value == true) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    iconData: CupertinoIcons.delete,
                    titleText: AppString.text_remove_timelog.tr,
                    descriptionText:
                        AppString.text_sure_you_want_to_delete_timelog.tr,
                    iconBackgroundColor: AppColor.errorColorLight,
                    confirmButtonColor: AppColor.errorColorLight,
                    confirmButtonText: "",
                    extraInfoText: "",
                    descriptionFontSize: Dimensions.fontSizeDefault,
                    confirmButtonChild: Obx(() =>
                        Get.find<TimelineGlobalController>()
                                .isTimelogEntryOrRemoveLoading
                                .value
                            ? const CupertinoActivityIndicator(
                                color: AppColor.cardColor,
                              )
                            : removeTextLayout()));
              });
    }
  }
}
