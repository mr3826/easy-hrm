import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/model/leave_summary.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import '../../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_string.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import '../../../../../auth/presentation/view/otp_screen.dart';
import 'leave_allowance/leave_allowance.dart';

class BuildProfileLeaveSummary extends GetView<UserProfileController> {
  const BuildProfileLeaveSummary({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isViewLeaveSummaryLoading.isTrue) {
        return const LoadingIndicator(
          radius: 18,
        );
      }
      if (controller.leaveSummary?.getOrganizationUsersLeaveSummary == null ||
          controller.leaveSummary!.getOrganizationUsersLeaveSummary!.isEmpty) {
        return Center(
            child: Text(
          "No leave summary!",
          style: AppStyle.normal_text_black.copyWith(color: AppColor.hintColor),
        ));
      }
      return Padding(
        padding: marginLayout.copyWith(top: 20),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller
                  .leaveSummary?.getOrganizationUsersLeaveSummary?.length ??
              0,
          itemBuilder: (context, index) {
            GetOrganizationUsersLeaveSummary? leaveSummary = controller
                .leaveSummary?.getOrganizationUsersLeaveSummary?[index];

            return SizedBox(
              height: AppLayout.getHeight(175),
              width: double.infinity,
              child: Card(
                elevation: 0,
                color: AppColor.leaveRecordCardColor,
                shape: roundedRectangleBorder.copyWith(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(leaveSummary ?? GetOrganizationUsersLeaveSummary()),
                      customSpacerHeight(height: 12),
                      _buildLeaveDetailsRow(
                          staticText1: "Allowance: ",
                          dynamicText1:
                              leaveSummary?.allocated.toString() ?? "",
                          staticText2: "Earned: ",
                          dynamicText2:
                              leaveSummary?.earnedDays.toString() ?? "",
                          staticText3: "Taken: ",
                          dynamicText3: leaveSummary?.taken ?? "0"),
                      customSpacerHeight(height: 8),
                      _buildLeaveDetailsRow(
                          staticText1: "Approved: ",
                          dynamicText1: leaveSummary?.approved.toString() ?? "",
                          staticText2: "Available: ",
                          dynamicText2: _getAvailable(leaveSummary)),
                      customSpacerHeight(height: 8),
                      _buildPendingRequest(leaveSummary ?? GetOrganizationUsersLeaveSummary()),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  // Build header with title and more button
  Widget _buildHeader(GetOrganizationUsersLeaveSummary leaveSummary) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leaveSummary.name ?? "",
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.secondaryColor,
                fontSize: Dimensions.fontSizeDefault,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              leaveSummary.type ?? "",
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeSmall + 1,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            showAddAllowance();
          },
          icon: Icon(
            Icons.more_horiz,
            size: 25,
            color: AppColor.normalTextColor.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  // Build a row with multiple subtexts for leave details
  Widget _buildLeaveDetailsRow(
      {required String staticText1,
      required String dynamicText1,
      String? staticText2,
      String? dynamicText2,
      String? staticText3,
      String? dynamicText3}) {
    return Row(
      children: [
        _buildSubText(label: staticText1, value: dynamicText1),
        if (staticText2 != null) ...[
          customSpacerWidth(width: 20),
          _buildSubText(label: staticText2, value: dynamicText2 ?? "-"),
        ],
        if (staticText3 != null) ...[
          customSpacerWidth(width: 20),
          _buildSubText(label: staticText3, value: dynamicText3 ?? "-"),
        ],
      ],
    );
  }

  // Build the pending request widget
  Widget _buildPendingRequest(GetOrganizationUsersLeaveSummary leaveSummary) {
    return _buildSubText(
      label: "Pending Req: ",
      widget: Card(
        elevation: 0,
        color: AppColor.pendingColor.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            leaveSummary.pendingReq.toString(),
            style: AppStyle.normal_text.copyWith(color: AppColor.pendingColor),
          ),
        ),
      ),
    );
  }

  // Build a subtext with a label and either dynamic text or a custom widget
  Widget _buildSubText({required String label, String? value, Widget? widget}) {
    return Row(
      children: [
        Text(
          label,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeSmall + 1,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        widget ??
            Text(
              _checkNullableValue(value),
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor.withOpacity(0.7),
                fontSize: Dimensions.fontSizeSmall + 1,
              ),
              overflow: TextOverflow.ellipsis,
            ),
      ],
    );
  }

  String _checkNullableValue(String? value) {
    if (value == null || value == "null") {
      return "0";
    }
    return value;
  }

  _getAvailable(GetOrganizationUsersLeaveSummary? leaveSummary) {
    if (leaveSummary == null) return null;

    if (leaveSummary.availableNumberOfDays == "no_of_application") {
      final availableDays =
          double.tryParse(leaveSummary.availableNumberOfDays ?? "0") ?? 0;
      final maxConsecutiveDays =
          double.tryParse(leaveSummary.maximumConsecutiveDays.toString()) ?? 0;
      return availableDays * maxConsecutiveDays;
    } else {
      return leaveSummary.isEarned == true
          ? leaveSummary.earnedDays
          : leaveSummary.availableNumberOfDays ?? "0";
    }
  }
}

void showAddAllowance() {
  customButtonSheet(
    context: Get.context!,
    child: Column(
      children: [
        _buildHeader(),
        customSpacerHeight(height: 20),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () {
              Get.find<UserProfileController>().getLeaveTypeDropdown();

              customButtonSheet(
                context: Get.context!,
                child: LeaveAllowance(),
                height: 0.7,
              );
            },
            child: Row(
              children: [
                const Icon(Icons.add),
                customSpacerWidth(width: 8),
                Text(
                  AppString.textAddAllowance.tr,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeSmall + 3,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    height: 0.7,
  );
}

Widget _buildHeader() {
  return Container(
    decoration: const BoxDecoration(
        color: AppColor.leaveRecordCardColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20))),
    height: 130,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Self Declaration",
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.fontSizeMid + 1,
            ),
          ),
          Text(
            "Sick Leave",
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor.withOpacity(0.5),
              fontSize: Dimensions.fontSizeSmall + 1,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
