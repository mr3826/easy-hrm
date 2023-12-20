import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/model/leave_records.dart';
import 'package:payrun_mobile/modules/leave/view/screen/apply_leave.dart';
import 'package:payrun_mobile/modules/leave/view/widget/status_btn_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../utils/utils.dart';

class LeaveRecordDetails extends StatelessWidget {
  dynamic status;
  final GetLeaveRecords? leaveRecords;
  dynamic leaveDate;
  dynamic leaveWeekday;

  LeaveRecordDetails({super.key, this.status, this.leaveRecords});

  @override
  Widget build(BuildContext context) {
    _checkLeaveDateDuration(leaveRecords ?? GetLeaveRecords());
    return Column(
      children: [
        customButtonSheetAppbar(text: leaveDate, subtext: leaveWeekday),
        customSpacerHeight(height: 12),
        _infoLayout(
            text: AppString.text_type_dot.tr,
            dynamicText: leaveRecords?.leaveType?.type ?? ""),
        _infoLayout(
            text: AppString.text_duration.tr,
            dynamicText: leaveRecords?.duration != null
                ? leaveRecords?.duration > 1
                    ? "${leaveRecords?.duration.toString()} days"
                    : "${leaveRecords?.duration.toString()} day"
                : ""),
        _infoLayout(text: AppString.text_satus.tr, widget: _statusBtn()),
        _infoLayout(
            text: AppString.text_date_of_application.tr,
            dynamicText:
                dateMonthYearFormatFromDatetime(leaveRecords?.createdAt ?? "")),
        customSpacerHeight(height: 50),
        _buttonLayout(context)
      ],
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
      return _rejectedBtn(context);
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
    } else {
      return approvedStatusBtn();
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
          customDialog(
              context: context,
              saveBtnAction: () => Get.back(),
              icon: Icons.delete_outline_outlined,
              titleText: AppString.text_remove_time_log.tr,
              subText: AppString.text_sure_you_want_to_deleted_this_log.tr,
              drcText: AppString.text_if_you_deleted_this_time_log_etc.tr,
              iconBgColor: AppColor.errorColorLight,
              btnBgColor: AppColor.errorColorLight,
              btnText: AppString.text_remove.tr);
        },
        buttonColor: AppColor.errorColor.withOpacity(0.6),
        isButtonExpanded: false,
      ),
    );
  }

  _pendingLayout(context) {
    return Padding(
      padding: marginLayout,
      child: CustomDoubleAppButton(
          cancelAction: () {
            Navigator.pop(context);
          },
          buttonText: AppString.text_edit.tr,
          onAction: () => customButtonSheet(
              context: context, child: const ApplyLeaveScreen()),
          btnColor: AppColor.primaryColor),
    );
  }

  _approvedLayout(context) {
    return Padding(
      padding: marginLayout,
      child: CustomAppButton(
        buttonText: Text(
          AppString.text_back.tr,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.cardColor,
              fontSize: Dimensions.fontSizeDefault + 2),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        buttonColor: AppColor.hintColor,
        isButtonExpanded: false,
      ),
    );
  }
}
