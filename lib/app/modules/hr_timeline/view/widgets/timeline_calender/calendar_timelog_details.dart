import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/time_entry_details.dart';
import 'package:payrun_mobile/common/controller/convart_color_code_controller.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/widget/task_view_btn_sheet_appbar.dart' as btn;
import '../../../../../../modules/timeline/view/widget/project_view_widget.dart';
import '../../../../../../utils/app_color.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/project_view_widget.dart' as pj;
import '../../../../../global/utils/date_format_helper.dart';
import '../../../../../global/utils/time_format_helper.dart';

class BuildTaskDetails extends GetView<TimelineGlobalController> {
  const BuildTaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){

      if(controller.isTimeEntryLoading.isTrue){
        return  const LoadingIndicator();
      }else{
        GetTimeEntryDetails? data =controller.timeEntryDetails?.getTimeEntryDetails;
        return Column(
          children: [
            ///button sheet appbar here
            _buildHeader(),
            ///Details view
            pj.btnSheetViewLayout(
                context: context,
                taskInfo: TaskInfo(projectColor: data?.project?.color ?? "", projectId: data?.project?.id ?? "",
                    taskId: data?.task?.id ?? "",
                    employeeName: "${data?.organizationUser?.profile?.firstName ?? ""} ${data?.organizationUser?.profile?.lastName ?? ""}",
                    employeeId: data?.organizationUser?.id ?? "",
                    endTime: data?.endDate ?? "",
                    startTime: data?.startDate != null ? "${data?.startDate}" : DateTime.now().toString(),
                    status: data?.status ?? "",
                    description: data?.description ?? "",
                    taskOrProjectName: data?.project?.name ?? data?.task?.name ?? "",
                    timeLineId: data?.id ?? "",
                    totalDur: TimeFormatHelper.timeDifference(data?.startDate.toString() ?? "", data?.endDate.toString() ?? ""))),
          ],
        );
      }


    });
  }

  _buildHeader() {
   return btn.projectViewBtnSheetAppbar(
        date: DateFormatHelper.formatDate(date: controller.timeEntryDetails?.getTimeEntryDetails?.startDate.toString() ?? "", format: "E, d MMMM - y"),

        duration:TimeFormatHelper.timeDifference(
            controller.timeEntryDetails?.getTimeEntryDetails?.startDate.toString() ?? "",
            controller.timeEntryDetails?.getTimeEntryDetails?.endDate.toString() ?? ""),

        bgColor: controller.timeEntryDetails?.getTimeEntryDetails?.project?.color != null
            ? HexColor(
          controller.timeEntryDetails?.getTimeEntryDetails
              ?.project?.color ??
              "",
        )
            : AppColor.primaryColor);
  }
}

