import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/controller/leave_controller.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/view/widget/leave_recorde/leave_recorde_details%20/see_document_details.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../common/widget/custom_app_button.dart';
import '../../../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import '../../../../../../../../utils/images.dart';
import 'edit_leave_record/edit_leave_record_details.dart';
import 'leave_record_details.dart';

class MoreLeaveRecordDetails extends StatelessWidget {
  final LeaveRecordDetailsModel leaveRecordDetails;

  const MoreLeaveRecordDetails({super.key, required this.leaveRecordDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          imageUrl: leaveRecordDetails.imgUrl,
          name: leaveRecordDetails.employeeName,
          details:
              "${leaveRecordDetails.typeOfLeave}: ${leaveRecordDetails.leaveStatus} - ${leaveRecordDetails.leaveDate}",
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leaveRecordDetails.applicationStatus ==
                    LeaveStatus.pending.name) ...[
                  _buildActionOption(AppString.textApprove.tr, () {}),
                  _divider(),
                  _buildCancel(context),
                  _divider(),
                  _buildActionOption(AppString.text_edit.tr, () {
                    _showEditLeaveDetails(leaveRecordDetails);
                  }),
                  _divider(),
                ],
                _buildActionOption(
                    AppString.textSeeDocument.tr, _showBuildAttachedFile),
                _divider(),
                _buildActionOption(AppString.textViewLeaveRecord.tr, () {
                  Get.find<LeaveController>().isFilterIndividual(true);
                  Get.back(canPop: false);
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionOption(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColor.cardColor,
        width: double.infinity,
        height: 54,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          text,
          style: AppStyle.normal_text_black.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.8),
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Divider(color: AppColor.normalTextColor.withOpacity(0.1)),
    );
  }

  Widget _buildHeader({String? imageUrl, String? name, String? details}) {
    final screenHeight = MediaQuery.of(Get.context!).size.height;

    return Container(
      height: screenHeight / 5,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.bgColorWithTimeline,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
            profileImageKey: imageUrl,
            imgUrlKey: "",
            errorText: "ER",
          ),
          customSpacerHeight(height: 12),
          Text(
            name ?? "",
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.fontSizeDefault + 2,
            ),
          ),
          Text(
            details ?? "",
            style: AppStyle.small_text_black.copyWith(
              color: AppColor.hintColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showBuildAttachedFile() {
    customAntButtonSheet(
      context: Get.context!,
      height: MediaQuery.of(Get.context!).size.height / 1.5,
      child: const SeeDocumentDetails(),
    );
  }

  Widget _buildCancel(BuildContext context) {
    if (leaveRecordDetails.applicationStatus == LeaveStatus.taken.name ||
        leaveRecordDetails.applicationStatus == LeaveStatus.reject.name ||
        leaveRecordDetails.applicationStatus == LeaveStatus.rejected.name ||
        leaveRecordDetails.applicationStatus == LeaveStatus.cancelled.name ||
        leaveRecordDetails.applicationStatus == LeaveStatus.cancel.name) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (leaveRecordDetails.applicationStatus == LeaveStatus.approved.name)
          _buildActionCancel(context),
        if (leaveRecordDetails.applicationStatus != LeaveStatus.approved.name)
          _buildActionOption(AppString.textReject.tr, () {
            showRejectDialog(context, leaveRecordDetails.leaveDate.toString());
          }),
      ],
    );
  }

  Widget _buildActionCancel(BuildContext context) {
    return _buildActionOption(AppString.text_cancel.tr, () {
      showRejectDialog(context, leaveRecordDetails.leaveDate.toString());
    });
  }

  void _showEditLeaveDetails(LeaveRecordDetailsModel leaveRecordDetailsModel) {
    customAntButtonSheet(
        context: Get.context!,
        height: MediaQuery.of(Get.context!).size.height / 1.2,
        child: EditLeaveRecordDetails(
          leaveRecordDetailsModel: LeaveRecordDetailsModel(
              applicationDate: leaveRecordDetailsModel.leaveStatus,
              applicationStatus: leaveRecordDetailsModel.applicationStatus,
              employeeName: leaveRecordDetailsModel.employeeName,
              leaveDate: leaveRecordDetailsModel.leaveDate,
              leaveDuration: leaveRecordDetailsModel.leaveDuration,
              typeOfLeave: leaveRecordDetailsModel.typeOfLeave,
              leaveStatus: leaveRecordDetailsModel.leaveStatus,
              designation: leaveRecordDetailsModel.designation,
              imgUrl: leaveRecordDetailsModel.imgUrl),
        ));
  }
}

void showRejectDialog(BuildContext context, String leaveData) {
  showCustomAlertDialog(
    context: context,
    onConfirm: () {},
    confirmButtonChild: Text(
      AppString.confirmText.tr,
      style: AppStyle.normal_text_grey.copyWith(
        fontSize: Dimensions.fontSizeDefault + 1,
        color: AppColor.cardColor,
      ),
    ),
    iconWidget: customSvgImage(
      imageUrl: Images.rejectLeave,
      height: 60,
      width: 60,
    ),
    titleContent: Column(
      children: [
        Text(
          AppString.textRejectLeaveRequestDated.tr,
          textAlign: TextAlign.center,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeMid - 2,
          ),
        ),
        Text(
          leaveData,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.fontSizeMid - 4,
          ),
        ),
      ],
    ),
    descriptionContent: Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          AppString.textThisWillRejectTheSelectedLeaveEtc.tr,
          textAlign: TextAlign.center,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault - 3,
          ),
        ),
      ),
    ),
    iconBackgroundColor: AppColor.cardColor,
    confirmButtonColor: AppColor.errorColor,
    confirmButtonText: AppString.confirmText.tr,
    actionButtonWidget: _buildDialogActions(),
  );
}

Widget _buildDialogActions() {
  return SizedBox(
    height: 40,
    child: Row(
      children: [
        CustomAppButton(
          buttonText: Row(
            children: [
              const Icon(Icons.close, color: AppColor.hintColor),
              customSpacerWidth(width: 8),
              Text(
                AppString.text_cancel.tr,
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault + 1,
                ),
              ),
            ],
          ),
          onPressed: () => Get.back(),
          buttonColor: AppColor.cardColor,
          borderColor: AppColor.hintColor.withOpacity(0.6),
          textColor: AppColor.hintColor,
          borderRadius: Dimensions.radiusDefault,
        ),
        customSpacerWidth(width: 20),
        CustomAppButton(
          buttonText: Row(
            children: [
              const Icon(Icons.done, color: AppColor.cardColor),
              customSpacerWidth(width: 8),
              Text(
                AppString.text_confirm.tr,
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.cardColor,
                  fontSize: Dimensions.fontSizeDefault + 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          onPressed: () {
            print(DateTime.now());
          },
          buttonColor: AppColor.errorColorLight,
          borderColor: AppColor.errorColorLight.withOpacity(0.6),
          textColor: AppColor.errorColorLight,
          borderRadius: Dimensions.radiusDefault,
        ),
      ],
    ),
  );
}
