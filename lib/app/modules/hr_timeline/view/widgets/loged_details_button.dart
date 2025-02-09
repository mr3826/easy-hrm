import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/time_sheet/timelog_summary_details.dart';
import '../../../../../common/controller/convart_color_code_controller.dart';
import '../../../../../common/widget/custom_dialog.dart';
import '../../../../../common/widget/custom_double_app_button.dart';
import '../../../../../modules/timeline/view/screen/update_timeline.dart';
import '../../../../../modules/timeline/view/widget/project_view_widget.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../global/view/widget/app_margin.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class LogDetailsButton extends StatelessWidget {
  final TaskInfo taskInfo;
  const LogDetailsButton({super.key, required this.taskInfo});

  @override
  Widget build(BuildContext context) {
    if (taskInfo.status == "reject") {
      return _rejectedBtn(context: context);
    } else if (taskInfo.status == "pending") {
      return _pendingLayout(
        context: context,
      );
    } else if (taskInfo.status == "cancelled") {
      return Container();
    } else if (taskInfo.status == "taken") {
      return Container();
    } else {
      return _approvedLayout(context: context);
    }
  }

  _rejectedBtn({required BuildContext context}) {
    return Padding(
        padding: marginLayout,
        child: CustomAppButton(
            isButtonExpanded: true,
            borderRadius: 40,
            buttonText: Text(
              AppString.text_remove.tr,
              style:
                  AppStyle.normal_text_grey.copyWith(color: AppColor.cardColor),
            ),
            onPressed: () => _removeTask(context: context, taskInfo: taskInfo),
            buttonColor: AppColor.errorColorLight));
  }

  _pendingLayout({required BuildContext context}) {
    return Padding(
      padding: marginLayout,
      child: CustomDoubleAppButton(
          cancelAction: () => _removeTask(context: context, taskInfo: taskInfo),
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
                  logSummaryUserInfo:
                      LogSummaryUserInfo(name: taskInfo.employeeName),
                  status: taskInfo.status ?? "",
                ));
          },
          btnColor: AppColor.primaryColor),
    );
  }

  void _removeTask(
      {required BuildContext context, required TaskInfo taskInfo}) {
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

  _approvedLayout({required BuildContext context}) {
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
                logSummaryUserInfo:
                    LogSummaryUserInfo(name: taskInfo.employeeName),
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
    Get.find<TimelineGlobalController>().taskId.value =
        taskInfo.timeLineId ?? "";
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
}
