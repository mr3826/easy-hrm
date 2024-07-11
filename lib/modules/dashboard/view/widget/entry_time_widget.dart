import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../common/widget/custom_dialog.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../common/widget/custom_svg_image.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/images.dart';
import '../../../auth/presentation/controller/signin_controller.dart';
import '../../../auth/presentation/view/otp_screen.dart';
import '../../../timeline/controller/timer_controller.dart';

Widget entryAndStartTimeLayout(context) {
  final TimeCounterController controller = Get.put(TimeCounterController());
  return Padding(
    padding: marginLayout.copyWith(left: 8, right: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          //todo
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

_addTimeEntry(context) {
  return InkWell(
    onTap: () => Get.toNamed(Routes.NEW_ENTRY_SCREEN),
    child: Stack(
      children: [
        customSvgImage(
            imageUrl: Images.add_time_entry,
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.width / 2.5),
        Positioned(
            bottom: 0,
            left: 36,
            top: 77,
            child: Text(
              AppString.text_time_entry.tr,
              style: AppStyle.normal_text_grey.copyWith(
                  color: AppColor.cardColor,
                  fontSize: Dimensions.fontSizeDefault - 2),
            ))
      ],
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
            imageUrl: Images.start_time_open,
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
        imageUrl: Images.start_time,
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width / 2.5),
  );
}

void _checkIfSubscription() {
  if (Get.find<SignInController>().isSubscriptionTimeTrackingIsAllow.isFalse) {
    alertForSubscriptionRequired();
  } else {
    Get.put(TimeCounterController()).timerStatus();
    Get.toNamed(Routes.TIMER_SCREEN);
  }
}

alertForSubscriptionRequired() {
  return customDialog(
      context: Get.context!,
      saveBtnAction: () {},
      icon: Icons.logout,
      horizontalPadding: 18.0,
      verticalPadding: 16.0,
      btnPadding: 0.0,
      iconWidget: customSvgImage(imageUrl: Images.alert, height: 56, width: 56),
      titleText: AppString.text_feature_unavailbe.tr,
      subText: AppString.text_this_functionality_might_etc.tr,
      iconBgColor: AppColor.errorColorLight,
      btnBgColor: AppColor.errorColorLight,
      btnText: AppString.text_log_out.tr,
      drcText: "",
      drcFontSize: Dimensions.fontSizeDefault - 2,
      btnWidget: GestureDetector(
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
