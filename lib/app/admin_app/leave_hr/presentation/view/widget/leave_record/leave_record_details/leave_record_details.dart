import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../common/widget/custom_text_field.dart';
import '../../../../../../../../common/widget/employee/status_button_helper.dart';
import '../../../../../../../../enum.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import '../../../../../../../../utils/utils.dart';
import '../../../../controller/hr_leave_controller.dart';
import 'leave_details_button.dart';

class LeaveRecordDetails extends GetView<HrLeaveController> {
  final String? leaveId;
  const LeaveRecordDetails({super.key, required this.leaveId});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isHrLeaveDetailsByLoading.isTrue
        ? const Center(
            child: CupertinoActivityIndicator(
            radius: 15,
            color: AppColor.primaryColor,
          ))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                  imgUrl: controller.leaveDetailsById?.getLeaveDetailsById
                          ?.organizationUser?.profile?.image ??
                      "",
                  employeeName:
                      "${controller.leaveDetailsById?.getLeaveDetailsById?.organizationUser?.profile?.firstName ?? "No added yet"} "
                      "${controller.leaveDetailsById?.getLeaveDetailsById?.organizationUser?.profile?.lastName ?? ""}",
                  designation: controller.leaveDetailsById?.getLeaveDetailsById
                      ?.organizationUser?.designation
                      .toString()),
              customSpacerHeight(height: 12),
              _buildRow(
                label: AppString.textType.tr,
                value: controller.leaveDetailsById?.getLeaveDetailsById
                        ?.leaveType?.name ??
                    "",
              ),
              _buildRow(
                label: AppString.text_date.tr,
                value: controller.leaveDetailsById?.getLeaveDetailsById
                        ?.leaveDetails?.first.date ??
                    "",
              ),
              _buildRow(
                label: AppString.text_duration.tr,
                value: getLeaveDuration(
                    controller.leaveDetailsById?.getLeaveDetailsById
                            ?.leaveDetails?.first.leaveSeconds
                            ?.toString() ??
                        "",
                    controller
                            .leaveDetailsById?.getLeaveDetailsById?.numberOfDays
                            ?.toString() ??
                        ""),
              ),
              _buildRow(
                  label: AppString.text_status.tr,
                  widget: _showStatusButton(controller
                          .leaveDetailsById?.getLeaveDetailsById?.status ??
                      "")),
              _buildRow(
                  label: AppString.text_date_of_application.tr,
                  value: formatDate(
                      date: controller.leaveDetailsById?.getLeaveDetailsById
                              ?.createdAt ??
                          "",
                      format: "dd MMMM yyyy")),
              _buildActionButtons(
                  leaveId: leaveId.toString(),
                  leaveDate: controller.leaveDetailsById?.getLeaveDetailsById
                          ?.leaveDetails?.first.date ??
                      "",
                  status: controller
                          .leaveDetailsById?.getLeaveDetailsById?.status ??
                      ""),
            ],
          ));
  }

  Widget _buildRow({required String label, String? value, Widget? widget}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style:
                AppStyle.normal_text_black.copyWith(color: AppColor.hintColor),
          ),
          widget ?? Text(value ?? "", style: AppStyle.normal_text_black),
        ],
      ),
    );
  }

  ///Status according to details button
  Widget _buildActionButtons(
      {required String status,
      required String leaveId,
      required String leaveDate}) {
    if (status == LeaveStatus.pending.name) {
      return buildPendingBtn(leaveId: leaveId, leaveDate: leaveDate);
    } else if (status == LeaveStatus.approved.name) {
      return buildApprovedBtn(leaveId: leaveId, leaveDate: leaveDate);
    } else {
      return const SizedBox.shrink();
    }
  }

  ///Button sheet header
  Widget _buildHeader(
      {String? imgUrl, String? employeeName, String? designation}) {
    final screenHeight = MediaQuery.of(Get.context!).size.height;
    return Container(
      height: screenHeight / 5,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.bgColorWithTimeline,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 4, width: 120, color: AppColor.backgroundColor),
          ),
          customSpacerHeight(height: 12),
          CustomNetworkImage(
            profileImageKey: imgUrl,
            imgUrlKey: "",
            errorText: "ER",
          ),
          customSpacerHeight(height: 12),
          Text(
            employeeName ?? "",
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.fontSizeDefault + 2,
            ),
          ),
          Text(
            (designation == null || designation == "null")
                ? "No designation"
                : designation,
            style: subTextFieldTitleStyle.copyWith(
              color: AppColor.hintColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showStatusButton(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return StatusBtnHelper.approvedStatusBtn();
      case 'rejected':
        return StatusBtnHelper.rejectedStatusBtn();
      case 'pending':
        return StatusBtnHelper.pendingStatusBtn();
      case 'taken':
        return StatusBtnHelper.tokenStatusBtn();
      case 'cancelled':
        return StatusBtnHelper.cancelledStatusBtn();
      case 'cancel':
        return StatusBtnHelper.cancelStatusBtn();
      default:
        return Container();
    }
  }
}

class LeaveRecordDetailsModel {
  final String? employeeName;
  final String? leaveId;
  final String? typeOfLeave;
  final String? leaveStatus;
  final String? leaveDate;
  final String? leaveDuration;
  final String? applicationStatus;
  final String? applicationDate;
  final String? imgUrl;
  final String? designation;

  LeaveRecordDetailsModel({
    this.employeeName,
    this.typeOfLeave,
    this.leaveStatus,
    this.leaveDate,
    this.leaveDuration,
    this.leaveId,
    this.applicationStatus,
    this.applicationDate,
    this.imgUrl,
    this.designation,
  });
}
