import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/timePicker/custom_time_picker_in_time.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/common/widget/timePicker/custom_time_picker_out_time.dart';
import 'package:payrun_mobile/common/widget/warning_message.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/apply_leave_controller.dart';
import 'package:payrun_mobile/modules/leave/view/widget/add_attachemnt_file_widget.dart';
import 'package:payrun_mobile/modules/leave/view/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../controller/file_upload_controller.dart';
import 'apply_leave_dropdown.dart';

class ApplyLeaveButtonLayout extends GetView<ApplyLeaveController> {
  ApplyLeaveButtonLayout({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Padding(
              padding: marginLayout.copyWith(top: Dimensions.fontSizeMid),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTitleText(
                          text: AppString.text_leave_type.tr, isRequired: true),
                      customSpacerHeight(height: 8),
                      const ApplyLeaveDropDown(),
                      customSpacerHeight(height: 8),
                      _leaveCountStyleLayout(),
                      customSpacerHeight(height: 20),
                      customTitleText(
                          text: AppString.text_from.tr, isRequired: true),
                      customSpacerHeight(height: 8),
                      Get.find<ApplyLeaveController>().startTime != null
                          ? CustomTimePickerInTime(
                              inTime:
                                  "2024-01-01 ${Get.find<ApplyLeaveController>().startTime}",
                            )
                          : const CustomTimePickerInTime(),
                      customSpacerHeight(height: 20),
                      customTitleText(
                          text: AppString.text_to.tr, isRequired: true),
                      customSpacerHeight(height: 8),
                      Get.find<ApplyLeaveController>().endTime != null
                          ? CustomTimePickerOutTime(
                              outTime:
                                  "2024-01-01 ${Get.find<ApplyLeaveController>().endTime}",
                            )
                          : const CustomTimePickerOutTime(),
                      customSpacerHeight(height: 12),
                      customSpacerHeight(height: 18),
                      Obx(() => Row(
                            children: [
                              customTitleText(text: AppString.text_note.tr),
                              customSpacerWidth(width: 6),
                              Get.find<ApplyLeaveController>()
                                      .isNoteRequired
                                      .isTrue
                                  ? customTitleTextRedText(text: "*")
                                  : Container(),
                            ],
                          )),
                      customSpacerHeight(height: 8),
                      _noteTextField(),
                      Obx(() => Row(
                            children: [
                              customTitleText(text: AppString.text_document.tr),
                              customSpacerWidth(width: 6),
                              Get.find<ApplyLeaveController>()
                                      .isDocumentRequired
                                      .isTrue
                                  ? customTitleTextRedText(text: "*")
                                  : Container(),
                            ],
                          )),
                      customSpacerHeight(height: 6),
                      _pathFormatText(),
                      customSpacerHeight(height: 8),
                      AddAttachmentFile(
                        isFromApplyLeave: true,
                      ),
                      customSpacerHeight(height: 20),
                      Obx(() => Get.find<ApplyLeaveController>()
                              .isAssignLeaveLoaderLoading
                              .isTrue
                          ? const Center(
                              child: CupertinoActivityIndicator(
                                color: Colors.blueAccent,
                                radius: 18,
                              ),
                            )
                          : CustomDoubleAppButton(
                              onAction: () {
                                if (_formKey.currentState!.validate() &&
                                    Get.find<ApplyLeaveController>()
                                        .leaveId
                                        .isNotEmpty) {
                                  Get.find<ApplyLeaveController>().applyLeave();
                                } else {
                                  showWarningMessage(
                                      message: "Provide a Valid Input");
                                }
                              },
                              buttonText: AppString.text_apply.tr,
                              cancelAction: () {
                                Navigator.pop(context);
                                Get.find<FileUploadController>()
                                    .storageForUpload
                                    .filePath
                                    .value = "";
                              },
                            )),
                      customSpacerHeight(height: 100),
                    ],
                  ),
                ),
              ),
            ),
        onLoading: const Center(
          child: CupertinoActivityIndicator(
            color: Colors.blueAccent,
            radius: 18,
          ),
        ));
  }

  _noteTextField() {
    return InputNote(
      validator: (value) {
        if (Get.find<ApplyLeaveController>().isNoteRequired.isTrue) {
          if (value!.isEmpty) {
            return "";
          } else {
            return null;
          }
        }
      },
      controller: leaveNoteController,
      hintText: AppString.text_add_note.tr,
    );
  }

  _pathFormatText() {
    return Text(
      AppString.text_jpeg_jpg_png_etc,
      style: AppStyle.normal_text_black
          .copyWith(color: AppColor.hintColor.withOpacity(0.7)),
    );
  }

  _leaveCountStyleLayout() {
    return Obx(
        () => Get.find<ApplyLeaveController>().numberOfLeaves.value.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 0,
                  shape: roundedRectangleBorder,
                  color: AppColor.primaryColor.withOpacity(0.05),
                  child: Padding(
                    padding: marginLayout.copyWith(
                        top: 8, bottom: 8, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Get.find<ApplyLeaveController>().numberOfLeaves.value,
                          style: AppStyle.mid_large_text
                              .copyWith(color: AppColor.normalTextColor),
                        ),
                        Text(
                          "Balance (No.of days)",
                          style: AppStyle.mid_large_text.copyWith(
                              color: AppColor.hintColor,
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container());
  }
}
