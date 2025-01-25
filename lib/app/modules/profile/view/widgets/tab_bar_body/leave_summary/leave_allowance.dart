import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/profile/controller/hr_profile_controller.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import '../../../../../../../../../common/widget/custom_app_button.dart';
import '../../../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../../utils/app_color.dart';
import '../../../../../../../../../utils/app_string.dart';
import '../../../../../../../../../utils/app_style.dart';
import '../../../../../../../../../utils/dimensions.dart';
import '../../../../controller/global_profile_controller.dart';
import '../../../../controller/leave_allowance_controller.dart';
import 'leave_type.dart';

class LeaveAllowance extends GetView<HrProfileController> {
  LeaveAllowance({super.key});

  final LeaveAllowanceController employmentController =
      Get.find<LeaveAllowanceController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLeaveTypeLoading.isTrue) {
        return const LoadingIndicator(
          radius: 16,
        );
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LeaveTypeDropDown(),

                  customSpacerHeight(height: 20),

                  Obx(() => _buildAllowanceCounterLayout()),

                  customSpacerHeight(height: 12),
                  _alertMessageLayout(),

                  customSpacerHeight(height: 50),

                  _buildButtons(), // Buttons at the bottom
                ],
              ),
            ),
            customSpacerHeight(height: 200),
          ],
        ),
      );
    });
  }

  _alertMessageLayout() {
    return Card(
      elevation: 0,
      shape: roundedRectangleBorder,
      color: AppColor.pendingColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const Icon(Icons.error_outline,
                size: 20, color: AppColor.pendingColor),
            customSpacerWidth(width: 6),
            Expanded(
              child: Text(
                "Editing leave allowances here doesn't impact the leave policy. This change will only affect this particular employee.",
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.pendingColor,
                    fontSize: Dimensions.fontSizeDefault - 2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header for the Leave Allowance
  Widget _buildHeader() {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.bgColorWithTimeline,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          AppString.textLeaveAllowance.tr,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeMid,
          ),
        ),
      ),
    );
  }

  // Text for the Allowance Balance
  Widget _buildAllowanceBalanceText(text) {
    return Text(
      text,
      style: AppStyle.mid_large_text.copyWith(
        color: AppColor.normalTextColor,
        fontSize: Dimensions.fontSizeDefault,
        fontWeight: FontWeight.w600,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  // Counter for Allowance using increment and decrement
  Widget _applicationBalance() {
    ///Number of application
    return Card(
      shape: roundedRectangleBorder.copyWith(
        side: BorderSide(
          width: 1,
          color: AppColor.hintColor.withOpacity(0.6),
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(
                Icons.remove, employmentController.applicationBalanceDecrement),
            const SizedBox(width: 20),
            Obx(
              () => Text(
                '${employmentController.applicationBalanceCount}',
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeMid),
              ),
            ),
            const SizedBox(width: 20),
            _buildIconButton(
                Icons.add, employmentController.applicationBalanceIncrement),
          ],
        ),
      ),
    );
  }

  ///Number of application

  Widget _maxConsecutiveDays() {
    ///Number of application
    return Card(
      shape: roundedRectangleBorder.copyWith(
        side: BorderSide(
          width: 1,
          color: AppColor.hintColor.withOpacity(0.6),
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(
                Icons.remove, employmentController.applicationMaxDayDecrement),
            const SizedBox(width: 20),
            Obx(
              () => Text(
                '${employmentController.applicationMaxDaysCount}',
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeMid),
              ),
            ),
            const SizedBox(width: 20),
            _buildIconButton(
                Icons.add, employmentController.applicationMaxDayIncrement),
          ],
        ),
      ),
    );
  }

  Widget _buildAllowanceCounterNumberOfDays() {
    ///Number of days
    return Card(
      shape: roundedRectangleBorder.copyWith(
        side: BorderSide(
          width: 1,
          color: AppColor.hintColor.withOpacity(0.6),
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(Icons.remove, employmentController.dayDecrement),
            const SizedBox(width: 20),
            Obx(
              () => Text(
                '${employmentController.daysCount}',
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeMid),
              ),
            ),
            const SizedBox(width: 20),
            _buildIconButton(Icons.add, employmentController.dayIncrement),
          ],
        ),
      ),
    );
  }

  // Reusable method for IconButton
  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: AppColor.hintColor),
      onPressed: onPressed,
    );
  }

  Widget _buildButtons() {
    final LeaveAllowanceController employmentController = Get.find<LeaveAllowanceController>();

    // Determine if the Save button should be enabled
    final bool isSaveEnabled = employmentController.applicationBalanceCount.value > 0 || employmentController.applicationMaxDaysCount.value > 0 || employmentController.daysCount > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: _buildButtonLayout(
              icon: Icons.close,
              text: AppString.text_cancel.tr,
              textColor: AppColor.hintColor,
              buttonColor: AppColor.cardColor,
              borderColor: AppColor.hintColor.withOpacity(0.5),
              onPressed: () => Get.back(),
            ),
          ),
          customSpacerWidth(width: 14),
          Expanded(
            child: _buildButtonLayout(
              icon: Icons.done,
              text: AppString.text_save.tr,
              textColor: AppColor.cardColor,
              buttonColor: isSaveEnabled
                  ? AppColor.primaryColor
                  : AppColor.primaryColor.withOpacity(0.5),
              onPressed: () {
                if (isSaveEnabled) {
                  controller.updateORGLeaveAvailability(
                    maximumConsecutiveDays: employmentController.applicationMaxDaysCount.value,
                    numberOfApplication: employmentController.applicationBalanceCount.value,
                    numberOfDays: employmentController.daysCount.value,
                    calculateAllowanceBy: controller.calculateAllowanceBy.value,
                  );
                }
              },
              isEnabled: isSaveEnabled,
            ),
          ),
        ],
      ),
    );
  }

  // Button styles
  Widget _buildButtonLayout({
    required IconData icon,
    required String text,
    required Color textColor,
    required Color buttonColor,
    Color borderColor = Colors.transparent,
    required VoidCallback onPressed,
    bool isEnabled = true,
  }) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: SizedBox(
        height: 45,
        child: CustomAppButton(
          isButtonExpanded: false,
          borderRadius: Dimensions.radiusDefault,
          buttonText: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 23),
              customSpacerWidth(width: 8),
              Text(
                text,
                style: AppStyle.normal_text.copyWith(
                  color: textColor,
                  fontSize: Dimensions.fontSizeDefault + 2,
                ),
              ),
            ],
          ),
          onPressed: onPressed,
          buttonColor: buttonColor,
          borderColor: borderColor,
        ),
      ),
    );
  }

  _buildAllowanceCounterLayout() {
    if (Get.find<ProfileGlobalController>().calculateAllowanceBy.value ==
        "no_of_application") {
      return _numberOfApplication();
    } else {
      return _numberOfDays();
    }
  }

  _numberOfDays() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAllowanceBalanceText(AppString.textAllowanceBalance.tr),
        customSpacerHeight(height: 4),
        _buildAllowanceCounterNumberOfDays(),
      ],
    );
  }

  _numberOfApplication() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAllowanceBalanceText(AppString.textApplicationBalance.tr),
        customSpacerHeight(height: 4),
        _applicationBalance(),
        customSpacerHeight(height: 20),
        _buildAllowanceBalanceText(AppString.textMaxConsecutiveBalance.tr),
        customSpacerHeight(height: 4),
        _maxConsecutiveDays(),
      ],
    );
  }
}
