import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/apply_leave_controller.dart';
import 'package:payrun_mobile/modules/leave/controller/calendar_date_controller.dart';
import 'package:payrun_mobile/modules/leave/view/widget/add_attachemnt_file_widget.dart';
import 'package:payrun_mobile/modules/leave/view/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/modules/leave/view/widget/single_date_picker_calendar.dart';
import 'package:payrun_mobile/modules/leave/view/widget/srart_time_field_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../controller/file_upload_controller.dart';
import 'apply_leave_dropdown.dart';
import 'date_pickar_field_widget.dart';

class ApplyLeaveButtonLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Build called");
    return Obx(() => Get.find<ApplyLeaveController>().isLoading.isFalse
        ? Padding(
            padding: marginLayout.copyWith(top: Dimensions.fontSizeMid),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTitleText(text: AppString.text_leave_type.tr),
                  customSpacerHeight(height: 8),
                  const ApplyLeaveDropDown(),
                  customSpacerHeight(height: 8),
                  _leaveCountStyleLayout(),
                  customSpacerHeight(height: 20),
                  customTitleText(text: "${AppString.text_from.tr} *"),
                  customSpacerHeight(height: 8),
                  Obx(
                    () => _fromDateTimeLayout(),
                  ),
                  customSpacerHeight(height: 20),
                  customTitleText(text: "${AppString.text_to.tr} *"),
                  customSpacerHeight(height: 8),
                  Obx(
                    () => _toDateTimeLayout(),
                  ),
                  customSpacerHeight(height: 12),
                  _errorAlertLayout(),
                  customSpacerHeight(height: 18),
                  customTitleText(text: AppString.text_note.tr),
                  customSpacerHeight(height: 8),
                  _noteTextField(),
                  customTitleText(text: AppString.text_document.tr),
                  customSpacerHeight(height: 6),
                  _pathFormatText(),
                  customSpacerHeight(height: 8),
                  const AddAttachmentFile(),
                  customSpacerHeight(height: 20),
                  CustomDoubleAppButton(
                    onAction: () {},
                    buttonText: AppString.text_apply.tr,
                    cancelAction: () {
                      Navigator.pop(context);
                      Get.find<FileUploadController>()
                          .storageForUpload
                          .filePath
                          .value = "";
                    },
                  ),
                  customSpacerHeight(height: 100),
                ],
              ),
            ),
          )
        : const Center(
            child: CupertinoActivityIndicator(
                color: Colors.blueAccent, radius: 18),
          ));
  }

  _noteTextField() {
    return InputNote(
      controller: leaveNoteController,
      hintText: AppString.text_add_note.tr,
    );
  }

  _fromDateTimeLayout() {
    return Row(
      children: [
        Expanded(
            child: dateLayoutField(
                date: Get.find<DateController>().fromDate.toString(),
                onAction: () {
                  showDialog(
                    context: Get.context!,
                    builder: (context) {
                      return const Dialog(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          insetPadding: EdgeInsets.zero,
                          child: FromDatePicker());
                    },
                  );
                })),
        customSpacerWidth(width: 14),
        Expanded(child: startTimeFieldLayout(context: Get.context!)),
      ],
    );
  }

  _toDateTimeLayout() {
    return Row(
      children: [
        Expanded(
            child: dateLayoutField(
                date: Get.find<DateController>().toDate.toString(),
                onAction: () {
                  showDialog(
                    context: Get.context!,
                    builder: (context) {
                      return const Dialog(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          insetPadding: EdgeInsets.zero,
                          child: ToDatePiker());
                    },
                  );
                })),
        customSpacerWidth(width: 14),
        Expanded(child: startTimeFieldLayout(context: Get.context!)),
      ],
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
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder,
        color: AppColor.primaryColor.withOpacity(0.05),
        child: Padding(
          padding:
              marginLayout.copyWith(top: 8, bottom: 8, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "01",
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
    );
  }

  _errorAlertLayout() {
    return SizedBox(
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder,
        color: AppColor.errorColorLight.withOpacity(0.08),
        child: Column(
          children: [
            Row(
              children: [
                customSpacerWidth(width: 12),
                const Icon(
                  Icons.error_outline,
                  color: AppColor.errorColorLight,
                  size: 18,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        marginLayout.copyWith(bottom: 12, top: 12, left: 12),
                    child: Text(
                      "Out of balance.The selected leave duration is out of the facility.Tou may have some Taken,approved or pending leave that affect your new request.",
                      style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.errorColorLight,
                          fontSize: Dimensions.fontSizeDefault - 2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
