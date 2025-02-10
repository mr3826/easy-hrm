import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/widget/custom_dialog.dart';
import '../../../../modules/timeline/view/widget/project_view_widget.dart';

void removeTask({required BuildContext context, required TaskInfo taskInfo}) {
  showCustomAlertDialog(
      context: context,
      onConfirm: () async {
        await Get.find<TimelineGlobalController>().removeTimelineEntry(
            timeLogId: taskInfo.timeLineId, orgId: taskInfo.employeeId);
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



void _updateDataFromApiResponse({required TaskInfo taskInfo}) {
  Get.find<TimelineGlobalController>().status.value = taskInfo.status ?? "";
  Get.find<TimelineGlobalController>().taskId.value = taskInfo.timeLineId ?? "";
  Get.find<TimelineGlobalController>().taskId.value = taskInfo.taskId ?? "";
  Get.find<TimelineGlobalController>().projectId.value = taskInfo.projectId ?? "";
  Get.find<TimelineGlobalController>().projectColor.value = taskInfo.projectColor ?? "";
  Get.find<TimelineGlobalController>().taskName.value = taskInfo.taskOrProjectName ?? "";
  Get.find<TimelineGlobalController>().descriptionController.text = taskInfo.description ?? "";
  Get.find<TimelineGlobalController>().timeLineId.value = taskInfo.timeLineId ?? "";

  ///Initially we get data from serve and don't need to update any thing. so..
  ///value=false
  ///if data change then value became true
  Get.find<TimelineGlobalController>().isValueChangeForTimeLogUpdate(false);
}
