import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/controller/user_info_controller.dart';
import '../../../../../app/global/controller/timmer_controller.dart';
import '../../../../../common/controller/date_time_controller.dart';
import '../../../../../common/widget/custom_card_style.dart';
import '../../../../../common/widget/custom_dialog.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../common/widget/custom_svg_image.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import '../../../../../app/modules/auth/view/screens/otp_screen.dart';


Widget entryAndStartTimeLayout(context) {
  final TimeCounterController controller = Get.put(TimeCounterController());
  return Padding(
    padding: marginLayout.copyWith(left: 8, right: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (Get.isRegistered<DateTimeController>()) {
              Get.delete<DateTimeController>();
            }
            Get.put(DateTimeController());
            Get.toNamed(Routes.NEW_ENTRY_SCREEN);
          },
          child: _addTimeEntry(context),
        ),
        customSpacerWidth(width: 22),

        controller.isRunning.value
            ? _startingTimeOpen(
                time: "${controller.starTimeDashboard}", context: context)
            : _startingTime(context)
      ],
    ),
  );
}

_addTimeEntry(BuildContext context) {
  // Get the screen width and height
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  // Calculate the scale factor based on screen size
  // Text size according to screen size
  double getResponsiveTextSize(double baseSize) {
    double scaleFactor =
        screenWidth / 400; // Use a baseline screen width (e.g., 400)
    return baseSize * scaleFactor;
  }

  double height = screenHeight;
  double width = screenWidth;

  return InkWell(
    onTap: () => Get.toNamed(Routes.NEW_ENTRY_SCREEN),
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0xFF2C67FF),
          borderRadius: BorderRadius.circular(10)),
      height: height / 8,
      width: width / 2.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            Images.addTimeEntry,
          ),
          Positioned(
            bottom:
                23, // Ensure it's visible by bringing it closer to the bottom
            child: Text(
              AppString.text_time_entry.tr,
              style: AppStyle.normal_text_grey.copyWith(
                color: AppColor.cardColor,
                fontSize: getResponsiveTextSize(11.7),
              ),
              textAlign: TextAlign.center, // Center the text
            ),
          ),
        ],
      ),
    ),
  );
}

_startingTimeOpen({required time, context}) {
  return InkWell(
    onTap: () async {
      Get.toNamed(Routes.TIMER_SCREEN);
    },
    child: Stack(
      children: [
        customSvgImage(
            imageUrl: Images.startTimeOpen,
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.width / 2.5),
        Positioned(
            bottom: 0,
            left: 36,
            top: 50,
            child: Row(
              children: [
                Icon(
                  Icons.check_box_outline_blank,
                  color: AppColor.cardColor.withOpacity(0.9),
                  size: 20,
                ),
                customSpacerWidth(width: 4),
                Text(
                  "$time",
                  style: AppStyle.normal_text_grey.copyWith(
                      color: AppColor.cardColor,
                      fontSize: Dimensions.fontSizeDefault + 1),
                ),
              ],
            ))
      ],
    ),
  );
}

_startingTime(context) {
  return InkWell(
    onTap: () {
      _checkIfSubscription();
    },
    child: customSvgImage(
        imageUrl: Images.startTime,
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width / 2.5),
  );
}

void _checkIfSubscription() {
  if (Get.find<UserInfoController>().isSubscriptionTimeTrackingIsAllow.isFalse) {
    alertForSubscriptionRequired();
  } else {
    Get.put(TimeCounterController()).timerStatus();
    Get.toNamed(Routes.TIMER_SCREEN);
  }
}

alertForSubscriptionRequired() {
  return showCustomAlertDialog(
      context: Get.context!,
      onConfirm: () {},
      iconData: Icons.logout,
      paddingHorizontal: 18.0,
      paddingVertical: 16.0,
      buttonSpacing: 0.0,
      iconWidget: customSvgImage(imageUrl: Images.alert, height: 56, width: 56),
      titleText: AppString.text_feature_unavailbe.tr,
      descriptionText: AppString.text_this_functionality_might_etc.tr,
      iconBackgroundColor: AppColor.errorColorLight,
      confirmButtonColor: AppColor.errorColorLight,
      confirmButtonText: AppString.text_log_out.tr,
      extraInfoText: "",
      descriptionFontSize: Dimensions.fontSizeDefault - 2,
      actionButtonWidget: GestureDetector(
        onTap: () => Get.back(),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Card(
              elevation: 0,
              color: AppColor.cardColor,
              shape: roundedRectangleBorder.copyWith(
                  side: BorderSide(
                      width: 1.2, color: AppColor.hintColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                  child: Text(
                AppString.text_cancel.tr,
                style: AppStyle.small_text_black.copyWith(
                    color: AppColor.normalTextColor.withOpacity(0.6),
                    fontSize: Dimensions.fontSizeMid - 4),
              ))),
        ),
      ));
}
