import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/utils/app_status_helper.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/leave/domain/leave_record_response.dart';
import 'package:payrun_mobile/modules/leave/domain/leave_records.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../../../global/view/widget/app_margin.dart';
import '../../../../../../../common/domain/files_model.dart';
import '../../../../../../../common/widget/custom_dotted_border.dart';
import '../../../../../../../common/widget/custom_drawer.dart';
import '../../../../../../../common/widget/status_button_helper.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../../modules/leave/presentation/view/widget/leave_record_details_view.dart';
import '../../../../../leave_hr/presentation/model/leave_details_by_id.dart'as lv_del_by_id;
import '../../../../controller/hr_profile_controller.dart';

class BuildLeaveRecord extends StatelessWidget {
  final Future<List<GetLeaveRecordsForApp>> Function() getLeaveRecordList;

  const BuildLeaveRecord({required this.getLeaveRecordList, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLeaveRecordList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator(
            radius: 18,
          );
        }
        if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return Center(
              child: Text(
            "No leave record!",
            style:
                AppStyle.normal_text_black.copyWith(color: AppColor.hintColor),
          ));
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) => Column(children: [
            _dateTextLayout(date: snapshot.data?[index].date),
            _leaveRecordViewLayout(snapshot.data?[index].data)
          ]),
        );
      },
    );
  }

  _leaveRecordViewLayout(List<Data>? data) {
    return ListView.builder(
      shrinkWrap: true,
      padding: marginLayout,
      itemCount: data?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Color itemColor =
            index % 2 == 0 ? AppColor.leaveRecordCardColor : Colors.transparent;

        return _infoLayoutView(
          context: context,
          bgColor: itemColor,
          leaveRecord: GetLeaveRecords(
              startDate: data?[index].startDate,
              endDate: data?[index].endDate,
              status: data?[index].status,
              duration: data?[index].numberOfDays,
              createdAt: data?[index].createdAt,
              files: [
                (data?[index].files != null && data![index].files!.isNotEmpty)
                    ? Files(
                        createdAt: data[index].files?[0].createdAt ?? "",
                        size: data[index].files?[0].size ?? "",
                        name: data[index].files?[0].name ?? "",
                        id: data[index].files?[0].id ?? "",
                        key: data[index].files?[0].key ?? "",
                      )
                    : Files()
              ],
              leaveDetails: [
                (data?[index].leaveDetails != null &&
                        data![index].leaveDetails!.isNotEmpty)
                    ? LeaveDetails(
                        scheduleHour: data[index]
                                .leaveDetails?[0]
                                .scheduleSecond
                                .toString() ??
                            "",
                        leaveHour: data[index]
                                .leaveDetails?[0]
                                .leaveSecond
                                .toString() ??
                            "",
                      )
                    : LeaveDetails()
              ],
              leaveType: LeaveType(
                isAttachDocumentRequired:
                    data![index].leaveType?.isAttachDocumentRequired,
                isAddNoteRequired: data[index].leaveType?.isAddNoteRequired,
                leaveName: data[index].leaveType?.leaveName,
                leaveId: data[index].leaveType?.leaveId,
                type: data[index].leaveType?.type,
              ),
              id: data[index].id,
              description: data[index].description),
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
    Color? bgColor,
  }) {
    return GestureDetector(
      onTap: (){
        Get.find<HrProfileController>().getLeaveDetailsById(
            leaveId: leaveRecord.id??"");

        customAntButtonSheet(
          context: context,
          child: Obx(() => Get.find<HrProfileController>()
              .isLeaveDetailsByLoading
              .isTrue
              ? const LoadingIndicator()
              : LeaveRecordDetailsById(
            isEmployee: false,
            data: Get.find<HrProfileController>()
                .leaveDetailsById
                ?.getLeaveDetailsById ??
                lv_del_by_id.GetLeaveDetailsById(),
          )),
        );
      },
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder.copyWith(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
        color: bgColor,
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
              leaveRecord.duration.toString(),
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

  Widget _showStatusButton(String leaveStatus) {
    switch (leaveStatus.toLowerCase()) {
      case 'approved':
        return StatusBtnHelper.approvedStatusBtn();
      case 'rejected':
        return StatusBtnHelper.rejectedStatusBtn();
      case 'pending':
        return StatusBtnHelper.pendingStatusBtn();
      case 'taken':
        return StatusBtnHelper.tokenStatusBtn();
      case 'cancelled':
        return StatusBtnHelper.cancelStatusBtn();
      default:
        return Container();
    }
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
