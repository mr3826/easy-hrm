import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_records.dart';
import 'package:payrun_mobile/modules/leave/view/widget/single_date_picker_calendar.dart';
import 'package:payrun_mobile/modules/leave/view/widget/status_btn_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

import '../../controller/calendar_date_controller.dart';
import 'leave_record_details_view.dart';

class IndividualEventView extends StatelessWidget {
  const IndividualEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customSpacerHeight(height: 5),
        Obx(
          () => _dateCalendarLayout(),
        ),
        customSpacerHeight(height: 8),
        _eventText(),
        Obx(() => _eventViewLayout()),
        customSpacerHeight(height: 100),
      ],
    );
  }

  _dateCalendarLayout() {
    var controller = Get.find<DateController>();

    return GestureDetector(
      onTap: () {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return const Dialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                insetPadding: EdgeInsets.zero,
                child: SingleDatePicker());
          },
        );
      },
      child: Padding(
        padding: marginLayout,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () async {
                      controller.decrementDate();
                      await Get.find<LeaveScreenController>()
                          .getLeaveDetailsByDate();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.normalTextColor,
                      size: 20,
                    )),
                Text(
                  controller.getFormattedDate() ==
                          controller.getFormattedCurrentData()
                      ? AppString.text_today
                      : controller.getFormattedDate(),
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.normalTextColor,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () async {
                      controller.incrementMonth();
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
              controller.getOnlyDay().toString(),
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 1),
            ))
          ],
        ),
      ),
    );
  }

  _eventText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customSpacerHeight(height: 50),
        Container(
          height: 1,
          width: 140,
          color: AppColor.disableColor,
        ),
        Padding(
          padding: marginLayout,
          child: Text(
            AppString.text_event.tr,
            style:
                AppStyle.normal_text_black.copyWith(color: AppColor.hintColor),
          ),
        ),
        Container(
          height: 1,
          width: 140,
          color: AppColor.disableColor,
        ),
      ],
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

  _eventList() =>
      Get.find<LeaveScreenController>().leaveDetailsByDate == null ||
              Get.find<LeaveScreenController>()
                  .leaveDetailsByDate!
                  .getLeaveDetailsByDate!
                  .isEmpty
          ? Text(
              AppString.no_event_found_text,
              style: AppStyle.mid_large_text.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: AppColor.hintColor),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: marginLayout,
              itemCount: Get.find<LeaveScreenController>()
                  .leaveDetailsByDate
                  ?.getLeaveDetailsByDate?[0]
                  .leaveRequests
                  ?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    customButtonSheet(
                      context: context,
                      child: LeaveRecordDetails(
                        status: Get.find<LeaveScreenController>()
                                .leaveDetailsByDate
                                ?.getLeaveDetailsByDate![0]
                                .leaveRequests?[index]
                                .status
                                ?.toLowerCase() ??
                            "",
                        leaveRecords: Get.find<LeaveScreenController>()
                            .leaveDetailsByDate
                            ?.getLeaveDetailsByDate?[0]
                            .leaveRequests?[index],
                      ),
                      height: 0.6,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Card(
                      elevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Get.find<LeaveScreenController>()
                                        .leaveDetailsByDate
                                        ?.getLeaveDetailsByDate![0]
                                        .leaveRequests?[index]
                                        .leaveType
                                        ?.type ??
                                    "",
                                style: AppStyle.mid_large_text.copyWith(
                                    color: AppColor.normalTextColor,
                                    fontSize: Dimensions.fontSizeDefault + 1,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                Get.find<LeaveScreenController>()
                                        .leaveDetailsByDate
                                        ?.getLeaveDetailsByDate![0]
                                        .leaveRequests?[index]
                                        .duration
                                        .toString() ??
                                    "",
                                style: AppStyle.normal_text_black.copyWith(
                                    color: AppColor.hintColor,
                                    fontSize: Dimensions.fontSizeDefault - 1),
                              )
                            ],
                          ),
                          _getStatusButton(Get.find<LeaveScreenController>()
                                  .leaveDetailsByDate
                                  ?.getLeaveDetailsByDate?[0]
                                  .leaveRequests?[index]
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
