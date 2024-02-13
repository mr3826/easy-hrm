import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_records.dart';
import 'package:payrun_mobile/modules/leave/view/widget/status_btn_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/domain/files_model.dart';
import '../../../../common/widget/custom_dotted_border.dart';
import '../../../../common/widget/timePicker/custom_time_picker_in_time.dart';
import '../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../model/leave_record_response.dart';
import 'leave_record_details_view.dart';

class IndividualEventView extends StatelessWidget {
  const IndividualEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customSpacerHeight(height: 5),
        horizontalCalendarLayout(),
        customSpacerHeight(height: 5),
        customSpacerHeight(height: 8),
        _eventText(),
        Obx(() => _eventViewLayout()),
        customSpacerHeight(height: 100),
      ],
    );
  }

  _eventText() {
    return Padding(
      padding: marginLayout,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customSpacerHeight(height: 50),
          horizontalDashLayout(),
          Padding(
            padding: marginLayout.copyWith(left: 30, right: 30),
            child: Text(
              AppString.text_event.tr,
              style: AppStyle.normal_text_black
                  .copyWith(color: AppColor.hintColor),
            ),
          ),
          horizontalDashLayout()
        ],
      ),
    );
  }

  _eventViewLayout() {
    return Get.find<LeaveScreenController>().isLoading.isTrue
        ? const CupertinoActivityIndicator(
            color: Colors.blueAccent,
            radius: 20,
          )
        : _eventList();
  }

  _getStatusButton(String leaveStatus) {
    if (leaveStatus.toLowerCase() == LeaveStatus.approved.name) {
      return approvedStatusBtn();
    } else if (leaveStatus.toLowerCase() == LeaveStatus.rejected.name) {
      return rejectedStatusBtn();
    } else if (leaveStatus.toLowerCase() == LeaveStatus.pending.name) {
      return pendingStatusBtn();
    } else if (leaveStatus.toLowerCase() == LeaveStatus.taken.name) {
      return tokenStatusBtn();
    } else if (leaveStatus.toLowerCase() == LeaveStatus.cancelled.name) {
      return canceledStatusBtn();
    } else {
      return Container();
    }
  }

  _eventList() => Get.find<LeaveScreenController>().leaveDetailsByDate ==
              null ||
          Get.find<LeaveScreenController>()
              .leaveDetailsByDate!
              .getLeaveRequests!
              .isEmpty
      ? Text(
          AppString.no_event_found_text,
          style: AppStyle.mid_large_text.copyWith(
              fontSize: Dimensions.fontSizeDefault, color: AppColor.hintColor),
        )
      : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: marginLayout,
          itemCount: Get.find<LeaveScreenController>()
              .leaveDetailsByDate
              ?.getLeaveRequests
              ?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                customButtonSheet(
                  context: context,
                  child: LeaveRecordDetails(
                    status: Get.find<LeaveScreenController>()
                            .leaveDetailsByDate
                            ?.getLeaveRequests?[index]
                            .status
                            ?.toLowerCase() ??
                        "",
                    leaveRecords: GetLeaveRecords(
                      files: (Get.find<LeaveScreenController>()
                                      .leaveDetailsByDate
                                      ?.getLeaveRequests?[index]
                                      .files !=
                                  null &&
                              Get.find<LeaveScreenController>()
                                  .leaveDetailsByDate!
                                  .getLeaveRequests![index]
                                  .files!
                                  .isNotEmpty)
                          ? Files(
                              createdAt: Get.find<LeaveScreenController>()
                                      .leaveDetailsByDate
                                      ?.getLeaveRequests?[index]
                                      .files?[0]
                                      .createdAt ??
                                  "",
                              size: Get.find<LeaveScreenController>()
                                      .leaveDetailsByDate
                                      ?.getLeaveRequests?[index]
                                      .files?[0]
                                      .size ??
                                  "",
                              name: Get.find<LeaveScreenController>()
                                      .leaveDetailsByDate
                                      ?.getLeaveRequests?[index]
                                      .files?[0]
                                      .name ??
                                  "",
                              id: Get.find<LeaveScreenController>()
                                      .leaveDetailsByDate
                                      ?.getLeaveRequests?[index]
                                      .files?[0]
                                      .id ??
                                  "",
                              key: Get.find<LeaveScreenController>()
                                      .leaveDetailsByDate
                                      ?.getLeaveRequests?[index]
                                      .files?[0]
                                      .key ??
                                  "",
                            )
                          : Files(),
                      leaveType: LeaveType(
                        type: Get.find<LeaveScreenController>()
                            .leaveDetailsByDate
                            ?.getLeaveRequests?[index]
                            .leaveType
                            ?.type,
                        fileKey: Get.find<LeaveScreenController>()
                                        .leaveDetailsByDate
                                        ?.getLeaveRequests?[index]
                                        .files !=
                                    null &&
                                Get.find<LeaveScreenController>()
                                    .leaveDetailsByDate!
                                    .getLeaveRequests![index]
                                    .files!
                                    .isNotEmpty
                            ? "${Get.find<LeaveScreenController>().leaveDetailsByDate?.getLeaveRequests?[index].files?[0].key}"
                            : "",
                        leaveName: Get.find<LeaveScreenController>()
                            .leaveDetailsByDate
                            ?.getLeaveRequests?[index]
                            .leaveType
                            ?.leaveName,
                        leaveId: Get.find<LeaveScreenController>()
                            .leaveDetailsByDate
                            ?.getLeaveRequests?[index]
                            .leaveType
                            ?.leaveId,
                        isAddNoteRequired: Get.find<LeaveScreenController>()
                            .leaveDetailsByDate
                            ?.getLeaveRequests?[index]
                            .leaveType
                            ?.isAddNoteRequired,
                        isAttachDocumentRequired:
                            Get.find<LeaveScreenController>()
                                .leaveDetailsByDate
                                ?.getLeaveRequests?[index]
                                .leaveType
                                ?.isAttachDocumentRequired,
                      ),
                      description: Get.find<LeaveScreenController>()
                          .leaveDetailsByDate
                          ?.getLeaveRequests?[index]
                          .description,
                      createdAt: Get.find<LeaveScreenController>()
                          .leaveDetailsByDate
                          ?.getLeaveRequests?[index]
                          .createdAt,
                      duration: Get.find<LeaveScreenController>()
                          .leaveDetailsByDate
                          ?.getLeaveRequests?[index]
                          .numberOfDays,
                      status: Get.find<LeaveScreenController>()
                          .leaveDetailsByDate
                          ?.getLeaveRequests?[index]
                          .status,
                      endDate: Get.find<LeaveScreenController>()
                          .leaveDetailsByDate
                          ?.getLeaveRequests?[index]
                          .endDate,
                      startDate: Get.find<LeaveScreenController>()
                          .leaveDetailsByDate
                          ?.getLeaveRequests?[index]
                          .startDate,
                      id: Get.find<LeaveScreenController>()
                          .leaveDetailsByDate
                          ?.getLeaveRequests?[index]
                          .id,
                    ),
                  ),
                  height: 0.6,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: AppLayout.getHeight(70),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(.05),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Get.find<LeaveScreenController>()
                                    .leaveDetailsByDate
                                    ?.getLeaveRequests?[index]
                                    .leaveType
                                    ?.leaveName ??
                                "",
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.mid_large_text.copyWith(
                                color: AppColor.normalTextColor,
                                fontSize: Dimensions.fontSizeDefault + 1,
                                fontWeight: FontWeight.w500),
                          ),
                          Get.find<LeaveScreenController>()
                                      .leaveDetailsByDate
                                      ?.getLeaveRequests?[index]
                                      .numberOfDays !=
                                  null
                              ? Text(
                                  Get.find<LeaveScreenController>()
                                              .leaveDetailsByDate
                                              ?.getLeaveRequests?[index]
                                              .numberOfDays >
                                          1
                                      ? "${Get.find<LeaveScreenController>().leaveDetailsByDate?.getLeaveRequests?[index].numberOfDays} days"
                                      : "${Get.find<LeaveScreenController>().leaveDetailsByDate?.getLeaveRequests?[index].numberOfDays} day",
                                  style: AppStyle.normal_text_black.copyWith(
                                      color: AppColor.hintColor,
                                      fontSize: Dimensions.fontSizeDefault - 1),
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Container(),
                        ],
                      ),
                      _getStatusButton(Get.find<LeaveScreenController>()
                              .leaveDetailsByDate
                              ?.getLeaveRequests?[index]
                              .status ??
                          ""),
                    ],
                  ),
                ),
              ),
            );
          },
        );
}

Widget horizontalCalendarLayout() {
  return GestureDetector(
    onTap: () {
      showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) => Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /// have to provide bool value due to have different method called in same component
                InDatePicker(
                  isFromIndividualLeave: true,
                ),
              ],
            ),
          ),
        ),
      );
    },
    child: Obx(() => Padding(
          padding: marginLayout,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () async {
                        Get.find<LeaveScreenController>().date.value =
                            DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                    Get.find<LeaveScreenController>()
                                        .date
                                        .value)
                                .subtract(const Duration(days: 1)));
                        await Get.find<LeaveScreenController>()
                            .getLeaveDetailsByDate();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.normalTextColor,
                        size: 20,
                      )),
                  Text(
                    DateFormat("dd MMM yyyy").format(DateTime.now()) ==
                            DateFormat("dd MMM yyyy").format(DateTime.parse(
                                Get.find<LeaveScreenController>().date.value))
                        ? "Today"
                        : DateFormat("dd MMM yyyy").format(DateTime.parse(
                            Get.find<LeaveScreenController>().date.value)),
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.normalTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () async {
                        Get.find<LeaveScreenController>().date.value =
                            DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                    Get.find<LeaveScreenController>()
                                        .date
                                        .value)
                                .add(const Duration(days: 1)));
                        await Get.find<LeaveScreenController>()
                            .getLeaveDetailsByDate();
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: AppColor.normalTextColor,
                        size: 20,
                      )),
                ],
              ),
              Center(
                  child: Text(
                DateFormat('EEEE').format(DateTime.parse(
                    Get.find<LeaveScreenController>().date.value)),
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: Dimensions.fontSizeDefault - 1),
              ))
            ],
          ),
        )),
  );
}
