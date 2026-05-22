import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/controller/convart_color_code_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../app/global/utils/status_btn_helper_by_context.dart';
import '../../../../app/global/view/widget/app_margin.dart';
import '../../../../app/modules/hr_timeline/view/widgets/loged_details_button.dart';

Widget btnSheetViewLayout({required BuildContext context, required TaskInfo taskInfo}) {
  return Padding(
    padding: marginLayout.copyWith(left: 4, right: 4),
    child: Column(
      children: [
        ///start and end time layout
        Column(
          children: [
            _infoLayout(text: AppString.text_start.tr,dynamicText: DateFormat('HH:mm').format(DateTime.parse(taskInfo.startTime))),
            customSpacerHeight(height: 6),
            _infoLayout(
                text: "${AppString.text_end.tr}:",
                dynamicText: taskInfo.endTime.isNotEmpty
                    ? DateFormat('HH:mm')
                        .format(DateTime.parse(taskInfo.endTime))
                    : ""),
            customSpacerHeight(height: 6),
          ],
        ),

        ///status layout
        _infoLayout(
            text: "${AppString.text_status.tr}:",
            widget:  StatusBtnHelperByContext.statusBtnByContext(taskInfo.status.toString())),
        customSpacerHeight(height: 6),

        ///project/task name
        _infoLayout(
            text: AppString.text_project_task_or_tag,
            widget: _projectNameLayout(
                color: HexColor(taskInfo.projectColor),
                name: taskInfo.taskOrProjectName.toString())),
        customSpacerHeight(height: 50),

        ///action double button according to context
        LogDetailsButton(taskInfo: taskInfo)
      ],
    ),
  );
}

_infoLayout({required String text, String? dynamicText,Widget? widget}) {
  return Padding(
    padding: marginLayout.copyWith(left: 20, right: 20, top: 12, bottom: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor,
              fontSize: Dimensions.fontSizeDefault + 1),
        ),
        widget ??
            Text(
              dynamicText ?? "",
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
      ],
    ),
  );
}

Widget _projectNameLayout({required Color? color, required String name}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      if( name != "" || name.isNotEmpty)
      Icon(
        Icons.circle,
        size: 13,
        color: color,
      ),
      customSpacerWidth(width: 4),
      Text(
        name == ""|| name.isEmpty ? "No project" : name,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault + 1),
      )
    ],
  );
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
