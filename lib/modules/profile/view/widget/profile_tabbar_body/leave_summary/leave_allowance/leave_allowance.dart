import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../../../common/widget/custom_app_button.dart';
import '../../../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../../utils/app_color.dart';
import '../../../../../../../../../utils/app_string.dart';
import '../../../../../../../../../utils/app_style.dart';
import '../../../../../../../../../utils/dimensions.dart';
import '../../../../../controller/employment_controller.dart';


class LeaveAllowance extends StatelessWidget {
  LeaveAllowance({super.key});

  final EmploymentController controller = Get.find<EmploymentController>();

  @override
  Widget build(BuildContext context) {
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
              //  const SelectedLeaveType(),
                customSpacerHeight(height: 20),

                _buildAllowanceCounterLayout(),

                customSpacerHeight(height: 12),
                _alertMessageLayout(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4.6,
                ),

                _buildButtons(), // Buttons at the bottom
              ],
            ),
          ),
          customSpacerHeight(height: 200),
        ],
      ),
    );
  }

  _alertMessageLayout() {
    return Card(
      elevation: 0,
      shape: roundedRectangleBorder,
      color: AppColor.pendingColor.withOpacity(0.08),
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
  Widget _applicationBalance() { ///Number of application
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
            _buildIconButton(Icons.remove, controller.applicationBalanceDecrement),
            const SizedBox(width: 20),
            Obx(
              () => Text(
                '${controller.applicationBalanceCount}',
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeMid),
              ),
            ),
            const SizedBox(width: 20),
            _buildIconButton(Icons.add, controller.applicationBalanceIncrement),
          ],
        ),
      ),
    );
  }///Number of application

  Widget _maxConsecutiveDays() { ///Number of application
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
            _buildIconButton(Icons.remove, controller.applicationMaxDayDecrement),
            const SizedBox(width: 20),
            Obx(
              () => Text(
                '${controller.applicationMaxDaysCount}',
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeMid),
              ),
            ),
            const SizedBox(width: 20),
            _buildIconButton(Icons.add, controller.applicationMaxDayIncrement),
          ],
        ),
      ),
    );
  }





  Widget _buildAllowanceCounterNumberOfDays() { ///Number of days
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
            _buildIconButton(Icons.remove, controller.dayDecrement),
            const SizedBox(width: 20),
            Obx(
              () => Text(
                '${controller.daysCount}',
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeMid),
              ),
            ),
            const SizedBox(width: 20),
            _buildIconButton(Icons.add, controller.dayIncrement),
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

  // Optimized button layout for scrolling and responsiveness
  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 20.0), // Adds padding for responsiveness
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45,
              child: CustomAppButton(
                borderRadius: Dimensions.radiusDefault,
                isButtonExpanded: true,
                buttonText: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.close,
                        color: AppColor.hintColor, size: 23),
                    customSpacerWidth(width: 8),
                    Text(
                      AppString.text_cancel.tr,
                      style: AppStyle.normal_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault + 2,
                      ),
                    ),
                  ],
                ),
                onPressed: () => Get.back(),
                buttonColor: AppColor.cardColor,
                borderColor: AppColor.hintColor.withOpacity(0.5),
              ),
            ),
          ),
          customSpacerWidth(width: 14),
          Expanded(
            child: SizedBox(
              height: 45,
              child: CustomAppButton(
                isButtonExpanded: false,
                borderRadius: Dimensions.radiusDefault,
                buttonText: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.done, color: AppColor.cardColor, size: 23),
                    customSpacerWidth(width: 8),
                    Text(
                      AppString.text_save.tr,
                      style: AppStyle.normal_text.copyWith(
                        color: AppColor.cardColor,
                        fontSize: Dimensions.fontSizeDefault + 2,
                      ),
                    ),
                  ],
                ),
                onPressed: () {},
                buttonColor: AppColor.primaryColor,
                borderColor: AppColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildAllowanceCounterLayout() {
    String data ="No_of_applications";
    if(data=="No_of_applications"){
      return _numberOfApplication();
    }else {
      return _numberOfDays();
    }
  }


  _numberOfDays(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAllowanceBalanceText( AppString.textAllowanceBalance.tr),
        customSpacerHeight(height: 4),
        _buildAllowanceCounterNumberOfDays(),
      ],
    );
  }
  _numberOfApplication(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAllowanceBalanceText( AppString.textApplicationBalance.tr),
        customSpacerHeight(height: 4),
        _applicationBalance(),
        customSpacerHeight(height: 20),

        _buildAllowanceBalanceText( AppString.textMaxConsecutiveBalance.tr),
        customSpacerHeight(height: 4),

        _maxConsecutiveDays(),

      ],
    );
  }
}
