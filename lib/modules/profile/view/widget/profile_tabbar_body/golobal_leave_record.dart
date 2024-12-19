import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/leave/domain/leave_record_response.dart';
import 'package:payrun_mobile/modules/leave/domain/leave_records.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../common/domain/files_model.dart';
import '../../../../../common/widget/custom_dotted_border.dart';
import '../../../../../common/widget/custom_drawer.dart';
import '../../../../../enum.dart';
import '../../../../../utils/utils.dart';
import '../../../../auth/presentation/view/otp_screen.dart';
import '../../../../leave/presentation/view/widget/leave_record_details_view.dart';
import '../../../../leave/presentation/view/widget/status_btn_widget.dart';

class BuildLeaveRecord extends GetView<UserProfileController> {
  const BuildLeaveRecord({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isViewLeaveRecordLoading.isTrue) {
        return const LoadingIndicator(
          radius: 18,
        );
      }
      return RefreshIndicator(
        backgroundColor: AppColor.cardColor,
        color: AppColor.primaryColor,
        onRefresh: _refreshScreen,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          physics: const AlwaysScrollableScrollPhysics(),
          child: controller.leaveRecordList != null &&
                  controller.leaveRecordList!.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.leaveRecordList?.length ?? 0,
                  itemBuilder: (context, index) => Column(children: [
                    _dateTextLayout(
                        date: controller.leaveRecordList?[index].date),
                    _leaveRecordViewLayout(index)
                  ]),
                )
              : Text(
                  "No leave record!",
                  style: AppStyle.normal_text_black
                      .copyWith(color: AppColor.hintColor),
                ),
        ),
      );
    });
  }

  _leaveRecordViewLayout(int monthIndex) {
    return ListView.builder(
      shrinkWrap: true,
      padding: marginLayout,
      itemCount: controller.leaveRecordList?[monthIndex].data?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Color itemColor =
            index % 2 == 0 ? AppColor.leaveRecordCardColor : Colors.transparent;
        return _infoLayoutView(
          context: context,
          cardBgColor: itemColor,
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
              leaveDetails: [
                (controller.leaveRecordList?[monthIndex].data?[index]
                                .leaveDetails !=
                            null &&
                        controller.leaveRecordList![monthIndex].data![index]
                            .leaveDetails!.isNotEmpty)
                    ? LeaveDetails(
                        scheduleHour: controller.leaveRecordList?[monthIndex]
                                .data?[index].leaveDetails?[0].scheduleSecond
                                .toString() ??
                            "",
                        leaveHour: controller.leaveRecordList?[monthIndex]
                                .data?[index].leaveDetails?[0].leaveSecond
                                .toString() ??
                            "",
                      )
                    : LeaveDetails()
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
                  fontSize: Dimensions.fontSizeDefault - 1),
            ),
          ),
          horizontalDashLayout(),
        ],
      ),
    );
  }

  _infoLayoutView({
    required BuildContext context,
    required GetLeaveRecords leaveRecord,
    Color? cardBgColor,
  }) {
    return GestureDetector(
      onTap: () => _customAntButtonSheet(
        context,
        LeaveRecordDetails(
          status: leaveRecord.status ?? "",
          leaveRecords: leaveRecord,
        ),
      ),
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder.copyWith(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        color: cardBgColor,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leaveRecord.leaveType?.type ?? "",
                      style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.normalTextColor,
                        fontSize: Dimensions.fontSizeDefault + 1,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    customSpacerHeight(height: 6),
                    Row(
                      children: [
                        Expanded(child: _showDateDurationText(leaveRecord)),
                        customSpacerWidth(width: 8),
                      ],
                    ),
                    customSpacerHeight(height: 5),
                  ],
                ),
              ),
              _showStatusButton(leaveRecord.status ?? ""),
            ],
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
    return Row(
      children: [
        Flexible(
          child: Text(
            "$leaveDate ",
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.secondaryColor.withOpacity(0.7),
              fontSize: Dimensions.fontSizeDefault - 2,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        if (leaveRecord.startDate!.isNotEmpty)
          const Text(
            " | ",
            style: TextStyle(color: AppColor.hintColor),
          ),
        Flexible(
          child: Text(
            getLeaveDuration(
              leaveRecord.leaveDetails?[0].leaveHour ?? "",
              leaveRecord.duration.toString() ?? "",
            ),
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor.withOpacity(0.7),
              fontSize: Dimensions.fontSizeDefault - 2,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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

_customAntButtonSheet(BuildContext context, Widget child) {
  return showCustomAtmBtnSheet(
      height: _modelHeightAccordingScreenSize(),
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

double _modelHeightAccordingScreenSize() {
  double value = MediaQuery.of(Get.context!).size.width;
  if (value <= 360.0) {
    return 480;
  } else {
    return 500;
  }
}
