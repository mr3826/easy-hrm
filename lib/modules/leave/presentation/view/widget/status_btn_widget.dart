import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/convart_color_code_controller.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_view_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../common/widget/custom_dialog.dart';
import '../../../../../utils/utils.dart';
import '../../../../timeline/view/screen/update_timeline.dart';

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
  customDialog(
      context: context,
      saveBtnAction: () async {
        await Get.find<TimelineController>()
            .removeTimeEntry(timeLogId: taskInfo.timeLineId)
            .then((value) {
          if (value == true) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        });
      },
      icon: Icons.delete_outline_outlined,
      titleText: AppString.text_remove_timelog.tr,
      subText: AppString.text_sure_you_want_to_delete_timelog.tr,
      iconBgColor: AppColor.errorColorLight,
      btnBgColor: AppColor.errorColorLight,
      btnText: "",
      drcText: "",
      drcFontSize: Dimensions.fontSizeDefault - 1,
      childForSaveBtn: Obx(() => removeTextLayout()));
}

removeTextLayout() {
  return Get.find<TimelineController>().isTimelogEntryOrRemoveLoading.value
      ? const CupertinoActivityIndicator(
          color: AppColor.cardColor,
        )
      : Text(
          AppString.text_remove.tr,
          style: AppStyle.normal_text_grey.copyWith(
              fontSize: Dimensions.fontSizeDefault + 1,
              color: AppColor.cardColor),
        );
}

_approvedLayout({required BuildContext context, required TaskInfo taskInfo}) {
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
      isButtonExpanded: false,
    ),
  );
}

void _updateDataFromApiResponse({required TaskInfo taskInfo}) {
  Get.find<TimelineController>().timeLogStatus = taskInfo.status ?? "";
  Get.find<TimelineController>().timeLineID = taskInfo.timeLineId ?? "";
  Get.find<TimelineController>().taskId.value = taskInfo.taskId ?? "";
  Get.find<TimelineController>().projectId.value = taskInfo.projectId ?? "";
  Get.find<TimelineController>().projectColor.value =
      taskInfo.projectColor ?? "";
  Get.find<TimelineController>().taskName.value =
      taskInfo.taskOrProjectName ?? "";

  descriptionController.text = taskInfo.description ?? "";

  ///Initially we get data from serve and don't need to update any thing. so..
  ///value=false
  ///if data change then value became true
  Get.find<TimelineController>().isValueChangeForTimeLogUpdate(false);
}
