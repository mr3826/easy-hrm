import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/app/global/view/widgets/status_btn_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../app/global/view/widget/app_margin.dart';
import '../../../../../app/modules/leave_hr/presentation/controller/leave_controller.dart';
import '../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../utils/utils.dart';
import 'package:payrun_mobile/app/modules/leave_hr/presentation/model/leave_details_by_id.dart';
import '../../../../../app/modules/leave_hr/presentation/controller/hr_leave_controller.dart';
import '../../../../../app/modules/leave_hr/presentation/view/widget/leave_record/leave_record_details/edit_leave_record/edit_leave_record_details.dart';


class LeaveRecordDetailsById extends StatelessWidget {
  final GetLeaveDetailsById? data;
final  bool isEmployee;
  const LeaveRecordDetailsById({super.key, this.data,required this.isEmployee});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                customButtonSheetAppbar(
                    text: "",
                    subtext: _getDate(data ?? GetLeaveDetailsById()),
                    isLeave: true,
                    status: data?.status ?? "",
                    duration: getLeaveDuration(data?.totalDuration,
                        data?.numberOfDays.toString() ?? "")),
                customSpacerHeight(height: 12),
                _infoLayoutById(
                    text: AppString.text_type_dot.tr,
                    dynamicText: data?.leaveType?.type ?? ""),
                _infoLayoutById(
                    text: "${AppString.text_duration.tr}:",
                    dynamicText: getLeaveDuration(data?.totalDuration,
                        data?.numberOfDays.toString() ?? "")),
                _infoLayoutById(
                    text: AppString.text_satus.tr,
                    widget: _statusBtnById(data?.status ?? "")),
                _infoLayoutById(
                    text: AppString.text_date_of_application.tr,
                    dynamicText:
                        dateMonthYearFormatFromDatetime(data?.createdAt ?? "")),
                customSpacerHeight(height: 50),
                _buttonLayoutById(
                    context, data?.status ?? "", data ?? GetLeaveDetailsById())
              ],
            ),
          );
  }


  _buttonLayoutById(
      BuildContext context, String status, GetLeaveDetailsById leaveRecords) {
    if (status == "rejected") {
      return _rejectedBtnById(context, leaveRecords);
    } else if (status == "pending") {
      return _pendingLayoutById(context, leaveRecords);
    } else if (status == "token") {
      return Container();
    } else if (status == LeaveStatus.approved.name) {
      return _approvedLayout(context, leaveRecords);
    } else if (status == LeaveStatus.cancelled.name) {
      return Container();
    } else {
      return Container();
    }
  }

  _statusBtnById(String status) {
    if (status == "rejected") {
      return rejectedStatusBtn();
    } else if (status == "pending") {
      return pendingStatusBtn();
    } else if (status == "token") {
      return tokenStatusBtn();
    } else if (status == LeaveStatus.approved.name) {
      return approvedStatusBtn();
    } else if (status == LeaveStatus.cancelled.name) {
      return cancelStatusBtn();
    } else {
      return Container();
    }
  }

  _infoLayoutById({required text, dynamicText, widget}) {
    return Padding(
      padding: marginLayout.copyWith(left: 20, right: 20, top: 12, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$text",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault + 1),
          ),
          widget ??
              Text(
                "$dynamicText",
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeDefault + 1),
              ),
        ],
      ),
    );
  }

  _rejectedBtnById(BuildContext context, GetLeaveDetailsById leaveRecords) {
    return Padding(
      padding: marginLayout,
      child: CustomAppButton(
        buttonText: Text(
          AppString.text_remove.tr,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.cardColor,
              fontSize: Dimensions.fontSizeDefault + 2),
        ),
        onPressed: () {
          showCustomAlertDialog(
              context: context,
              onConfirm: () {
                if (leaveRecords.id != null) {
                  Get.find<LeaveScreenController>()
                      .removeLeave(leaveId: leaveRecords.id ?? "");
                }
              },
              confirmButtonChild: Obx(() => Get.find<LeaveScreenController>()
                      .cancelLeaveLoader
                      .isTrue
                  ? const Center(
                      child: CupertinoActivityIndicator(
                      radius: 16,
                      color: Colors.blueAccent,
                    ))
                  : Text(
                      AppString.text_remove.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )),
              iconData: Icons.delete_outline_outlined,
              titleText: AppString.text_remove_leave.tr,
              descriptionText:
                  AppString.text_sure_you_want_to_deleted_this_leave.tr,
              extraInfoText: "",
              iconBackgroundColor: AppColor.errorColorLight,
              confirmButtonColor: AppColor.errorColorLight,
              confirmButtonText: AppString.text_remove.tr);
        },
        buttonColor: AppColor.errorColorLight,
        isButtonExpanded: true,
      ),
    );
  }

  _pendingLayoutById(BuildContext context, GetLeaveDetailsById leaveRecords) {
    return Padding(
      padding: marginLayout,
      child: CustomDoubleAppButton(
          cancelText: AppString.text_cancel.tr,
          cancelTextColor: AppColor.cardColor,
          cancelAction: () {
            showCustomAlertDialog(
              context: context,
              onConfirm: () {
                Get.find<LeaveScreenController>().cancelLeave(leaveId: leaveRecords.id ?? "");
              },
              confirmButtonChild: Obx(() => _cancelLeaveProgress()),
              extraInfoText: "",
              iconWidget: customSvgImage(imageUrl: Images.cancelLeave, height: 60, width: 60),
              titleText: AppString.cancelLeaveText.tr,
              descriptionText: AppString.cancelLeaveNotificationText.tr,
              iconBackgroundColor: AppColor.cardColor,
              confirmButtonColor: AppColor.hintColor,
              confirmButtonText: AppString.confirmText.tr,
            );
          },
          buttonText: AppString.text_edit.tr,
          onAction: () {
            _showEditLeaveDetailsById(leaveRecords);
          },
          cancelBtnColor: AppColor.hintColor,
          btnColor: AppColor.primaryColor),
    );
  }

  /// Shows a sheet to edit leave details.
  void _showEditLeaveDetailsById(GetLeaveDetailsById data) {
    _updateDateFromResponseById(data);
    showCustomBottomSheet(
      context: Get.context!,
      onClose: _clear,
      height: MediaQuery.of(Get.context!).size.height / 1.2,
      child: EditLeaveRecordDetails(
          isEmployee: isEmployee,
          getLeaveDetailsById: GetLeaveDetailsById(files: data.files ?? [])),
    );
  }

  void _clear() {
    if (isEmployee==false) {
      HrLeaveController controller=   Get.put(HrLeaveController());
     controller.selectedEmployeeInfo.value = AppString.textSearchEmployee.tr;
      controller.storageForUpload.filePath.value = "";
      controller.isFileUploadedSuccessfully(false);
    }
  }

  void _updateDateFromResponseById(GetLeaveDetailsById leaveRecords) {
 HrLeaveController controller=   Get.put(HrLeaveController());
 LeaveController leaveController=   Get.put(LeaveController());

    controller.getAvailableLeaveType();
    controller.selectedEmployeeImgKey.value = controller.leaveDetailsById
        ?.getLeaveDetailsById?.organizationUser?.profile?.image ??
        "";
    controller.selectedEmployeeInfo.value =
    "${leaveRecords.organizationUser?.profile?.firstName ?? "No added yet"} "
        "${leaveRecords.organizationUser?.profile?.lastName ?? ""}";
    controller.leaveTypeId =
        leaveRecords.leaveType?.id ?? "";
    controller.leaveId = leaveRecords
        .leaveDetails?.first.leaveId ??
        "";
    controller.calculateAllowanceOfLeave.value = leaveRecords.leaveType?.calculateAllowanceBy
        .toString() ??
        "";
    controller.storageForUpload.filePath.value = "";
    controller.isFileUploadedSuccessfully(false);

    if (leaveRecords.files?.isNotEmpty??false) {
      controller.fileName =
          leaveRecords.files?.first.name ??
              "";
      controller.fileKey =
          leaveRecords.files?.first.key ??
              "";
      controller.fileId =
          leaveRecords.files?.first.id ??
              "";
      controller.fileSize = leaveRecords.files?.first.size
          .toString() ??
          "";
    }

 leaveController.selectedStatusIndex.value =
    leaveRecords.status == "pending"
        ? 0
        : 1;

    Get.find<DateTimePickerController>().inTime.value = DateFormat('HH:mm')
        .format(DateTime.parse(
        leaveRecords.startDate ??
            DateTime.now().toString()));
    Get.find<DateTimePickerController>().inDate.value = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(
        leaveRecords.startDate ??
            DateTime.now().toString()));

    Get.find<DateTimePickerController>().outTime.value = DateFormat('HH:mm')
        .format(DateTime.parse(
        leaveRecords.endDate ??
            DateTime.now().toString()));
    Get.find<DateTimePickerController>().outDate.value =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(
            leaveRecords.endDate ??
                DateTime.now().toString()));

    leaveNoteController.text =
        leaveRecords.description ?? "";

    Get.find<DateTimePickerController>().getInDateTime();
    Get.find<DateTimePickerController>().getOutDateTime();
  }

  _approvedLayout(BuildContext context, GetLeaveDetailsById leaveRecords) {
    return Padding(
      padding: marginLayout,
      child: CustomAppButton(
        buttonColor: AppColor.hintColor,
        onPressed: () {
          showCustomAlertDialog(
            context: context,
            onConfirm: () {
              Get.find<LeaveScreenController>()
                  .cancelLeave(leaveId: leaveRecords.id ?? "");
            },
            confirmButtonChild: Obx(() => _cancelLeaveProgress()),
            extraInfoText: "",
            iconWidget: customSvgImage(
                imageUrl: Images.cancelLeave, height: 60, width: 60),
            titleText: AppString.cancelLeaveText.tr,
            descriptionText: AppString.cancelLeaveNotificationText.tr,
            iconBackgroundColor: AppColor.cardColor,
            confirmButtonColor: AppColor.hintColor,
            confirmButtonText: AppString.confirmText.tr,
          );
        },
        buttonText: Text(
          AppString.text_cancel.tr,
          style: AppStyle.small_text_black.copyWith(
              color: AppColor.cardColor, fontSize: Dimensions.fontSizeMid - 3),
        ),
        borderRadius: 60,
        isButtonExpanded: true,
      ),
    );
  }

  _cancelLeaveProgress() {
    return Get.find<LeaveScreenController>().cancelLeaveLoader.value
        ? const CupertinoActivityIndicator(
            color: AppColor.cardColor,
          )
        : Text(
            AppString.confirmText.tr,
            style: AppStyle.normal_text_grey.copyWith(
                fontSize: Dimensions.fontSizeDefault + 1,
                color: AppColor.cardColor),
          );
  }

  _getDate(GetLeaveDetailsById leaveRecords) {

    isSameDate(
        startDate: leaveRecords.startDate ?? "",
        endDate: leaveRecords.endDate ?? "");
    DateTime dateTime = DateTime.parse(leaveRecords.startDate ?? "");

    if (isSameDate(
        startDate: leaveRecords.startDate ?? "",
        endDate: leaveRecords.endDate ?? "")) {
      return "${dateMonthFormatFromDatetimeForLeaveDetails(leaveRecords.startDate ?? "")} - ${DateFormat('yyyy').format(dateTime)}";
    } else {
      return "${dateMonthFormatFromDatetimeForLeaveDetails(leaveRecords.startDate ?? "")} - ${dateMonthFormatFromDatetimeForLeaveDetails(leaveRecords?.endDate ?? "")}";
    }
  }
}
