import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/controller/convart_color_code_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/project_view_widget.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/widget/task_view_btn_sheet_appbar.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/utils.dart';

class TaskView extends StatelessWidget {
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String totalDur;
  final String description;
  final String timeLineId;
  final String taskName;
  final String taskId;
  final String projectId;
  final String projectName;
  final String projectColor;
  final String employeeName;
  final String employeeId;

  const TaskView({
    required this.date,
    required this.description,
    required this.employeeName,
    required this.employeeId,
    required this.startTime,
    required this.endTime,
    required this.timeLineId,
    required this.status,
    required this.taskName,
    super.key,
    required this.totalDur,
    required this.taskId,
    required this.projectId,
    required this.projectName,
    required this.projectColor,
  });

  @override
  Widget build(BuildContext context) {
    print('''
  final String date $date;
  final String startTime $startTime;
  final String endTime $endTime;
  final String status $status;
  final String totalDur $totalDur;
  final String description $description;
  final String timeLineId $timeLineId;
  final String taskName $taskName;
  final String taskId $taskId;
  final String projectId $projectId;
  final String projectName $projectName;
  final String projectColor $projectColor;
    ''');

    return Column(
      children: [
        //button sheet appbar here
        projectViewBtnSheetAppbar(
            date: DateTime.parse(startTime),
            duration: totalDur.isEmpty
                ? convertMiniToHour(Duration(
                    minutes: DateTime.now()
                        .difference(DateTime.parse(startTime))
                        .inMinutes))
                : convertMiniToHour(Duration(minutes: int.parse(totalDur))),
            bgColor: projectColor.isNotEmpty
                ? HexColor(projectColor)
                : AppColor.primaryColor),

        //button sheet body here
        // make sure start or end date in not empty
        btnSheetViewLayout(
            context: context,
            taskInfo: TaskInfo(
                projectColor: projectColor,
                projectId: projectId,
                taskId: taskId,
                employeeName: employeeName,
                employeeId: employeeId,
                endTime: endTime,
                startTime: startTime.isNotEmpty
                    ? startTime
                    : DateTime.now().toString(),
                status: status,
                description: description,
                taskOrProjectName:
                    projectName.isNotEmpty ? projectName : taskName,
                timeLineId: timeLineId,
                totalDur: totalDur)),
      ],
    );
  }
}

statusColor(status) {
  switch (status) {
    case "approved":
      return AppColor.primaryColor;
    case "pending":
      return AppColor.primaryOrange;
    case "reject":
      return AppColor.errorColorLight;
    case "taken":
      return AppColor.takenColor;
    case "rejected":
      return AppColor.errorColorLight;
    case "cancelled":
      return AppColor.errorColorLight;
    default:
      return AppColor.primaryColor;
  }
}

class TaskInfo {
  final String startTime;
  final String endTime;
  final String? status;
  final String? totalDur;
  final String? description;
  final String? timeLineId;
  final String? taskOrProjectName;
  final String? taskId;
  final String? projectId;
  final String projectColor;
  final String employeeName;
  final String employeeId;


  TaskInfo(
      {required this.startTime,
      required this.endTime,
      this.status,
      this.totalDur,
      required this.employeeId,
      required this.employeeName,
      this.description,
      this.timeLineId,
      this.taskOrProjectName,
      this.taskId,
      this.projectId,
      required this.projectColor});
}
