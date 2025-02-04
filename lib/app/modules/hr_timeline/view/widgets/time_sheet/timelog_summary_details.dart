import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/view/widgets/custom_network_image.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/timelog_entries_details.dart';
import 'package:payrun_mobile/common/widget/employee/status_button_helper.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import '../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import '../../../../../../common/controller/convart_color_code_controller.dart';
import '../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../enum.dart';
import '../../../../../../modules/timeline/view/screen/update_timeline.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/utils.dart';
import '../../../../settings/controller/app_setting_controller.dart';
import '../../../controllers/global_timline_controller.dart';
import '../../../controllers/timelog_summary_controller.dart';

class TimeLogSummaryDetails extends GetView<HrTimelineController> {
  final String? leaveId;
  final LogSummaryUserInfo? logSummaryUserInfo;
  const TimeLogSummaryDetails(
      {super.key, this.leaveId, this.logSummaryUserInfo});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isTimeEntryLoading.isTrue ||
            Get.find<HrTimelineController>().isTimeEntryUpdateLoading.isTrue
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
                  imageUrl: logSummaryUserInfo?.imgUrl ?? "",
                  name: logSummaryUserInfo?.name ?? "",
                  details: logSummaryUserInfo?.departmentName ?? ""),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildText(
                    value: "Time entries",
                    color: AppColor.hintColor,
                    textStyle: AppStyle.normal_text_black
                        .copyWith(color: AppColor.hintColor, letterSpacing: 4)),
              ),

              /// Wrapping in Flexible to prevent overflow issues
              Flexible(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 6),
                  itemCount: controller.timeLogsEntriesDetails
                          ?.getTimeLineEntries?.data?.length ??
                      0,
                  itemBuilder: (context, index) {
                    Data? data = controller.timeLogsEntriesDetails
                        ?.getTimeLineEntries?.data?[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.leaveRecordCardColor,
                            borderRadius: BorderRadius.circular(8)),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 14, top: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: _buildText(data: data)),
                                  PopupMenuButton<String>(
                                    position: PopupMenuPosition.under,
                                    shadowColor: Colors.grey.shade100,
                                    onSelected: (value) => _handleMenuSelection(
                                        value, data ?? Data(), context),
                                    shape: roundedRectangleBorder,
                                    color: AppColor.cardColor,
                                    surfaceTintColor: AppColor.cardColor,
                                    icon: const Icon(Icons.more_horiz),
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      _buildMenuItem("Edit"),
                                      if (data?.status != "approved")
                                        _buildMenuItem("Approve"),
                                      if (data?.status != "approved")
                                        if (data?.status != "reject")
                                          _buildMenuItem("Reject"),
                                      _buildMenuItem("View notes"),
                                      _buildMenuItem("Remove"),
                                    ],
                                  ),
                                ],
                              ),
                              _buildText(
                                  value: getConvertSecondsToHours(
                                      data?.loggedTotalSeconds ?? "0"),
                                  color: AppColor.hintColor),
                              _buildText(value: data?.project?.name ?? ""),
                              _buildText(
                                  value: data?.project != null
                                      ? data?.project?.name ?? ""
                                      : data?.task?.name ?? "",
                                  color: AppColor.hintColor),
                              const SizedBox(
                                height: 4,
                              ),

                              /// Removing fixed height
                              SizedBox(
                                width: AppLayout.getWidth(100),
                                child: _showStatusButton(data?.status ?? ""),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ));
  }

  /// Builds a popup menu item with the given value
  PopupMenuItem<String> _buildMenuItem(String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 0,
      padding: const EdgeInsets.only(bottom: 10, top: 10, left: 20),
      child: SizedBox(
          width: 180,
          child: Text(
            value,
            style: AppStyle.normal_text.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeDefault + 1,
            ),
          )),
    );
  }

  /// Handles the selection of a menu item
  void _handleMenuSelection(String value, Data data, BuildContext context) {
    switch (value) {
      case "Edit":
        _edit(data);
        break;
      case "Approve":
        _buildItemOnTab("approved", data.id ?? "");
        break;
      case "Reject":
        _buildItemOnTab("reject", data.id ?? "");
        break;
      case "View notes":
        _viewNotes(data.description ?? "");
        break;
      case "Remove":
        _removeTask(context: context, taskInfo: data);
        break;
    }
  }

  Widget _buildText(
      {String? value, Data? data, Color? color, TextStyle? textStyle}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Text(
        value ?? _getTime(data ?? Data()),
        style: textStyle ??
            AppStyle.normal_text_black
                .copyWith(color: color ?? AppColor.normalTextColor),
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

  /// Builds the header containing profile image, name, and leave details.
  Widget _buildHeader({String? imageUrl, String? name, String? details}) {
    final screenHeight = MediaQuery.of(Get.context!).size.height;

    return Container(
      height: screenHeight / 5.5,
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
          customSpacerHeight(height: 4),
          CircularNetworkImage(
            imageUrl: buildImgIxUrl(imagePath: imageUrl, isPublic: true),
            radius: 30,
            errorText: getInitials(name.toString()),
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

  String _getTime(Data data) {
    final timeZone = Get.find<AppSettingController>()
            .orgSetting
            ?.getOrganizationSetting
            ?.timeZone ??
        "";
    // Format start and end times
    final startTime = formatDateTimeWithZone(
      dateTimeInput: data.startDate ?? "",
      timeZone: timeZone,
      include: DateTimePart.time,
    );
    final endTime = data.endDate == null
        ? "Ongoing"
        : formatDateTimeWithZone(
            dateTimeInput: data.endDate ?? "",
            timeZone: timeZone,
            include: DateTimePart.time,
          );
    // Determine if start and end dates are the same
    return "$startTime - $endTime";
  }

  void _edit(Data data) {
    Get.find<TimelineGlobalController>().timeLineId(data.id ?? "");
    Get.find<TimelineGlobalController>().projectId(data.project?.id ?? "");
    Get.find<TimelineGlobalController>().orgUserId(data.orgUserId ?? "");
    Get.find<TimelineGlobalController>().status(data.status ?? "");
    Get.find<TimelineGlobalController>().taskId(data.task?.id ?? "");
    Get.find<TimelineGlobalController>()
        .projectColor(data.project?.color ?? "");
    Get.find<TimelineGlobalController>().taskName(data.task?.name ?? "");
    Get.find<TimelineGlobalController>().descriptionController.text =
        data.description ?? "";

    Get.to(() => UpdateTimeLineLog(
          projectOrTaskColor: data.task?.id?.isNotEmpty ?? false
              ? HexColor(data.task?.project?.color ?? "")
              : AppColor.primaryColor,
          endDateTime: data.endDate ?? "",
          startDateTime: data.startDate ?? "",
          status: data.status ?? "",
          logSummaryUserInfo: logSummaryUserInfo,
        ));
  }

  void _buildItemOnTab(String status, String timelineId) {
    Get.find<HrTimelineController>()
        .updateTimeLogEntryById(status: status, timelineId: timelineId);
  }

  void _viewNotes(String note) {
    showCustomBottomSheet(
      context: Get.context!,
      height: MediaQuery.of(Get.context!).size.height / 1.5,
      child: _viewNote(note),
    );
  }

  _viewNote(String note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header with employee details
        _buildHeader(
          imageUrl: logSummaryUserInfo?.imgUrl ?? "",
          name: logSummaryUserInfo?.name ?? "",
          details: logSummaryUserInfo?.departmentName ?? "",
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText(
                value: "Employee note",
                color: AppColor.hintColor,
                textStyle: AppStyle.normal_text_black.copyWith(
                  color: AppColor.hintColor,
                  letterSpacing: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      note.isNotEmpty ? note : "No notes available!",
                      style: AppStyle.normal_text_black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _removeTask({required BuildContext context, required Data taskInfo}) {
    showCustomAlertDialog(
        context: context,
        onConfirm: () async {
          await Get.find<TimelineGlobalController>().removeTimelineEntry(
              timeLogId: taskInfo.id, orgId: taskInfo.orgUserId);
          Get.back(canPop: false);
          Get.back(canPop: false);
          Get.find<TimelineSummaryController>()
              .getTimelineSummaryByDate(orgId: taskInfo.orgUserId);
          Get.find<TimelineSummaryController>()
              .getTimelogDetailsByMonth(orgId: taskInfo.orgUserId);
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
}

class LogSummaryUserInfo {
  String? name;
  String? departmentName;
  String? imgUrl;
  LogSummaryUserInfo({this.name, this.departmentName, this.imgUrl});
}
