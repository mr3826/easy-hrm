import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/leave/view/widget/status_btn_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../auth/presentation/view/otp_screen.dart';

Widget btnSheetViewLayout(
    {required startTime,
    required endTime,
    required status,
    required context,
    required Color? bgColor,
    dateApplication,
    projectName,
    dtsDateStatus,
    dtsProjectName,
    Color? dtsBgColor,
    dtsDrc,
    dtsDuration,
    dtsDate}) {
  return Padding(
    padding: marginLayout.copyWith(left: 4, right: 4),
    child: Column(
      children: [
        _infoLayout(text: AppString.text_start.tr, dynamicText: "$startTime"),
        customSpacerHeight(height: 6),
        _infoLayout(text: "${AppString.text_end.tr}:", dynamicText: "$endTime"),
        customSpacerHeight(height: 6),
        _infoLayout(
            text: "${AppString.text_status.tr}:",
            widget: statusBtn(status: "$status")),
        customSpacerHeight(height: 6),
        status == "taken"
            ? _infoLayout(
                text: AppString.text_dete_of_application.tr,
                dynamicText: "$dateApplication")
            : _infoLayout(
                text: AppString.text_project_task_or_tag,
                widget:
                    _projectNameLayout(color: bgColor, name: "$projectName")),
        customSpacerHeight(height: 50),

        buttonLayout(
            context: context,
            status: "$status",
            dtsProjectName: "$dtsProjectName",
            dtsStartTime: "$startTime",
            dtsEndTime: "$endTime",
            dtsDuration: "$dtsDuration",
            dtsDrc: "$dtsDate",
            dtsDateStatus: "$dtsDateStatus",
            dtsDate: "$dtsDate",
            dtsBgColor: dtsBgColor)
      ],
    ),
  );
}

_infoLayout({required text, dynamicText, widget}) {
  return Padding(
    padding: marginLayout.copyWith(left: 20, right: 20, top: 12, bottom: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$text",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor,
              fontSize: Dimensions.fontSizeDefault + 1),
        ),
        widget ??
            Text(
              "$dynamicText",
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
      ],
    ),
  );
}

Widget _projectNameLayout({required Color? color, required name}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Icon(
        Icons.circle,
        size: 13,
        color: color,
      ),
      customSpacerWidth(width: 4),
      Text(
        "$name",
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault + 1),
      )
    ],
  );
}
