import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import '../../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../../enum.dart';
import '../../../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../controller/leave_controller.dart';
import '../../leave_recorde/leave_record_list.dart';
import '../../leave_recorde/leave_recorde_details /leave_record_details.dart';
import '../../leave_recorde/leave_recorde_details /more_leave_record_details.dart';
import 'calendar_widget.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final LeaveRecordDetailsModel? leaveRecordDetailsModel;

  const TaskCard({super.key, required this.task, this.leaveRecordDetailsModel});

  @override
  Widget build(BuildContext context) {


    print("imageUrls_url :: ${task.imageUrls[0]}");


    if (task.isGroup) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onTap: (){
            Get.find<LeaveController>().tabLength(1);
            Get.find<LeaveController>().currentDate.value=leaveRecordDetailsModel?.leaveDate??"";
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OverlappingAvatars(
                imageUrls: task.imageUrls,
              ),
              const SizedBox(height: 11),
              Wrap(
                spacing: 2, // Space between items
                runSpacing: 6, // Space between rows
                children: [
                  if (task.approvedCount > 0)
                    StatusTag(
                        text: "Approved: ${task.approvedCount}",
                        color: getStatusColor(LeaveStatus.approved.name)),
                  if (task.pendingCount > 0)
                    StatusTag(
                        text: "Pending: ${task.pendingCount}",
                        color: getStatusColor(LeaveStatus.pending.name)),
                  if (task.rejectedCount > 0)
                    StatusTag(
                        text: "Rejected: ${task.rejectedCount}",
                        color: getStatusColor(LeaveStatus.rejected.name)),
                  if (task.takenCount > 0)
                    StatusTag(
                        text: "Taken: ${task.rejectedCount}",
                        color: getStatusColor(LeaveStatus.taken.name)),
                  if (task.cancelledCount > 0)
                    StatusTag(
                        text: "Cancelled: ${task.rejectedCount}",
                        color: getStatusColor(LeaveStatus.cancelled.name)),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {

          _showLeaveRecodeDetails(
            LeaveRecordDetailsModel(
                leaveDate: "2024-11-10",
                typeOfLeave: task.leaveType,
                leaveStatus: task.status,
                leaveDuration: "2 days",
                imgUrl: "",
                employeeName: task.name,
                designation:
                "Mobile Application Developer",
                applicationStatus: "pending",
                applicationDate: "20 Apr 2034"),);
        },
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: AppColor.leaveRecordCardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(profileImageKey: task.imageUrls[0], errorText: getInitials(task.imageUrls[0]),height: 18,imgUrlKey: "",),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.name ?? "",
                        style: AppStyle.normal_text_black.copyWith(
                            color: AppColor.secondaryColor,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.040),
                      ),
                      Text(
                        task.role ?? "",
                        style: AppStyle.normal_text_black.copyWith(
                            color: AppColor.hintColor,
                            fontSize: MediaQuery.of(context).size.width * 0.03),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        task.leaveType ?? "",
                        style: AppStyle.normal_text_black,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          showStatusButton(
                            task.status ?? "",
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {
                      _showLeaveRecordDetailsSheet(
                        LeaveRecordDetailsModel(
                          leaveId: task.leaveId,
                            leaveDate: "2024-11-10",
                            typeOfLeave: "Sick",
                            leaveStatus: "Paid",
                            leaveDuration: "2 days",
                            imgUrl: "",
                            employeeName: "Rifat Hasan",
                            designation:
                            "Mobile Application Developer",
                            applicationStatus: "pending",
                            applicationDate: "20 Apr 2034"),
                      );
                    },
                    child: const Icon(Icons.more_horiz)),
              ],
            ),
          ),
        ),
      );
    }
  }
}

void _showLeaveRecodeDetails(LeaveRecordDetailsModel leaveRecordDetailsModel) {
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

class Task {
  final String? name;
  final String? leaveId;
  final String? role;
  final String? leaveType;
  final String? status;
  final bool isGroup;
  final int approvedCount;
  final int pendingCount;
  final int rejectedCount;
  final int takenCount;
  final int cancelledCount;
  final List<String> imageUrls;

  Task({
    this.name,
    this.role,
    this.leaveType,
    this.leaveId,
    this.status,
    this.cancelledCount = 0,
    this.takenCount = 0,
    this.isGroup = false,
    this.approvedCount = 0,
    this.pendingCount = 0,
    this.rejectedCount = 0,
    required this.imageUrls,
  });
}

void _showLeaveRecordDetailsSheet(
    LeaveRecordDetailsModel leaveRecordDetailsModel) {
  customAntButtonSheet(
      context: Get.context!,
      height: MediaQuery.of(Get.context!).size.height / 1.5,
      child: MoreLeaveRecordDetails(
        leaveRecordDetails: LeaveRecordDetailsModel(
          leaveId: leaveRecordDetailsModel.leaveId,
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
