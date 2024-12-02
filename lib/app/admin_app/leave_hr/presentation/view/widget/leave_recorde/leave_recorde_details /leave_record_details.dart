import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../../common/widget/custom_text_field.dart';
import '../../../../../../../../common/widget/employee/status_button_helper.dart';
import '../../../../../../../../enum.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import '../../../../../../../../utils/images.dart';
import '../../../../../../../../utils/utils.dart';
import 'more_leave_record_details.dart';

class LeaveRecordDetails extends StatelessWidget {
  final LeaveRecordDetailsModel leaveRecordDetailsModel;

  const LeaveRecordDetails({super.key, required this.leaveRecordDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          imgUrl: leaveRecordDetailsModel.imgUrl,
          employeeName: leaveRecordDetailsModel.employeeName,
          designation: leaveRecordDetailsModel.designation,
        ),
        customSpacerHeight(height: 12),
        _buildRow(
            label: AppString.textType.tr,
            value: leaveRecordDetailsModel.typeOfLeave),
        _buildRow(
            label: AppString.text_date.tr,
            value: leaveRecordDetailsModel.leaveDate),
        _buildRow(
            label: AppString.text_duration.tr,
            value: leaveRecordDetailsModel.leaveDuration),
        _buildRow(
            label: AppString.text_status.tr,
            widget: _showStatusButton(
                leaveRecordDetailsModel.applicationStatus ?? "")),
        _buildRow(
            label: AppString.text_date_of_application.tr,
            value: formatDate(
                date: leaveRecordDetailsModel.applicationDate.toString(),
                format: "dd MMMM yyyy")),
        _buildActionButtons(leaveRecordDetailsModel.applicationStatus),
      ],
    );
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

  Widget _buildActionButtons(status) {
    if (leaveRecordDetailsModel.applicationStatus == LeaveStatus.pending.name) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CustomAppButton(
              buttonText: Text(
                AppString.textReject.tr,
                style: TextStyle(
                    color: AppColor.errorColor,
                    fontSize: Dimensions.fontSizeDefault),
              ),
              onPressed: () {
                showRejectDialog(
                    Get.context!, leaveRecordDetailsModel.leaveDate.toString());
              },
              buttonColor: AppColor.cardColor,
              borderColor: AppColor.errorColor,
              textColor: AppColor.errorColor,
              borderRadius: Dimensions.radiusLarge,
            ),
            customSpacerWidth(width: 20),
            CustomAppButton(
              buttonText: Text(
                AppString.text_approved.tr,
                style: TextStyle(
                    color: AppColor.cardColor,
                    fontSize: Dimensions.fontSizeDefault + 1),
              ),
              onPressed: () {},
              buttonColor: AppColor.successColor,
              borderColor: AppColor.successColor,
              textColor: AppColor.cardColor,
              borderRadius: Dimensions.radiusLarge,
            ),
          ],
        ),
      );
    } else if (leaveRecordDetailsModel.applicationStatus ==
        LeaveStatus.approved.name) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomAppButton(
          buttonText: Text(
            AppString.text_cancel.tr,
            style: TextStyle(
                color: AppColor.cardColor,
                fontSize: Dimensions.fontSizeDefault + 1),
          ),
          onPressed: () {
            showCustomAlertDialog(
              context: Get.context!,
              onConfirm: () {},
              confirmButtonChild: Text(
                AppString.confirmText.tr,
                style: AppStyle.normal_text_grey.copyWith(
                    fontSize: Dimensions.fontSizeDefault + 1,
                    color: AppColor.cardColor),
              ),
              extraInfoText: "",
              iconWidget: customSvgImage(
                  imageUrl: Images.cancelLeave, height: 60, width: 60),
              titleText: AppString.cancelLeaveText.tr,
              descriptionText: AppString.cancelLeaveNotificationText.tr,
              iconBackgroundColor: AppColor.cardColor,
              confirmButtonColor: AppColor.hintColor,
              confirmButtonText: AppString.confirmText.tr,
            );
          },
          buttonColor: AppColor.hintColor,
          borderColor: AppColor.hintColor,
          textColor: AppColor.cardColor,
          borderRadius: Dimensions.radiusLarge,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

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
            designation ?? "",
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
