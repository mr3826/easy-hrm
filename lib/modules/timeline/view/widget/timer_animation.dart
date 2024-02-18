import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../utils/images.dart';
import '../../controller/timer_controller.dart';

class TimerAnimation extends GetView<TimeCounterController> {
  const TimerAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          alignment: Alignment.center,
          children: [
            controller.isRunning.isTrue ? _animatedContainer() : Container(),
            controller.isTotalCount.value == false
                ? _totalCountContainer()
                : _normalContainer(),
            Obx(() => (Get.find<TimeCounterController>().isRunning.isTrue &&
                    Get.find<TimeCounterController>()
                        .isRunningHorizontalLine
                        .isTrue)
                ? _horizontalLineAnimation()
                : _nullHorizontalLineLayout()),
          ],
        ));
  }

  _animatedContainer() {
    return Center(
        child: AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.primaryColor.withOpacity(0.2),
      ),
      width: controller.containerSize.value,
      height: controller.containerSize.value,
      curve: Curves.easeInOut,
    ));
  }

  _normalContainer() {
    return Positioned(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0,
        child: Center(
          child: CircleAvatar(
            radius: 95,
            backgroundColor: AppColor.primaryColor.withOpacity(0.2),
            child: Obx(() => CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColor.primaryColor,
                  child: Get.find<TimeCounterController>().isLoading.isTrue
                      ? const CupertinoActivityIndicator(
                          radius: 20,
                          color: Colors.white,
                        )
                      : Text(
                          controller.elapsedTime.toString(),
                          style: AppStyle.normal_text_grey.copyWith(
                              color: AppColor.cardColor,
                              fontSize: Dimensions.fontSizeExtraLarge - 2),
                        ),
                )),
          ),
        ));
  }

  _totalCountContainer() {
    return Center(
      child: CircleAvatar(
        radius: 95,
        backgroundColor: AppColor.primaryColor.withOpacity(0.2),
        child: CircleAvatar(
          radius: 80,
          backgroundColor: AppColor.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.text_total.tr,
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.cardColor,
                    fontSize: Dimensions.fontSizeMid - 2),
              ),
              Text(controller.elapsedTime.toString(),
                  style: AppStyle.normal_text_grey.copyWith(
                      color: AppColor.cardColor,
                      fontSize: Dimensions.fontSizeExtraLarge - 2))
            ],
          ),
        ),
      ),
    );
  }

  _horizontalLineAnimation() {
    return Positioned(
        bottom: -140,
        left: -140,
        right: -140,
        child: Lottie.asset(Images.timer_animation,
            height: 300, width: 300, fit: BoxFit.fitHeight));
  }

  _nullHorizontalLineLayout() {
    return Positioned(
      bottom: -0,
      left: -50,
      right: -50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
            4,
            (index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.circle,
                    color: AppColor.cardColor.withOpacity(0.2),
                    size: 25,
                  ),
                )),
      ),
    );
  }
}
