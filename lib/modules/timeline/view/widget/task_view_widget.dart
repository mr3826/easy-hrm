import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/modules/leave/view/widget/project_view_widget.dart';
import 'package:payrun_mobile/modules/leave/view/widget/task_view_btn_sheet_appbar.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/utils.dart';

class TaskView extends StatelessWidget {
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String projectName;
  final String totalDur;
  final String description;
  final String timeLineId;

  const TaskView(
      {required this.date,
      required this.description,
      required this.startTime,
      required this.endTime,
      required this.timeLineId,
      required this.status,
      required this.projectName,
      super.key,
      required this.totalDur});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        //button sheet appbar here
        projectViewBtnSheetAppbar(date: DateTime.parse(startTime), duration: convertMiniToHour(Duration(minutes: int.parse(totalDur))).toString(),bgColor: statusColor(status)),

        //button sheet body here
        btnSheetViewLayout(
          context: context,
          status: status,
          startTime: DateFormat('HH:mm').format(DateTime.parse(startTime.toString())).toString(),
          endTime: DateFormat('HH:mm').format(DateTime.parse(endTime.toString())).toString(),
          dateApplication: date.toString(),
          projectName: projectName,
          bgColor: statusColor(status),
          dtsDuration: convertMiniToHour(Duration(minutes: int.parse(totalDur))),
          dtsBgColor: statusColor(status),
          timeLineId: timeLineId,
          dtsDate: DateFormat('HH:mm').format(DateTime.parse(startTime.toString())).toString(),
          dtsDrc: description,
          startDateTime: DateFormat('HH:mm').format(DateTime.parse(startTime.toString())).toString(),
          endDateTime: DateFormat('HH:mm').format(DateTime.parse(endTime.toString())).toString(),
        ),
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
    default:
      return AppColor.primaryColor;
  }
}
