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
        projectViewBtnSheetAppbar(
            date: "Thu, 21 April - 2022",
            duration: "02h 30m",
            bgColor: AppColor.primaryColor),
        btnSheetViewLayout(
          context: context,
          status: "taken",
          startTime: "10.00",
          endTime: "20.00",
          dateApplication: "02 March 2022",
          projectName: "Project name one",
        )
      ],
    );
  }
}
