import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../../utils/utils.dart';
import '../../../timeline/view/screen/update_timeline.dart';

Widget approvedStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.successColor,
    bgColor: AppColor.successColor.withOpacity(0.1),
    text: AppString.text_approved.tr,
  );
}

Widget rejectedStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.errorColorLight,
    bgColor: AppColor.errorColor.withOpacity(0.1),
    text: AppString.text_rejected.tr,
  );
}

Widget pendingStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.pendingColor,
    bgColor: AppColor.pendingColor.withOpacity(0.2),
    text: AppString.text_pendding.tr,
  );
}

Widget tokenStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.primaryColor,
    bgColor: AppColor.primaryColor.withOpacity(0.1),
    text: AppString.text_token.tr,
  );
}

Widget cancelStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.bgColor,
    bgColor: AppColor.errorColorLight.withOpacity(.9),
    text: AppString.text_cancel.tr,
  );
}

Widget canceledStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.errorColorLight,
    bgColor: AppColor.errorColorLight.withOpacity(0.1),
    text: AppString.text_canceled.tr,
  );
}

statusBtn({required status}) {
  if (status == "reject") {
    return rejectedStatusBtn();
  } else if (status == "pending") {
    return pendingStatusBtn();
  } else if (status == "taken") {
    return tokenStatusBtn();
  } else if (status == "approved") {
    return approvedStatusBtn();
  } else if (status == "rejected") {
    return rejectedStatusBtn();
  } else if (status == "cancelled") {
    return canceledStatusBtn();
  } else {
    return approvedStatusBtn();
  }
}

Widget buttonLayout({
  required context,
  required timeLineId,
  required startDateTime,
  required endDateTime,
  required status,
  dtsStartTime,
  dtsEndTime,
  required dtsDateStatus,
  dtsProjectName,
  Color? dtsBgColor,
  dtsDrc,
  dtsDuration,
  dtsDate,
}) {
  if (status == "reject") {
    return _rejectedBtn(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        timeLineId: timeLineId,
        context: context,
        dtsBgColor: dtsBgColor,
        dtsDate: dtsDate,
        dtsDateStatus: dtsDateStatus,
        dtsDrc: dtsDrc,
        dtsDuration: dtsDuration,
        dtsEndTime: dtsEndTime,
        dtsStartTime: dtsStartTime,
        dtsProjectName: dtsProjectName,
        dtsStatus: dtsDateStatus);
  } else if (status == "pending") {
    return _pendingLayout(
        endDateTime: endDateTime,
        startDateTime: startDateTime,
        timeLineId: timeLineId,
        context: context,
        dtsBgColor: dtsBgColor,
        dtsDate: dtsDate,
        dtsDateStatus: dtsDateStatus,
        dtsDrc: dtsDrc,
        dtsDuration: dtsDuration,
        dtsEndTime: dtsEndTime,
        dtsStartTime: dtsStartTime,
        dtsProjectName: dtsProjectName,
        dtsStatus: dtsDateStatus);
  } else if (status == "cancelled") {
    return Container();
  } else if (status == "taken") {
    return Container();
  } else {
    return _approvedLayout(
        endDateTime: endDateTime,
        startDateTime: startDateTime,
        timeLineId: timeLineId,
        context: context,
        dtsBgColor: dtsBgColor,
        dtsDate: dtsDate,
        dtsDateStatus: dtsDateStatus,
        dtsDrc: dtsDrc,
        dtsDuration: dtsDuration,
        dtsEndTime: dtsEndTime,
        dtsStartTime: dtsStartTime,
        dtsProjectName: dtsProjectName,
        dtsStatus: dtsDateStatus);
  }
}

_rejectedBtn({
  context,
  dtsStartTime,
  dtsEndTime,
  dtsDateStatus,
  dtsProjectName,
  Color? dtsBgColor,
  dtsDrc,
  dtsDuration,
  dtsDate,
  dtsStatus,
  required timeLineId,
  required startDateTime,
  required endDateTime,
}) {
  return Padding(
    padding: marginLayout,
    child: CustomDoubleAppButton(
        cancelAction: () {
          customDialog(
              context: context,
              saveBtnAction: () => Get.back(),
              icon: Icons.delete_outline_outlined,
              titleText: AppString.text_remove_time_log.tr,
              subText: AppString.text_sure_you_want_to_deleted_this_log.tr,
              drcText: AppString.text_if_you_deleted_this_time_log_etc.tr,
              iconBgColor: AppColor.errorColorLight,
              btnBgColor: AppColor.errorColorLight,
              btnText: AppString.text_remove.tr);
        },
        buttonText: AppString.text_details.tr,
        cancelText: AppString.text_remove.tr,
        onAction: () {
          _updateDataFromApiResponse(
              startDate: dtsStartTime,
              endDate: dtsEndTime,
              description: dtsDrc,
              duration: dtsDuration,
              color: dtsBgColor,
              taskId: '',
              timelineId: '',
              status: dtsStatus);
          Get.to(() {
            return UpdateTimeLineLog(
              endDateTime: dtsEndTime,
              startDateTime: dtsStartTime,
              status: dtsStatus,
            );
          });
        },
        btnColor: AppColor.primaryColor),
  );
}

_pendingLayout(
    {context,
    dtsStartTime,
    dtsEndTime,
    dtsDateStatus,
    dtsProjectName,
    Color? dtsBgColor,
    required startDateTime,
    required endDateTime,
    dtsDrc,
    dtsDuration,
    required timeLineId,
    dtsDate,
    dtsStatus}) {
  return Padding(
    padding: marginLayout,
    child: CustomDoubleAppButton(
        cancelAction: () {
          Navigator.pop(context);
        },
        buttonText: AppString.text_details.tr,
        cancelText: AppString.text_cancel.tr,
        onAction: () {
          _updateDataFromApiResponse(
              startDate: dtsStartTime,
              endDate: dtsEndTime,
              description: dtsDrc,
              duration: dtsDuration,
              color: dtsBgColor,
              taskId: '',
              timelineId: timeLineId,
              status: dtsStatus);
          Get.to(() => UpdateTimeLineLog(
                endDateTime: dtsEndTime,
                startDateTime: dtsStartTime,
                status: "pending",
              ));
        },
        btnColor: AppColor.primaryColor),
  );
}

_approvedLayout(
    {context,
    required startDateTime,
    required endDateTime,
    dtsStartTime,
    dtsEndTime,
    dtsDateStatus,
    dtsProjectName,
    Color? dtsBgColor,
    dtsDrc,
    dtsDuration,
    dtsDate,
    dtsStatus,
    required timeLineId}) {
  return Padding(
    padding: marginLayout,
    child: CustomAppButton(
      buttonText: Text(
        AppString.text_details.tr,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.cardColor,
            fontSize: Dimensions.fontSizeDefault + 2),
      ),
      onPressed: () {
        Get.find<TimelineController>().timeLogStatus == dtsStatus;
        Get.find<TimelineController>().timeLineID == timeLineId;
        _updateDataFromApiResponse(
            startDate: dtsStartTime,
            endDate: dtsEndTime,
            description: dtsDrc,
            duration: dtsDuration,
            color: dtsBgColor,
            taskId: '',
            timelineId: '',
            status: dtsStatus);
        Get.to(() => UpdateTimeLineLog(
              endDateTime: dtsEndTime,
              startDateTime: dtsStartTime,
              status: "pending",
            ));
      },
      buttonColor: AppColor.primaryColor,
      isButtonExpanded: false,
    ),
  );
}

void _updateDataFromApiResponse(
    {required startDate,
    required endDate,
    required taskId,
    required status,
    required color,
    required duration,
    required timelineId,
    required description}) {
  Get.find<TimelineController>().timeLogDuration = duration;
  Get.find<TimelineController>().timeLogColor = color;
  Get.find<TimelineController>().timeLogStatus = status;
  Get.find<TimelineController>().timeLineID = timelineId.toString();

  Get.find<DateTimeController>().requestedDate.value =
      DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate));

  timelineLogDetailsDrcController.text = description;
  DateTime startTime = DateTime.parse(startDate);

  DateTime endTime = DateTime.parse(endDate);

  Get.find<DateTimeController>().pickedInTime.value =
      "${startTime.hour > 11 ? "${startTime.hour - 12}".padLeft(2, "0") : "${startTime.hour}".padLeft(2, "0")}:${startTime.minute.toString().padLeft(2, "0")}${startTime.hour > 11 ? "PM" : "AM"}";
  Get.find<DateTimeController>().pickedOutTime.value =
      "${endTime.hour > 11 ? "${endTime.hour - 12}".padLeft(2, "0") : "${endTime.hour}".padLeft(2, "0")}:${endTime.minute.toString().padLeft(2, "0")}${startTime.hour > 11 ? "PM" : "AM"}";
}
