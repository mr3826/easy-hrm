import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/view/widget/leave_record/leave_record_details/leave_record_details.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/view/widget/leave_record/leave_record_details/more_leave_record_details.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import '../../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../../enum.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/utils.dart';
import '../../../../controller/hr_leave_controller.dart';
import '../../../../controller/leave_controller.dart';
import '../../leave_record/leave_record_list.dart';
import 'calendar_widget.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    if (task.isGroup) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onTap: () {
            Get.find<LeaveController>().tabLength(1);
            Get.find<LeaveController>().currentDate.value =
                task.startDate ?? "";
            Get.find<HrLeaveController>().getLeaveRecord(
                startDate: "${task.startDate}T00:00:00.000Z",
                endDate: "${task.startDate}T23:59:59.999Z");

            ///task.startDate and endDate same ... click always single date for leave
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
          _showLeaveRecodeDetails(task.leaveId.toString());
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
                CustomNetworkImage(
                  profileImageKey: task.imageUrls[0],
                  errorText: getInitials(task.imageUrls[0]),
                  height: 18,
                  imgUrlKey: "",
                ),
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
                        task.designation ?? "",
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
                      _showLeaveRecordDetailsSheet(task.leaveId ?? "");
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

void _showLeaveRecodeDetails(String leaveId) {
  final controller = Get.find<HrLeaveController>();
  // Fetch data and wait for completion
  controller.getLeaveDetailsById(leaveId: leaveId);
  showCustomBottomSheet(
    context: Get.context!,
    height: MediaQuery.of(Get.context!).size.height / 1.7,
    child: LeaveRecordDetails(
      leaveId: leaveId,
    ),
  );
}

class Task {
  final String? name;
  final String? leaveId;
  final String? role;
  final String? leaveType;
  final String? startDate;
  final String? status;
  final String? designation;
  final String? formattedLeaveHours;
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
    this.startDate,
    this.formattedLeaveHours,
    this.designation,
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

void _showLeaveRecordDetailsSheet(String leaveId) {
  final controller = Get.find<HrLeaveController>();
  // Fetch data and wait for completion
  controller.getLeaveDetailsById(leaveId: leaveId);
  showCustomBottomSheet(
      context: Get.context!,
      height: MediaQuery.of(Get.context!).size.height / 1.5,
      child: MoreLeaveRecordDetails(leaveId: leaveId));
}
