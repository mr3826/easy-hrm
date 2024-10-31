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
import 'leave_recorde_details /leave_record_details.dart';
import 'leave_recorde_details /more_leave_record_details.dart';

class LeaveRecordList extends StatelessWidget {
  const LeaveRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = [
      {
        "type": "Paid",
        "status": "approved",
        "name": "Medicine Buchenwald",
        "leaveName": "Sick Leave",
        "designation": "Software Engineer"
      },
      {
        "type": "Unpaid",
        "status": "pending",
        "name": "Peter Doppler",
        "leaveName": "Annual Leave",
        "designation": "Project Manager"
      },
      {
        "type": "Medical",
        "status": "rejected",
        "name": "Elisabeth Doppler",
        "leaveName": "Medical Leave",
        "designation": "Designer"
      },
      {
        "type": "Casual",
        "status": "taken",
        "name": "Charlotte Doppler",
        "leaveName": "Casual Leave",
        "designation": "HR Manager"
      },
      {
        "type": "Paid",
        "status": "rejected",
        "name": "Hannah Kahnwald",
        "leaveName": "Sick Leave",
        "designation": "Developer"
      },
      {
        "type": "Unpaid",
        "status": "pending",
        "name": "Katharina Nielsen",
        "leaveName": "Maternity Leave",
        "designation": "Accountant"
      },
      {
        "type": "Emergency",
        "status": "rejected",
        "name": "Franziska Doppler",
        "leaveName": "Emergency Leave",
        "designation": "Team Lead"
      },
      {
        "type": "Paid",
        "status": "taken",
        "name": "Claudia Tiedemann",
        "leaveName": "Sick Leave",
        "designation": "Product Owner"
      }, {
        "type": "Paid",
        "status": "cancelled",
        "name": "Claudia Tiedemann",
        "leaveName": "Sick Leave",
        "designation": "Product Owner"
      },
    ];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
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
                      _buildUserDetails(
                        LeaveRecordDetailsModel(
                            employeeName: data[index]["name"] ?? '',
                            applicationStatus: data[index]["status"] ?? '',
                            designation: data[index]["designation"] ?? '',
                            typeOfLeave: data[index]["leaveName"] ?? '',
                            leaveStatus: data[index]["type"] ?? '',
                            imgUrl: "",
                            leaveDate: "${DateFormat("dd MMM yy").format(DateTime.parse("2024-10-29 16:13:16.049738"))} - ${DateFormat("dd MMM yy").format(DateTime.parse("2024-10-29 16:13:16.049738"))}",

                            //"12 Mar 22 - 15 Mar 22",
                            leaveDuration: "3 days",
                            applicationDate: "2024-10-29 16:13:16.049738"

                            // '09 March 2020'

                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserDetails(LeaveRecordDetailsModel leaveRecordDetailsModel) {
    return InkWell(
      onTap: () {
        _showLeaveRecodeDetails(leaveRecordDetailsModel);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            imgUrlKey: leaveRecordDetailsModel.imgUrl ?? "",
            errorText: "Er",
            height: 20,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leaveRecordDetailsModel.employeeName ?? "",
                  maxLines: 2,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.secondaryColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.fontSizeMid - 2,
                  ),
                ),
                Text(
                  leaveRecordDetailsModel.designation ?? "",
                  maxLines: 2,
                  style: AppStyle.normal_text_black.copyWith(
                    color: AppColor.hintColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.fontSizeDefault - 2,
                  ),
                ),
                const SizedBox(height: 14),
                _buildLeaveDetails(
                  leaveRecordDetailsModel.typeOfLeave ?? "",
                  leaveRecordDetailsModel.leaveStatus ?? "",
                  leaveRecordDetailsModel.leaveDate ?? "",
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _showStatusButton(
                      leaveRecordDetailsModel.applicationStatus ?? "",
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _showLeaveRecordDetailsSheet(leaveRecordDetailsModel);
            },
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
      case 'cancel':
        return StatusBtnHelper.cancelStatusBtn();
        case 'cancelled':
        return StatusBtnHelper.cancelledStatusBtn();
      default:
        return Container();
    }
  }

  void _showLeaveRecordDetailsSheet(
      LeaveRecordDetailsModel leaveRecordDetailsModel) {
    customAntButtonSheet(
        context: Get.context!,
        height: MediaQuery.of(Get.context!).size.height / 1.5,
        child: MoreLeaveRecordDetails(
          leaveRecordDetails: LeaveRecordDetailsModel(
              applicationDate: leaveRecordDetailsModel.leaveStatus,
              applicationStatus: leaveRecordDetailsModel.applicationStatus,
              employeeName: leaveRecordDetailsModel.employeeName,
              leaveDate: leaveRecordDetailsModel.leaveDate,
              leaveDuration: leaveRecordDetailsModel.leaveDuration,
              typeOfLeave: leaveRecordDetailsModel.typeOfLeave,
              leaveStatus: leaveRecordDetailsModel.leaveStatus,
              designation: leaveRecordDetailsModel.designation,
              imgUrl: leaveRecordDetailsModel.imgUrl),
        ));
  }

  void _showLeaveRecodeDetails(
      LeaveRecordDetailsModel leaveRecordDetailsModel) {
    customAntButtonSheet(
        context: Get.context!,
        child: LeaveRecordDetails(
          leaveRecordDetailsModel: LeaveRecordDetailsModel(
              applicationDate: leaveRecordDetailsModel.applicationDate,
              applicationStatus: leaveRecordDetailsModel.applicationStatus,
              employeeName: leaveRecordDetailsModel.employeeName,
              leaveDate: leaveRecordDetailsModel.leaveDate,
              leaveDuration: leaveRecordDetailsModel.leaveDuration,
              typeOfLeave: leaveRecordDetailsModel.typeOfLeave,
              designation: leaveRecordDetailsModel.designation,
              imgUrl: leaveRecordDetailsModel.imgUrl),
        ));
  }
}
