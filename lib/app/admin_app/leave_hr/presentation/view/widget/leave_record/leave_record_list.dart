import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../common/widget/employee/status_button_helper.dart';
import '../../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../utils/utils.dart';
import '../../../controller/hr_leave_controller.dart';
import 'leave_record_details/leave_record_details.dart';
import 'leave_record_details/more_leave_record_details.dart';

class LeaveRecordList extends GetView<HrLeaveController> {
  const LeaveRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoadingLeaveRecord.isTrue
        ? const Center(
            child: CupertinoActivityIndicator(
            color: AppColor.primaryColor,
            radius: 15,
          ))
        : controller.leaveRecorde?.getLeaveRequests?.isEmpty ?? true
            ? Center(
                child: Text(
                "No leave record!",
                style: AppStyle.normal_text_black
                    .copyWith(color: AppColor.hintColor),
              ))
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RefreshIndicator(
                    onRefresh: _refreshScreen,
                    child: ListView.builder(
                      itemCount:
                          controller.leaveRecorde?.getLeaveRequests?.length ??
                              0,
                      itemBuilder: (context, index) {
                        var data =
                            controller.leaveRecorde?.getLeaveRequests?[index];

                        if (data == null) {
                          return const SizedBox.shrink();
                        }

                        return SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 0,
                            shape: roundedRectangleBorder,
                            color: AppColor.leaveRecordCardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLeaveCard(
                                    LeaveRecordDetailsModel(
                                      employeeName:
                                          "${data.organizationUser?.profile?.firstName ?? "No added yet"} ${data.organizationUser?.profile?.lastName ?? ""}",
                                      applicationStatus:
                                          data.status ?? "Unknown",
                                      designation:
                                          data.organizationUser?.designation ??
                                              "No designation",
                                      typeOfLeave:
                                          data.leaveType?.name ?? "N/A",
                                      leaveStatus:
                                          data.leaveType?.type ?? "N/A",
                                      imgUrl: data.organizationUser?.profile
                                              ?.image ??
                                          "",
                                      leaveDate: _formatLeaveDate(
                                          data.startDate, data.endDate),
                                      leaveDuration: getLeaveDuration(
                                        data.leaveDetails?.first.leaveSeconds
                                                ?.toString() ??
                                            "0",
                                        data.leaveType?.numberOfDays ?? "0",
                                      ),
                                      applicationDate:
                                          data.leaveType?.applicationDate ??
                                              "N/A",
                                    ),
                                    data.leaveDetails?.first.leaveId ?? "",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ));
  }

  Widget _buildLeaveCard(
      LeaveRecordDetailsModel leaveRecordDetailsModel, String leaveId) {
    return InkWell(
      onTap: () => _showLeaveRecodeDetails(leaveId),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            imgUrlKey: leaveRecordDetailsModel.imgUrl ?? "",
            errorText: getInitials(leaveRecordDetailsModel.employeeName ?? ""),
            height: 20,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leaveRecordDetailsModel.employeeName ?? "No name",
                  maxLines: 2,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.secondaryColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.fontSizeMid - 2,
                  ),
                ),
                Text(
                  leaveRecordDetailsModel.designation ?? "No designation",
                  maxLines: 2,
                  style: AppStyle.normal_text_black.copyWith(
                    color: AppColor.hintColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.fontSizeDefault - 2,
                  ),
                ),
                const SizedBox(height: 14),
                _buildLeaveDetails(
                  leaveRecordDetailsModel.typeOfLeave ?? "N/A",
                  leaveRecordDetailsModel.leaveStatus ?? "N/A",
                  leaveRecordDetailsModel.leaveDate ?? "N/A",
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    showStatusButton(
                      leaveRecordDetailsModel.applicationStatus ?? "Unknown",
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _showLeaveRecordDetailsSheet(leaveId),
            child: const Icon(
              Icons.more_horiz,
              color: AppColor.hintColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveDetails(String leaveName, String leaveType, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$leaveName: $leaveType",
          maxLines: 2,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            overflow: TextOverflow.ellipsis,
            fontSize: Dimensions.fontSizeMid - 3,
          ),
        ),
        Text(
          date,
          maxLines: 2,
          style: AppStyle.normal_text_black.copyWith(
            color: AppColor.hintColor,
            overflow: TextOverflow.ellipsis,
            fontSize: Dimensions.fontSizeDefault - 2,
          ),
        ),
      ],
    );
  }

  void _showLeaveRecodeDetails(String leaveId) {
    final controller = Get.find<HrLeaveController>();
    controller.getLeaveDetailsById(leaveId: leaveId);
    customAntButtonSheet(
      context: Get.context!,
      child: LeaveRecordDetails(leaveId: leaveId),
    );
  }

  void _showLeaveRecordDetailsSheet(String leaveId) {
    final controller = Get.find<HrLeaveController>();
    controller.getLeaveDetailsById(leaveId: leaveId);
    customAntButtonSheet(
      context: Get.context!,
      height: MediaQuery.of(Get.context!).size.height / 1.5,
      child: MoreLeaveRecordDetails(leaveId: leaveId),
    );
  }

  String _formatLeaveDate(String? startDate, String? endDate) {
    if (startDate == null || endDate == null) return "N/A - N/A";
    try {
      return "${DateFormat("dd MMM yy").format(DateTime.parse(startDate))} - ${DateFormat("dd MMM yy").format(DateTime.parse(endDate))}";
    } catch (e) {
      return "Invalid date";
    }
  }
}

Widget showStatusButton(String leaveStatus) {
  switch (leaveStatus.toLowerCase()) {
    case 'approved':
      return StatusBtnHelper.approvedStatusBtn();
    case 'rejected':
      return StatusBtnHelper.rejectedStatusBtn();
    case 'pending':
      return StatusBtnHelper.pendingStatusBtn();
    case 'taken':
      return StatusBtnHelper.tokenStatusBtn();
    case 'cancel':
      return StatusBtnHelper.cancelStatusBtn();
    case 'cancelled':
      return StatusBtnHelper.cancelledStatusBtn();
    default:
      return Container();
  }
}


Future<void> _refreshScreen() async {
  final leaveController = Get.find<HrLeaveController>();
  final now = DateTime.now();

  final startDate = leaveController.selectedRangeStartDate.isEmpty
      ? DateTime(now.year, now.month, 1).toIso8601String()
      : leaveController.selectedRangeStartDate;

  final endDate = leaveController.selectedRangeEndDate.isEmpty
      ? DateTime(now.year, now.month + 1, 0).toIso8601String()
      : leaveController.selectedRangeEndDate;

  leaveController.getLeaveRecord(startDate: startDate, endDate: endDate);
}
