import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_record_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_records.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/domain/files_model.dart';
import '../../../../common/widget/custom_dotted_border.dart';
import '../../../../enum.dart';
import '../../../../utils/utils.dart';
import '../../../timeline/view/widget/timeline_calendar.dart';
import '../../model/leave_record_response.dart';
import '../widget/leave_record_details_view.dart';
import '../widget/status_btn_widget.dart';

class LeaveRecordScreen extends GetView<LeaveRecordsController> {
  const LeaveRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<LeaveRecordsController>()) {
      Get.delete<LeaveRecordsController>();
    }
    Get.put(LeaveRecordsController());
    return controller.obx(
        (state) => Scaffold(
            appBar: customAppbar(title: AppString.text_leave_records),
            body: RefreshIndicator(
              backgroundColor: AppColor.cardColor,
              color: AppColor.primaryColor,
              onRefresh: _refreshScreen,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.leaveRecordList?.length ?? 0,
                  itemBuilder: (context, index) => Column(children: [
                    _dateTextLayout(
                        date: controller.leaveRecordList?[index].date),
                    _leaveRecordViewLayout(index)
                  ]),
                ),
              ),
            )),
        onLoading: const LoadingIndicator());
  }

  _leaveRecordViewLayout(int monthIndex) {
    return ListView.builder(
      shrinkWrap: true,
      padding: marginLayout,
      itemCount: controller.leaveRecordList?[monthIndex].data?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _infoLayoutView(
          context: context,
          leaveRecord: GetLeaveRecords(
              startDate: controller
                  .leaveRecordList?[monthIndex].data?[index].startDate,
              endDate:
                  controller.leaveRecordList?[monthIndex].data?[index].endDate,
              status:
                  controller.leaveRecordList?[monthIndex].data?[index].status,
              duration: controller
                  .leaveRecordList?[monthIndex].data?[index].numberOfDays,
              createdAt: controller
                  .leaveRecordList?[monthIndex].data?[index].createdAt,
              files: [
                (controller.leaveRecordList?[monthIndex].data?[index].files !=
                            null &&
                        controller.leaveRecordList![monthIndex].data![index]
                            .files!.isNotEmpty)
                    ? Files(
                        createdAt: controller.leaveRecordList?[monthIndex]
                                .data?[index].files?[0].createdAt ??
                            "",
                        size: controller.leaveRecordList?[monthIndex]
                                .data?[index].files?[0].size ??
                            "",
                        name: controller.leaveRecordList?[monthIndex]
                                .data?[index].files?[0].name ??
                            "",
                        id: controller.leaveRecordList?[monthIndex].data?[index]
                                .files?[0].id ??
                            "",
                        key: controller.leaveRecordList?[monthIndex]
                                .data?[index].files?[0].key ??
                            "",
                      )
                    : Files()
              ],
              leaveType: LeaveType(
                isAttachDocumentRequired: controller
                    .leaveRecordList?[monthIndex]
                    .data![index]
                    .leaveType
                    ?.isAttachDocumentRequired,
                isAddNoteRequired: controller.leaveRecordList?[monthIndex]
                    .data![index].leaveType?.isAddNoteRequired,
                leaveName: controller.leaveRecordList?[monthIndex].data![index]
                    .leaveType?.leaveName,
                leaveId: controller.leaveRecordList?[monthIndex].data![index]
                    .leaveType?.leaveId,
                type: controller
                    .leaveRecordList?[monthIndex].data![index].leaveType?.type,
              ),
              id: controller.leaveRecordList?[monthIndex].data![index].id,
              description: controller
                  .leaveRecordList?[monthIndex].data![index].description),
        );
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
          horizontalDashLayout(),
          Padding(
            padding: marginLayout,
            child: Text(
              date,
              style: AppStyle.normal_text_black.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault),
            ),
          ),
          horizontalDashLayout(),
        ],
      ),
    );
  }

  _infoLayoutView(
      {required BuildContext context, required GetLeaveRecords leaveRecord}) {
    return GestureDetector(
      onTap: () => customAntButtonSheet(
          context: context,
          child: LeaveRecordDetails(
            status: leaveRecord.status ?? "",
            leaveRecords: leaveRecord,
          ),),
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

  Future<void> _refreshScreen() async {
    controller.getLeaveRecordsData();
  }
}
