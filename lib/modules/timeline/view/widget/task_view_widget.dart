import 'dart:math';

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
   const TaskView( {required this.date, required this.startTime, required this.endTime, required this.status, required this.projectName, super.key, required this.totalDur});

  @override
  Widget build(BuildContext context) {

    print(date.toString());
    print(startTime.toString());
    print(endTime.toString());
    print(status.toString());
    print(projectName.toString());

    String projectNam = projectName.substring(1, projectName.length - 1);
    String projectStatus = status.substring(1, status.length - 1);
    String startT = startTime.substring(1, startTime.length - 1);
    String endT = endTime.substring(1, endTime.length - 1);
    String createAtDate = date.substring(1, date.length - 1);
    String formatDuration = totalDur.substring(1, totalDur.length - 1);

// Parse the original date and time string
    DateTime originalDateTime = DateTime.parse(startT.toString());

    // Format the DateTime to 24-hour format
    String startFormatTime = DateFormat('HH:mm').format(originalDateTime);

    // Parse the original date and time string
    DateTime endTi = DateTime.parse(endT.toString());

    // Format the DateTime to 24-hour format
    String endFormatTime = DateFormat('HH:mm').format(endTi);

    // Parse the original date and time string
    DateTime createAtDateD = DateTime.parse(createAtDate);

    // Format the DateTime to the desired format
    String createDate = DateFormat('E, dd MMMM - yyyy').format(createAtDateD);
    
    print("start date ==> $startTime");
    print("end time ==> $endFormatTime");



    // Using int.parse() to convert the string to an integer
    int intValue = int.parse(formatDuration);
    // Create a Duration object from the total minutes
    Duration duration =  Duration(minutes: intValue);
    // Format the Duration to the desired format
    String durationTime = convertMiniToHour(duration);




    statusColor(){
      Color color=AppColor.primaryColor;
      switch(status){
        case "(approved)":
          return color=AppColor.primaryColor;
        case "(pending)":
          return color=AppColor.primaryOrange;
        case "(rejected)":
          return color=AppColor.errorColorLight;
        default:
          return color=AppColor.primaryColor;
      }
    }
    return Column(
      children: [

        //button sheet appbar here
        projectViewBtnSheetAppbar(
            date: createDate,
            duration: durationTime,
            bgColor: statusColor()),


        //button sheet body here
        btnSheetViewLayout(
          context: context,
          status: projectStatus,
          startTime: startFormatTime.toString(),
          endTime: endFormatTime.toString(),
          dateApplication: date.toString(),
          projectName: projectNam.toString(),
          bgColor: statusColor(),
          dtsDuration: durationTime,
          dtsBgColor: statusColor(),
          dtsDate: createDate,


          dtsDateStatus: "Tomorrow",

          dtsDrc: "My note x",

          dtsProjectName: "The one project x",



        ),
      ],
    );
  }
}
