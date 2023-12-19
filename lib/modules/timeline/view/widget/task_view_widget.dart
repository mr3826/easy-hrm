import 'package:flutter/material.dart';
import 'package:payrun_mobile/modules/leave/view/widget/project_view_widget.dart';
import 'package:payrun_mobile/modules/leave/view/widget/task_view_btn_sheet_appbar.dart';
import '../../../../utils/app_color.dart';

class TaskView extends StatelessWidget {
  final Color? bgColor;
  const TaskView({super.key, this.bgColor = AppColor.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //button sheet appbar here
        projectViewBtnSheetAppbar(
            date: "Thu, 21 April - 2022",
            duration: "02h 30m",
            bgColor: bgColor),


        //button sheet body here
        btnSheetViewLayout(
          context: context,
          status: "rejected",
          startTime: "10.00 x",
          endTime: "20.00 x",
          dateApplication: "02 March 2022 x",
          projectName: "Project name one x",
          bgColor: bgColor,
          dtsDuration: "04 h 30m",
          dtsBgColor: AppColor.successColor,
          dtsDate: "Thu, 21 April - 2022 x",
          dtsDateStatus: "Tomorrow",
          dtsDrc: "My note x",
          dtsProjectName: "The one project x",


        ),
      ],
    );
  }
}
