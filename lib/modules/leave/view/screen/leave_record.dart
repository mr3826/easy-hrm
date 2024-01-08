import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_record_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_records.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

import '../../../../enum.dart';
import '../../../../utils/utils.dart';
import '../widget/leave_record_details_view.dart';
import '../widget/status_btn_widget.dart';

class LeaveRecordScreen extends GetView<LeaveRecordsController> {
  const LeaveRecordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Scaffold(
            appBar: customAppbar(title: AppString.text_leave_records),
            body: ListView.builder(
              itemCount: controller.monthsList?.length ?? 0,
              itemBuilder: (context, index) => Column(children: [
                _dateTextLayout(date: controller.monthsList?[index].monthName),
                _leaveRecordViewLayout(index)
              ]),
            )),
        onLoading: const LoadingIndicator());
  }

  _leaveRecordViewLayout(int monthIndex) {
    return ListView.builder(
      shrinkWrap: true,
      padding: marginLayout,
      itemCount: controller.monthsList?[monthIndex].leaveRecords.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _infoLayoutView(
            context: context,
            leaveRecord:
                controller.monthsList?[monthIndex].leaveRecords[index] ??
                    GetLeaveRecords());
      },
    );
  }

  _dateTextLayout({required date}) {
    return Padding(
      padding: marginLayout,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customSpacerHeight(height: 50),
          Expanded(
            child: Container(
              height: 1,
              color: AppColor.disableColor,
            ),
          ),
          Padding(
            padding: marginLayout,
            child: Text(
              date,
              style: AppStyle.normal_text_black.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: AppColor.disableColor,
            ),
          ),
        ],
      ),
    );
  }

  _infoLayoutView(
      {required BuildContext context, required GetLeaveRecords leaveRecord}) {
    return GestureDetector(
      onTap: () => customButtonSheet(
          context: context,
          child: LeaveRecordDetails(
            status: leaveRecord.status ?? "",
            leaveRecords: leaveRecord,
          ),
          height: 0.5),
      child: SizedBox(
        child: Card(
          elevation: 0,
          shape: roundedRectangleBorder.copyWith(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
          color: AppColor.primaryColor.withOpacity(0.05),
          child: Padding(
            padding:
                marginLayout.copyWith(top: 20, bottom: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leaveRecord.leaveType?.type ?? "",
                      style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeDefault + 1,
                          fontWeight: FontWeight.w600),
                    ),
                    customSpacerHeight(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _showDateDurationText(leaveRecord),
                        customSpacerWidth(width: 8),
                      ],
                    ),
                  ],
                ),
                _showStatusButton(leaveRecord.status ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }


  //todo
  _showDateDurationText(GetLeaveRecords leaveRecord) {
    String? leaveDate;
    String starDate =
        leaveRecord.startDate?.substring(0, 10) ?? "2023-01-01T08:23:49.550Z";
    String endDate =
        leaveRecord.endDate?.substring(0, 10) ?? "2023-01-01T08:23:49.550Z";
    if (starDate == endDate) {
      leaveDate = dateMonthFormatFromDatetime(
          leaveRecord.startDate ?? "2023-01-01T08:23:49.550Z");
    } else {
      leaveDate =
          "${dateMonthFormatFromDatetime(leaveRecord.startDate ?? "2023-01-01T08:23:49.550Z")} - ${dateMonthFormatFromDatetime(leaveRecord.endDate ?? "2023-01-01T08:23:49.550Z")}";
    }
    return Text(
      "$leaveDate | ${leaveRecord.duration}",
      style: AppStyle.mid_large_text.copyWith(
          color: AppColor.secondaryColor.withOpacity(0.7),
          fontSize: Dimensions.fontSizeDefault - 2,
          fontWeight: FontWeight.w600),
    );
  }

  _showStatusButton(String leaveStatus) {
    if (leaveStatus.toLowerCase() == LeaveStatus.approved.name) {
      return approvedStatusBtn();
    } else if (leaveStatus.toLowerCase() == LeaveStatus.rejected.name) {
      return rejectedStatusBtn();
    } else if (leaveStatus.toLowerCase() == LeaveStatus.pending.name) {
      return pendingStatusBtn();
    } else if (leaveStatus.toLowerCase() == LeaveStatus.taken.name) {
      return tokenStatusBtn();
    } else if (leaveStatus.toLowerCase() == LeaveStatus.cancelled.name) {
      return canceledStatusBtn();
    } else {
      return Container();
    }
  }
}
