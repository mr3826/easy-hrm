import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../common/widget/custom_svg_image.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/images.dart';
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
          child: customSvgImage(
              imageUrl: Images.add_time_entry,
              height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.width / 2.5),
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
            bottom: 45,
            left: 36,
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
      Get.find<TimeCounterController>().timerStatus();
      Get.toNamed(Routes.TIMER_SCREEN);
    },
    child: customSvgImage(
        imageUrl: Images.start_time,
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width / 2.5),
  );
}
