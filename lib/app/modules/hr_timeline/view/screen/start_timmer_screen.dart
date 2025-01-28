import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/timeline_calender/start_timer/start_timer_with_animation.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/add_to_task.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../common/widget/custom_card_style.dart';
import '../../../../global/view/widget/app_margin.dart';
import '../../controllers/hr_timeline_controller.dart';
import '../../controllers/start_timer_controller.dart';

class StartTimerScreen extends StatelessWidget {
  const StartTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: AppString.text_timer.tr),
      backgroundColor: AppColor.secondaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _dateText(
              date: DateFormat('E, d MMMM - yyyy').format(DateTime.now())),
          GestureDetector(
            onTap: () async {
              if (Get.find<StartTimerController>().isRunning.isFalse) {
                await Get.find<HrTimelineController>()
                    .startOrEndTimer(timerType: StartOrEndTimer.start.name);
                Get.find<StartTimerController>().isRunningHorizontalLine(true);
              }
            },
            child: SizedBox(
                width: double.infinity,
                height: AppLayout.getWidth(400),
                child: const TimerAnimation()),
          ),
          const Spacer(
            flex: 2,
          ),
          Obx(
            () => _saveBtn(
              onAction: () async {
                if (Get.find<StartTimerController>().isRunning.isTrue) {
                  await Get.find<HrTimelineController>()
                      .startOrEndTimer(timerType: StartOrEndTimer.end.name)
                      .then((value) {
                    Get.find<HrTimelineController>().getProjectDropdown();
                    if (context.mounted) {
                      customButtonSheet(
                          height: .6,
                          context: context,
                          isDismissible: false,
                          child: const AddToTaskScreen());
                    }
                  });
                }
              },
            ),
          ),
          const Spacer(
            flex: 2,
          ),
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
            fontSize: Dimensions.fontSizeDefault + 4,
            color: AppColor.cardColor),
      ),
    ));
  }

  _saveBtn({required Function onAction}) {
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
            color: Get.find<StartTimerController>().isRunning.isTrue
                ? AppColor.cardColor.withOpacity(0.3)
                : AppColor.cardColor.withOpacity(0.1),
            elevation: 0,
            child: Center(
                child: Text(
              AppString.text_done_of_save.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: Get.find<StartTimerController>().isRunning.isTrue
                      ? AppColor.cardColor
                      : AppColor.cardColor.withOpacity(0.6),
                  fontSize: Dimensions.fontSizeMid - 2),
            ))),
      ),
    );
  }
}
