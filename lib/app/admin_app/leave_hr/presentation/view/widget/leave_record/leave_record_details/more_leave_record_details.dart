import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/controller/leave_controller.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/model/leave_details_by_id.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/view/widget/leave_record/leave_record_details/see_documents/see_document_details.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../common/widget/custom_app_button.dart';
import '../../../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import '../../../../../../../../utils/images.dart';
import '../../../../../../../../utils/utils.dart';
import '../../../../controller/hr_leave_controller.dart';
import 'edit_leave_record/edit_leave_record_details.dart';



/// A widget that displays detailed information for a specific leave record,
/// including options to approve, reject, edit, and view attached documents.
/// The actions displayed depend on the leave record's status.
///
class MoreLeaveRecordDetails extends GetView<HrLeaveController> {
  final String? leaveId;
  const MoreLeaveRecordDetails({super.key, this.leaveId});

  @override
  Widget build(BuildContext context) {
    var leaveController = Get.put(LeaveController());
    return Obx(() => controller.isHrLeaveDetailsByLoading.isTrue
        ? const Center(
            child: CupertinoActivityIndicator(
            radius: 15,
            color: AppColor.primaryColor,
          ))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header with employee details
              _buildHeader(
                imageUrl: controller.leaveDetailsById?.getLeaveDetailsById
                    ?.organizationUser?.profile?.image,
                name:
                    "${controller.leaveDetailsById?.getLeaveDetailsById?.organizationUser?.profile?.firstName ?? "No added yet"} "
                    "${controller.leaveDetailsById?.getLeaveDetailsById?.organizationUser?.profile?.lastName ?? ""}",
                details:
                    "${controller.leaveDetailsById?.getLeaveDetailsById?.leaveType?.name ?? ""}: ${controller.leaveDetailsById?.getLeaveDetailsById?.leaveType?.type} - ${"${DateFormat("dd MMM yy").format(DateTime.parse(controller.leaveDetailsById?.getLeaveDetailsById?.startDate ?? ""))} - ${DateFormat("dd MMM yy").format(DateTime.parse(controller.leaveDetailsById?.getLeaveDetailsById?.endDate ?? ""))}"}",
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Conditional actions based on application status
                      if (controller.leaveDetailsById?.getLeaveDetailsById
                                  ?.status ==
                              LeaveStatus.pending.name ||
                          controller.leaveDetailsById?.getLeaveDetailsById
                                  ?.status ==
                              LeaveStatus.approved.name) ...[
                        if (controller.leaveDetailsById?.getLeaveDetailsById
                                ?.status ==
                            LeaveStatus.pending.name) ...[
                          Obx(
                            () => Get.find<HrLeaveController>()
                                    .updateLeaveLoader
                                    .isTrue
                                ? const Center(
                                    child: CupertinoActivityIndicator())
                                : _buildActionOption(AppString.textApprove.tr,
                                    () {
                                    Get.find<HrLeaveController>().updateLeave(
                                        leaveId: leaveId ?? "",
                                        status: "approved");
                                  }),
                          ),
                          _divider(),
                        ],
                        _buildCancel(context, leaveId),

                        ///reject || cancel build action
                        _divider(),
                        if (controller.leaveDetailsById?.getLeaveDetailsById
                                ?.status ==
                            LeaveStatus.pending.name) ...[
                          _buildActionOption(AppString.text_edit.tr, () {
                            _showEditLeaveDetails();
                          }),
                          _divider(),
                        ],
                      ],
                      _buildActionOption(
                          AppString.textSeeDocument.tr, _showBuildAttachedFile),

                      _divider(),

                      _buildActionOption(AppString.textViewLeaveRecord.tr, () {
                        controller.getLeaveRecord(
                            startDate: controller.leaveDetailsById
                                ?.getLeaveDetailsById?.startDate,
                            endDate: controller
                                .leaveDetailsById?.getLeaveDetailsById?.endDate,
                            assignedLeaveId: controller.leaveDetailsById
                                ?.getLeaveDetailsById?.organizationUser?.id);
                        leaveController.tabLength(1);
                        Get.back(canPop: false);
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ));
  }

  /// Builds an action button for various leave options like Approve, Reject, Edit.
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

  /// Creates a divider to separate action options visually.
  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Divider(color: AppColor.normalTextColor.withOpacity(0.1)),
    );
  }

  /// Builds the header containing profile image, name, and leave details.
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

  /// Displays a sheet with attached files for viewing.
  void _showBuildAttachedFile() {
    customAntButtonSheet(
      context: Get.context!,
      height: MediaQuery.of(Get.context!).size.height / 1.5,
      child: const SeeDocumentDetails(),
    );
  }

  /// Builds a cancel action based on the leave status and displays
  /// appropriate cancel or reject options.
  Widget _buildCancel(BuildContext context, leaveId) {
    var status = controller.leaveDetailsById?.getLeaveDetailsById?.status;
    if (status == LeaveStatus.taken.name ||
        status == LeaveStatus.reject.name ||
        status == LeaveStatus.rejected.name ||
        status == LeaveStatus.cancelled.name ||
        status == LeaveStatus.cancel.name) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (status == LeaveStatus.approved.name)
          _buildActionCancel(context, leaveId),
        if (status != LeaveStatus.approved.name)
          _buildActionOption(AppString.textReject.tr, () {
            showRejectDialog(
                context,
                controller.leaveDetailsById?.getLeaveDetailsById?.leaveDetails
                        ?.first.date ??
                    "",
                leaveId: leaveId);
          }),
      ],
    );
  }

  /// Builds a cancel option for approved leaves.
  Widget _buildActionCancel(BuildContext context, String leaveId) {
    return _buildActionOption(AppString.text_cancel.tr, () {
      showRejectDialog(
          context,
          controller.leaveDetailsById?.getLeaveDetailsById?.leaveDetails?.first
                  .date ??
              "",
          leaveId: leaveId);
    });
  }

  /// Shows a sheet to edit leave details.
  void _showEditLeaveDetails() {
    _updateDateFromResponse();
    customAntButtonSheet(
      context: Get.context!,
      height: MediaQuery.of(Get.context!).size.height / 1.2,
      child:   EditLeaveRecordDetails(getLeaveDetailsById:GetLeaveDetailsById(files: controller.leaveDetailsById?.getLeaveDetailsById?.files??[])),
    );
  }

  void _updateDateFromResponse() {

    controller.getAvailableLeaveType();
    controller.selectedEmployeeImgKey.value =  controller.leaveDetailsById?.getLeaveDetailsById?.organizationUser?.profile?.image ?? "";
    controller.selectedEmployeeInfo.value =  "${controller.leaveDetailsById?.getLeaveDetailsById?.organizationUser?.profile?.firstName ?? "No added yet"} ""${controller.leaveDetailsById?.getLeaveDetailsById?.organizationUser?.profile?.lastName ?? ""}";
    controller.leaveTypeId = controller.leaveDetailsById?.getLeaveDetailsById?.leaveType?.id ?? "";
    controller.leaveId = controller.leaveDetailsById?.getLeaveDetailsById?.leaveDetails?.first.leaveId ?? "";
    controller.calculateAllowanceOfLeave.value=controller.leaveDetailsById?.getLeaveDetailsById?.leaveType?.calculateAllowanceBy.toString()??"";


    if( controller.leaveDetailsById!.getLeaveDetailsById!.files!.isNotEmpty ){
      controller.fileName =controller.leaveDetailsById?.getLeaveDetailsById?.files?.first.name??"";
      controller.fileKey =controller.leaveDetailsById?.getLeaveDetailsById?.files?.first.key??"";
      controller.fileId = controller.leaveDetailsById?.getLeaveDetailsById?.files?.first.id??"";
      controller.fileSize = controller.leaveDetailsById?.getLeaveDetailsById?.files?.first.size.toString()??"";
    }



    Get.find<LeaveController>().selectedStatusIndex.value = controller.leaveDetailsById?.getLeaveDetailsById?.status == "pending" ? 0 : 1;

    Get.find<DateTimePickerController>().inTime.value = DateFormat('HH:mm').format(DateTime.parse(controller.leaveDetailsById?.getLeaveDetailsById?.startDate ?? DateTime.now().toString()));
    Get.find<DateTimePickerController>().inDate.value = DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.leaveDetailsById?.getLeaveDetailsById?.startDate ?? DateTime.now().toString()));

    Get.find<DateTimePickerController>().outTime.value = DateFormat('HH:mm').format(DateTime.parse(controller.leaveDetailsById?.getLeaveDetailsById?.endDate ?? DateTime.now().toString()));
    Get.find<DateTimePickerController>().outDate.value = DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.leaveDetailsById?.getLeaveDetailsById?.endDate ?? DateTime.now().toString()));

    leaveNoteController.text = controller.leaveDetailsById?.getLeaveDetailsById?.description ?? "";

    Get.find<DateTimePickerController>().getInDateTime();
    Get.find<DateTimePickerController>().getOutDateTime();


  }
}




/// Shows a rejection dialog with custom alert and actions.
void showRejectDialog(BuildContext context, String leaveData,
    {required String leaveId}) {
  showCustomAlertDialog(
    context: context,
    onConfirm: () {}, //optional action
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
    actionButtonWidget: Obx(() =>
        Get.find<HrLeaveController>().updateLeaveLoader.isTrue
            ? const Center(child: CupertinoActivityIndicator())
            : _buildDialogActions(leaveId)),
  );
}

/// Builds a dialog action row with cancel and confirm buttons.
/// - The cancel button is styled with a close icon and a hint color,
///   allowing the user to close the dialog without taking action.
/// - The confirm button includes a done icon and an error color,
///   performing a specific action on press.
///
/// Returns:
///   A `SizedBox` containing a `Row` of action buttons, styled and
///   spaced appropriately for use in dialogs.
Widget _buildDialogActions(String leaveId) {
  return SizedBox(
    height: 40,
    child: Row(
      children: [
        // Cancel Button
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
          onPressed: () => Get.back(), // Closes the dialog on press
          buttonColor: AppColor.cardColor,
          borderColor: AppColor.hintColor.withOpacity(0.6),
          textColor: AppColor.hintColor,
          borderRadius: Dimensions.radiusDefault,
        ),

        // Spacer between buttons
        customSpacerWidth(width: 20),

        // Confirm Button
        CustomAppButton(
          buttonText: Row(
            children: [
              const Icon(Icons.done, color: AppColor.cardColor),
              customSpacerWidth(width: 8),
              Expanded(
                child: Text(
                  AppString.text_confirm.tr,
                  style: AppStyle.normal_text.copyWith(
                    color: AppColor.cardColor,
                    fontSize: Dimensions.fontSizeDefault + 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            Get.find<HrLeaveController>()
                .updateLeave(leaveId: leaveId, status: "rejected");
            Get.back(canPop: false);
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
