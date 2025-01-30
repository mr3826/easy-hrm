import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/common/controller/convart_color_code_controller.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/widget/task_view_btn_sheet_appbar.dart' as btn;
import '../../../../../../modules/timeline/view/widget/project_view_widget.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/utils.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/project_view_widget.dart' as pj;

class BuildTaskDetails extends GetView<TimelineGlobalController> {
 final String taskId;
 final String taskName;
  const BuildTaskDetails({super.key,required this.taskName,required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isTimeEntryLoading.isTrue
        ? const LoadingIndicator()
        : Column(
            children: [
              //button sheet appbar here
              btn.projectViewBtnSheetAppbar(
                  date: formatDate(
                      date: controller
                              .timeEntryDetails?.getTimeEntryDetails?.startDate
                              .toString() ??
                          "",
                      format: "E, d MMMM - y"),
                  duration: getTimeDifference(
                      controller
                              .timeEntryDetails?.getTimeEntryDetails?.startDate
                              .toString() ??
                          "",
                      controller.timeEntryDetails?.getTimeEntryDetails?.endDate
                              .toString() ??
                          ""),
                  bgColor: controller.timeEntryDetails?.getTimeEntryDetails
                              ?.project?.color !=
                          null
                      ? HexColor(
                          controller.timeEntryDetails?.getTimeEntryDetails
                                  ?.project?.color ??
                              "",
                        )
                      : AppColor.primaryColor),
              pj.btnSheetViewLayout(
                  context: context,
                  taskInfo: TaskInfo(
                      projectColor: controller.timeEntryDetails?.getTimeEntryDetails?.project?.color ??
                          "",
                      projectId: controller.timeEntryDetails?.getTimeEntryDetails?.project?.id ??
                          "",
                      taskId: taskId,
                      employeeName:
                          "${controller.timeEntryDetails?.getTimeEntryDetails?.organizationUser?.profile?.firstName ?? ""} ${controller.timeEntryDetails?.getTimeEntryDetails?.organizationUser?.profile?.lastName ?? ""}",
                      employeeId: controller.timeEntryDetails?.getTimeEntryDetails
                              ?.organizationUser?.profile?.id ??
                          "",
                      endTime: controller.timeEntryDetails?.getTimeEntryDetails?.endDate ??
                          "",
                      startTime: controller.timeEntryDetails?.getTimeEntryDetails?.startDate != null
                          ? "${controller.timeEntryDetails?.getTimeEntryDetails?.startDate}"
                          : DateTime.now().toString(),
                      status:
                          controller.timeEntryDetails?.getTimeEntryDetails?.status ??
                              "",
                      description: controller.timeEntryDetails
                              ?.getTimeEntryDetails?.description ??
                          "",
                      taskOrProjectName: controller.timeEntryDetails
                              ?.getTimeEntryDetails?.project?.name ??
                          taskName,
                      timeLineId: controller.timeEntryDetails?.getTimeEntryDetails?.id ?? "",
                      totalDur: getTimeDifference(controller.timeEntryDetails?.getTimeEntryDetails?.startDate.toString() ?? "", controller.timeEntryDetails?.getTimeEntryDetails?.endDate.toString() ?? ""))),
            ],
          ));
  }
}

statusColor(status) {
  switch (status) {
    case "approved":
      return AppColor.primaryColor;
    case "pending":
      return AppColor.primaryOrange;
    case "reject":
      return AppColor.errorColorLight;
    case "taken":
      return AppColor.takenColor;
    case "rejected":
      return AppColor.errorColorLight;
    case "cancelled":
      return AppColor.errorColorLight;
    default:
      return AppColor.primaryColor;
  }
}
