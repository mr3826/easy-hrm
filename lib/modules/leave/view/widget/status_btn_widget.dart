import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  required String timeLineId,
  required String startDateTime,
  required String endDateTime,
  required String status,
  String? dtsStartTime,
  String? dtsEndTime,
  required String dtsDateStatus,
  String? dtsProjectName,
  required Color dtsBgColor,
  String? dtsDrc,
  String? dtsDuration,
  String? dtsDate,
}) {
  if (status == "reject") {
    return _rejectedBtn(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        timeLineId: timeLineId,
        context: context,
        dtsBgColor: dtsBgColor,
        dtsDate: dtsDate ?? "",
        dtsDateStatus: dtsDateStatus,
        dtsDrc: dtsDrc ?? "",
        dtsDuration: dtsDuration ?? "",
        dtsEndTime: dtsEndTime ?? "",
        dtsStartTime: dtsStartTime ?? "",
        dtsProjectName: dtsProjectName ?? "",
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
        dtsDrc: dtsDrc ?? "",
        dtsDuration: dtsDuration,
        dtsEndTime: dtsEndTime,
        dtsStartTime: dtsStartTime,
        dtsProjectName: dtsProjectName,
        dtsStatus: dtsDateStatus);
  }
}

_rejectedBtn({
  required BuildContext context,
  required String dtsStartTime,
  required String dtsEndTime,
  required String dtsDateStatus,
  required String dtsProjectName,
  required Color dtsBgColor,
  required String dtsDrc,
  required String dtsDuration,
  required String dtsDate,
  required String dtsStatus,
  required String timeLineId,
  required String startDateTime,
  required String endDateTime,
}) {
  return Padding(
    padding: marginLayout,
    child: CustomDoubleAppButton(
        cancelAction: () {
          customDialog(
              context: context,
              saveBtnAction: () {
                Get.find<TimelineController>()
                    .removeTimeEntry(timeLogId: timeLineId.toString());
              },
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
              timelineId: timeLineId,
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
    {required BuildContext context,
    required dtsStartTime,
    required dtsEndTime,
    required dtsDateStatus,
    required dtsProjectName,
    Color? dtsBgColor,
    required String startDateTime,
    required String endDateTime,
    String? dtsDrc,
    String? dtsDuration,
    required String timeLineId,
    required dtsDate,
    required dtsStatus}) {
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
              description: dtsDrc ?? "",
              duration: dtsDuration ?? "",
              color: dtsBgColor,
              taskId: '',
              timelineId: timeLineId,
              status: dtsStatus ?? "");
          Get.to(() => UpdateTimeLineLog(
                endDateTime: dtsEndTime ?? "",
                startDateTime: dtsStartTime ?? "",
                status: dtsStatus,
              ));
        },
        btnColor: AppColor.primaryColor),
  );
}

_approvedLayout(
    {required BuildContext context,
    required String startDateTime,
    required String endDateTime,
    String? dtsStartTime,
    String? dtsEndTime,
    String? dtsDateStatus,
    String? dtsProjectName,
    Color? dtsBgColor,
    required String dtsDrc,
    String? dtsDuration,
    String? dtsDate,
    String? dtsStatus,
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
        //todo
        ///check what this logic mean
        Get.find<TimelineController>().timeLogStatus == dtsStatus;
        Get.find<TimelineController>().timeLineID == timeLineId;
        _updateDataFromApiResponse(
            startDate: dtsStartTime ?? "",
            endDate: dtsEndTime ?? "",
            description: dtsDrc,
            duration: dtsDuration ?? "",
            color: dtsBgColor,
            taskId: '',
            timelineId: timeLineId,
            status: dtsStatus ?? "");
        Get.to(() => UpdateTimeLineLog(
              endDateTime: dtsEndTime ?? "",
              startDateTime: dtsStartTime ?? "",
              status: dtsStatus,
            ));
      },
      buttonColor: AppColor.primaryColor,
      isButtonExpanded: false,
    ),
  );
}

void _updateDataFromApiResponse(
    {required String startDate,
    required String endDate,
    required String taskId,
    required String status,
    required color,
    required String duration,
    required String timelineId,
    required String description}) {
  Get.find<TimelineController>().timeLogColor = color;
  Get.find<TimelineController>().timeLogStatus = status;
  Get.find<TimelineController>().timeLineID = timelineId.toString();
  descriptionController.text = description;
}
