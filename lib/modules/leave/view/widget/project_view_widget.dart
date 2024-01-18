import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
    required timeLineId,
    required context,
    required startDateTime,
    required endDateTime,
    required Color? bgColor,
    dateApplication,
    projectName,
    dtsProjectName,
    Color? dtsBgColor,
    dtsDrc,
    dtsDuration,
    dtsDate
    }) {

  return Padding(
    padding: marginLayout.copyWith(left: 4, right: 4),
    child: Column(
      children: [
        Column(
          children: [
            _infoLayout(
                text: AppString.text_start.tr, dynamicText: "$startTime"),
            customSpacerHeight(height: 6),
            _infoLayout(
                text: "${AppString.text_end.tr}:", dynamicText: "$endTime"),
            customSpacerHeight(height: 6),
          ],
        ),
        _infoLayout(
            text: "${AppString.text_status.tr}:",
            widget: statusBtn(status: "$status")),


        customSpacerHeight(height: 6),
        status == "taken"
            ? _infoLayout(
                text: AppString.text_dete_of_application.tr,
                dynamicText: DateFormat('dd MMMM yyyy').format(DateTime.parse(dateApplication)))
            : _infoLayout(
                text: AppString.text_project_task_or_tag,
                widget: _projectNameLayout(
                    color: dtsBgColor, name: "$projectName")),
        customSpacerHeight(height: 50),
        buttonLayout(
            context: context,
            status: "$status",
            dtsProjectName: "$dtsProjectName",
            dtsStartTime: "$startTime",
            dtsEndTime: "$endTime",
            dtsDuration: "$dtsDuration",
            dtsDrc: "$dtsDrc",
            dtsDateStatus: "$status",
            dtsDate: "$dtsDate",
            timeLineId: timeLineId,
            endDateTime: endDateTime,
            startDateTime: startDateTime,
            dtsBgColor: dtsBgColor)
      ],
    ),
  );
}

//For status taken
// approved button

_approvedLayout(projectName, dtsDuration) {
  return Column(
    children: [
      _infoLayout(
          text: "${AppString.text_type.tr}:", dynamicText: "$projectName"),
      _infoLayout(
          text: "${AppString.text_duration.tr}:", dynamicText: "$dtsDuration"),
    ],
  );
}

_takenLayout(projectName, dtsDuration) {
  return Column(
    children: [
      _infoLayout(
          text: "${AppString.text_type.tr}:", dynamicText: "$projectName"),
      _infoLayout(
          text: "${AppString.text_duration.tr}:", dynamicText: "$dtsDuration"),
    ],
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
        "${name == "" ? "Not Added yet" : name}",
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault + 1),
      )
    ],
  );
}
