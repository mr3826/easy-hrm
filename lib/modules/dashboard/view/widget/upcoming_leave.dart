import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/leave/model/leave_record_response.dart';
import '../../../../common/domain/files_model.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/utils.dart';
import '../../../auth/presentation/view/otp_screen.dart';
import '../../../leave/model/leave_records.dart';
import '../../../leave/view/widget/leave_record_details_view.dart';
import '../../../profile/view/widget/action_layout_widget.dart';
import '../../../timeline/view/widget/timeline_calendar.dart';
import '../../controller/dashbpard_controller.dart';
import 'dashboad_widget.dart';

class UpcomingLeaveLayout extends StatelessWidget {
  const UpcomingLeaveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<DashboardController>();
    return Padding(
      padding: marginLayout,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?.length ?? 0,
        itemBuilder: (context, index) {
          Color itemBgColor =
          index % 2 == 0 ? AppColor.primaryColor.withOpacity(0.04) : Colors.transparent;
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () => customAntButtonSheet(
                  context: context,
                  child: LeaveRecordDetails(
                    status: controller.upcommingLeaveDashboard
                            ?.getUpcomingLeavesForApp?[index].status ??
                        "taken",
                    leaveRecords: GetLeaveRecords(
                      id: controller.upcommingLeaveDashboard
                          ?.getUpcomingLeavesForApp?[index].id,
                      status: controller.upcommingLeaveDashboard
                              ?.getUpcomingLeavesForApp?[index].status ??
                          "",
                      createdAt: controller.upcommingLeaveDashboard
                              ?.getUpcomingLeavesForApp?[index].createdAt ??
                          "",
                      startDate: controller.upcommingLeaveDashboard
                              ?.getUpcomingLeavesForApp?[index].startDate ??
                          "",
                      endDate: controller.upcommingLeaveDashboard
                              ?.getUpcomingLeavesForApp?[index].endDate ??
                          "",
                      files: [
                        controller
                                        .upcommingLeaveDashboard
                                        ?.getUpcomingLeavesForApp?[index]
                                        .files !=
                                    null &&
                                controller
                                    .upcommingLeaveDashboard!
                                    .getUpcomingLeavesForApp![index]
                                    .files!
                                    .isNotEmpty
                            ? Files(
                                createdAt: controller
                                        .upcommingLeaveDashboard
                                        ?.getUpcomingLeavesForApp?[index]
                                        .files?[0]
                                        .createdAt ??
                                    "",
                                size: controller
                                        .upcommingLeaveDashboard
                                        ?.getUpcomingLeavesForApp?[index]
                                        .files?[0]
                                        .size ??
                                    "",
                                name: controller
                                        .upcommingLeaveDashboard
                                        ?.getUpcomingLeavesForApp?[index]
                                        .files?[0]
                                        .name ??
                                    "",
                                id: controller
                                        .upcommingLeaveDashboard
                                        ?.getUpcomingLeavesForApp?[index]
                                        .files?[0]
                                        .id ??
                                    "",
                                key: controller
                                        .upcommingLeaveDashboard
                                        ?.getUpcomingLeavesForApp?[index]
                                        .files?[0]
                                        .key ??
                                    "",
                              )
                            : Files()
                      ],
                      leaveType: controller.upcommingLeaveDashboard
                          ?.getUpcomingLeavesForApp?[index].leaveType,
                      duration: controller.upcommingLeaveDashboard
                              ?.getUpcomingLeavesForApp?[index].numberOfDays ??
                          0,
                      description: controller.upcommingLeaveDashboard
                          ?.getUpcomingLeavesForApp?[index].description,
                    ),
                  ),
                ),
                child: Card(
                  elevation: 0,
                  color: itemBgColor,
                  shape: roundedRectangleBorder,
                  child: Padding(
                    padding: marginLayout.copyWith(
                        left: 12, right: 12, top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller
                                      .upcommingLeaveDashboard
                                      ?.getUpcomingLeavesForApp?[index]
                                      .status!
                                      .capitalizeFirst ??
                                  "",
                              style: AppStyle.normal_text_grey.copyWith(
                                color:
                                    AppColor.normalTextColor.withOpacity(0.8),
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                            customSpacerHeight(height: 4),
                            _leaveInfoRow(index, controller),
                          ],
                        ),
                        getStatusButton(controller.upcommingLeaveDashboard
                                ?.getUpcomingLeavesForApp?[index].status ??
                            "taken"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

_leaveInfoRow(int index, controller) {
  String? leaveDate;
  String starDate = dateMonthFormatFromDatetime(controller
          .upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].startDate
          ?.substring(0, 10) ??
      "2023-01-01T08:23:49.550Z");
  String endDate = dateMonthFormatFromDatetime(controller
          .upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].endDate
          ?.substring(0, 10) ??
      "2023-01-01T08:23:49.550Z");
  if (starDate == endDate) {
    leaveDate = dateMonthFormatFromDatetime(controller.upcommingLeaveDashboard
            ?.getUpcomingLeavesForApp?[index].startDate ??
        "2023-01-01T08:23:49.550Z");
  } else {
    leaveDate =
        "${dateMonthFormatFromDatetime(controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].startDate ?? "2023-01-01T08:23:49.550Z")} - ${dateMonthFormatFromDatetime(controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].endDate ?? "2023-01-01T08:23:49.550Z")}";
  }
  return Row(
    children: [
      Text(
        leaveDate.toString(),
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.secondaryColor,
            fontSize: Dimensions.fontSizeDefault),
      ),
      customSpacerWidth(width: 8),
      Text(
        " | ${getDurationTime(duration: "${controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].numberOfDays}")}",
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor, fontSize: Dimensions.fontSizeDefault),
      ),
    ],
  );
}
