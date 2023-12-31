import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/add_to_task.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../controller/timer_controller.dart';
import '../widget/timer_animation.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final TimeCounterController _timeCounterController =
      Get.put(TimeCounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: AppString.text_timer.tr),
      backgroundColor: AppColor.secondaryColor,
      body: Column(
        children: [
          _dateText(date: "Thu, 21 April - 2023"),
          customSpacerHeight(height: 50),
          Obx(
            () => SizedBox(
              child: Stack(
                children: [
                  _timeCounterController.isClicked.value == true
                      ? const SizedBox(
                          height: 400, width: 400, child: TimerAnimation())
                      : GestureDetector(
                          onTap: () {
                            _timeCounterController.start();
                          },
                          child: const SizedBox(
                              height: 400, width: 400, child: TimerAnimation()),
                        ),
                ],
              ),
            ),
          ),
          _saveBtn(onAction: () {
            _timeCounterController.stop();
            _timeCounterController.isRunning.value = false; //animation stop
            customButtonSheet(
                height: .7, context: context, child: const AddToTaskScreen());
          }),
        ],
      ),
    );
  }

  _dateText({required String date}) {
    return Center(
        child: Padding(
      padding: marginLayout.copyWith(top: 20),
      child: Text(
        date,
        style: AppStyle.normal_text_grey.copyWith(
            fontSize: Dimensions.fontSizeDefault, color: AppColor.cardColor),
      ),
    ));
  }

  _saveBtn({required onAction}) {
    return GestureDetector(
      onTap: () {
        onAction();
      },
      child: SizedBox(
        height: AppLayout.getHeight(50),
        width: AppLayout.getWidth(220),
        child: Card(
            shape: roundedRectangleBorder.copyWith(
                borderRadius:
                    BorderRadius.circular(Dimensions.radiusExtraLarge)),
            color: AppColor.cardColor.withOpacity(0.3),
            elevation: 0,
            child: Center(
                child: Text(
              AppString.text_done_of_save.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.cardColor,
                  fontSize: Dimensions.fontSizeMid - 2),
            ))),
      ),
    );
  }
}
