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
import 'package:payrun_mobile/modules/leave/presentation/controller/update_leave_controller.dart';
import 'package:payrun_mobile/modules/leave/domain/leave_records.dart';
import 'package:payrun_mobile/app/global/view/widgets/status_btn_widget.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/screen/update_leave_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../app/global/view/widget/app_margin.dart';
import '../../../../../common/widget/custom_drawer.dart';
import '../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../utils/utils.dart';

class LeaveRecordDetails extends StatelessWidget {
  dynamic status;

  final GetLeaveRecords? leaveRecords;
  dynamic leaveDate;
  dynamic leaveWeekday;

  LeaveRecordDetails({super.key, this.status, this.leaveRecords, required String leaveId});

  @override
  Widget build(BuildContext context) {
    _checkLeaveDateDuration(leaveRecords ?? GetLeaveRecords());
    print("leave :::: ${leaveRecords?.duration.toString()}");

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          customButtonSheetAppbar(
              text: "",
              subtext: _getDate(),
              isLeave: true,
              status: status,
              duration: getLeaveDuration(
                  leaveRecords!.leaveDetails![0].leaveHour.toString(),
                  leaveRecords?.duration.toString() ?? "")),
          customSpacerHeight(height: 12),
          _infoLayout(
              text: AppString.text_type_dot.tr,
              dynamicText: leaveRecords?.leaveType?.type ?? ""),
          _infoLayout(
              text: "${AppString.text_duration.tr}:",
              dynamicText: getLeaveDuration(
                  leaveRecords!.leaveDetails![0].leaveHour.toString(),
                  leaveRecords?.duration.toString() ?? "")),
          _infoLayout(text: AppString.text_satus.tr, widget: _statusBtn()),
          _infoLayout(
              text: AppString.text_date_of_application.tr,
              dynamicText: dateMonthYearFormatFromDatetime(
                  leaveRecords?.createdAt ?? "")),
          customSpacerHeight(height: 50),
          _buttonLayout(context)
        ],
      ),
    );
  }

  void _checkLeaveDateDuration(GetLeaveRecords leaveRecord) {
    final starDate =
        leaveRecord.startDate?.substring(0, 10) ?? "2023-01-01T08:23:49.550Z";
    final endDate =
        leaveRecord.endDate?.substring(0, 10) ?? "2023-01-01T08:23:49.550Z";
    if (starDate == endDate) {
      leaveDate = dateMonthYearFormatFromDatetime(leaveRecord.startDate ?? "");
      leaveWeekday = findWeekdayFormDateString(leaveRecord.startDate ?? "");
    } else {
      leaveDate =
          "${dateMonthYearFormatFromDatetime(leaveRecord.startDate ?? "")} - ${dateMonthYearFormatFromDatetime(leaveRecord.endDate ?? "")}";
      leaveWeekday =
          "${leaveWeekday = findWeekdayFormDateString(leaveRecord.startDate ?? "")} - ${leaveWeekday = findWeekdayFormDateString(leaveRecord.endDate ?? "")}";
    }
  }

  _buttonLayout(context) {
    if (status == "rejected") {
      return _rejectedBtn(context);
    } else if (status == "pending") {
      return _pendingLayout(context);
    } else if (status == "token") {
      return Container();
    } else if (status == LeaveStatus.approved.name) {
      return _approvedLayout(context);
    } else if (status == LeaveStatus.cancelled.name) {
      return Container();
    } else {
      return Container();
    }
  }

  _statusBtn() {
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

  _infoLayout({required text, dynamicText, widget}) {
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

  _rejectedBtn(context) {
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
                if (leaveRecords?.id != null) {
                  Get.find<LeaveScreenController>()
                      .removeLeave(leaveId: leaveRecords!.id!);
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
        isButtonExpanded: false,
      ),
    );
  }

  _pendingLayout(context) {
    return Padding(
      padding: marginLayout,
      child: CustomDoubleAppButton(
          cancelText: AppString.text_cancel.tr,
          cancelTextColor: AppColor.cardColor,
          cancelAction: () {
            showCustomAlertDialog(
              context: context,
              onConfirm: () {
                Get.find<LeaveScreenController>()
                    .cancelLeave(leaveId: leaveRecords?.id ?? "");
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
          buttonText: AppString.text_edit.tr,
          onAction: () {
            if (Get.isRegistered<DateTimePickerController>()) {
              Get.delete<DateTimePickerController>();
            }
            Get.put(DateTimePickerController());
            if (Get.isRegistered<UpDateLeaveController>()) {
              Get.delete<UpDateLeaveController>();
            }
            Get.put(UpDateLeaveController());

            Get.find<UpDateLeaveController>().getLeaveTypeDropdown();

            _customButtonSheet(
                context: context,
                child: UpdateLeave(leaveRecords: leaveRecords));
          },
          cancelBtnColor: AppColor.hintColor,
          btnColor: AppColor.primaryColor),
    );
  }

  void _customButtonSheet({context, child}) {
    return showCustomAtmBtnSheet(
        height: Get.height * .8,
        context: context,
        child: Material(
          color: AppColor.noColor,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radiusMid),
                  topLeft: Radius.circular(Dimensions.radiusMid)),
              color: AppColor.cardColor,
            ),
            child: child,
          ),
        ));
  }

  _approvedLayout(context) {
    return Padding(
      padding: marginLayout,
      child: CustomAppButton(
        buttonColor: AppColor.hintColor,
        onPressed: () {
          showCustomAlertDialog(
            context: context,
            onConfirm: () {
              Get.find<LeaveScreenController>()
                  .cancelLeave(leaveId: leaveRecords?.id ?? "");
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
        isButtonExpanded: false,
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

  _getDate() {
    isSameDate(
        startDate: leaveRecords?.startDate ?? "",
        endDate: leaveRecords?.endDate ?? "");
    DateTime dateTime = DateTime.parse(leaveRecords?.startDate ?? "");

    if (isSameDate(
        startDate: leaveRecords?.startDate ?? "",
        endDate: leaveRecords?.endDate ?? "")) {
      return "${dateMonthFormatFromDatetimeForLeaveDetails(leaveRecords?.startDate ?? "")} - ${DateFormat('yyyy').format(dateTime)}";
    } else {
      return "${dateMonthFormatFromDatetimeForLeaveDetails(leaveRecords?.startDate ?? "")} - ${dateMonthFormatFromDatetimeForLeaveDetails(leaveRecords?.endDate ?? "")}";
    }
  }
}
