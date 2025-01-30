import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/common/controller/convart_color_code_controller.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/widget/custom_dialog.dart';
import '../../../../modules/timeline/view/screen/update_timeline.dart';
import '../../../../modules/timeline/view/widget/project_view_widget.dart';
import '../widget/app_margin.dart';

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
    bgColor: AppColor.pendingColor.withOpacity(0.1),
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

Widget buttonLayout(
    {required BuildContext context, required TaskInfo taskInfo}) {
  if (taskInfo.status == "reject") {
    return _rejectedBtn(context: context, taskInfo: taskInfo);
  } else if (taskInfo.status == "pending") {
    return _pendingLayout(taskInfo: taskInfo, context: context);
  } else if (taskInfo.status == "cancelled") {
    return Container();
  } else if (taskInfo.status == "taken") {
    return Container();
  } else {
    return _approvedLayout(context: context, taskInfo: taskInfo);
  }
}

_rejectedBtn({required BuildContext context, required TaskInfo taskInfo}) {
  return Padding(
    padding: marginLayout,
    child: CustomDoubleAppButton(
        cancelAction: () async {
          removeTask(context: context, taskInfo: taskInfo);
        },
        buttonText: AppString.text_details.tr,
        cancelText: AppString.text_remove.tr,
        onAction: () {
          _updateDataFromApiResponse(taskInfo: taskInfo);
          Get.to(() {
            return UpdateTimeLineLog(
              projectOrTaskColor: taskInfo.projectColor.isNotEmpty
                  ? HexColor(taskInfo.projectColor)
                  : AppColor.primaryColor,
              endDateTime: taskInfo.endTime,
              startDateTime: taskInfo.startTime,
              status: taskInfo.status ?? "",
            );
          });
        },
        btnColor: AppColor.primaryColor),
  );
}

_pendingLayout({required BuildContext context, required TaskInfo taskInfo}) {
  return Padding(
    padding: marginLayout,
    child: CustomDoubleAppButton(
        cancelAction: () async {
          removeTask(context: context, taskInfo: taskInfo);
        },
        buttonText: AppString.text_details.tr,
        cancelText: AppString.text_remove.tr,
        onAction: () {
          _updateDataFromApiResponse(taskInfo: taskInfo);
          Get.to(() => UpdateTimeLineLog(
                projectOrTaskColor: taskInfo.projectColor.isNotEmpty
                    ? HexColor(taskInfo.projectColor)
                    : AppColor.primaryColor,
                endDateTime: taskInfo.endTime,
                startDateTime: taskInfo.startTime,
                status: taskInfo.status ?? "",
              ));
        },
        btnColor: AppColor.primaryColor),
  );
}

void removeTask({required BuildContext context, required TaskInfo taskInfo}) {
  showCustomAlertDialog(
      context: context,
      onConfirm: () async {
        await Get.find<TimelineGlobalController>()
            .removeTimelineEntry(timeLogId: taskInfo.timeLineId);
        Get.back(canPop: false);
        Get.back(canPop: false);
      },
      iconData: Icons.delete_outline_outlined,
      titleText: AppString.text_remove_timelog.tr,
      descriptionText: AppString.text_sure_you_want_to_delete_timelog.tr,
      iconBackgroundColor: AppColor.errorColorLight,
      confirmButtonColor: AppColor.errorColorLight,
      confirmButtonText: "",
      extraInfoText: "",
      descriptionFontSize: Dimensions.fontSizeDefault - 1,
      confirmButtonChild: Obx(() => Get.find<TimelineGlobalController>()
              .isTimelogEntryOrRemoveLoading
              .isTrue
          ? const CupertinoActivityIndicator(
              color: Colors.white,
            )
          : removeTextLayout()));
}

removeTextLayout() {
  return Text(
    AppString.text_remove.tr,
    style: AppStyle.normal_text_grey.copyWith(
        fontSize: Dimensions.fontSizeDefault + 1, color: AppColor.cardColor),
  );
}

_approvedLayout({required BuildContext context, required TaskInfo taskInfo}) {
  return Padding(
    padding: marginLayout,
    child: CustomAppButton(
      borderRadius: 30,
      buttonText: Text(
        AppString.text_details.tr,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.cardColor,
            fontSize: Dimensions.fontSizeDefault + 2),
      ),
      onPressed: () {
        _updateDataFromApiResponse(taskInfo: taskInfo);
        Get.to(() => UpdateTimeLineLog(
              projectOrTaskColor: taskInfo.projectColor.isNotEmpty
                  ? HexColor(taskInfo.projectColor)
                  : AppColor.primaryColor,
              endDateTime: taskInfo.endTime,
              startDateTime: taskInfo.startTime,
              status: taskInfo.status,
            ));
      },
      buttonColor: AppColor.primaryColor,
      isButtonExpanded: true,
    ),
  );
}

void _updateDataFromApiResponse({required TaskInfo taskInfo}) {
  Get.find<TimelineGlobalController>().status.value = taskInfo.status ?? "";
  Get.find<TimelineGlobalController>().taskId.value = taskInfo.timeLineId ?? "";
  Get.find<TimelineGlobalController>().taskId.value = taskInfo.taskId ?? "";
  Get.find<TimelineGlobalController>().projectId.value =
      taskInfo.projectId ?? "";
  Get.find<TimelineGlobalController>().projectColor.value =
      taskInfo.projectColor ?? "";
  Get.find<TimelineGlobalController>().taskName.value =
      taskInfo.taskOrProjectName ?? "";
  Get.find<TimelineGlobalController>().descriptionController.text =
      taskInfo.description ?? "";
  Get.find<TimelineGlobalController>().timeLineId.value =
      taskInfo.timeLineId ?? "";

  ///Initially we get data from serve and don't need to update any thing. so..
  ///value=false
  ///if data change then value became true
  Get.find<TimelineGlobalController>().isValueChangeForTimeLogUpdate(false);
}
