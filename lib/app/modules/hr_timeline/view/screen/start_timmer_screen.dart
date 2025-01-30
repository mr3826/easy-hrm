import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/timeline_calender/add_to_task.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../common/widget/custom_card_style.dart';
import '../../../../../modules/timeline/view/widget/timer_animation.dart';
import '../../../../global/controller/timmer_controller.dart';
import '../../../../global/view/widget/app_margin.dart';
import '../../bindings/timeline_global_bindings.dart';
import '../../controllers/global_timline_controller.dart';

class StartTimerScreen extends StatelessWidget {
  final bool isEmployee;
  const StartTimerScreen({super.key, required this.isEmployee});
  @override
  Widget build(BuildContext context) {
    TimelineGlobalBindings().dependencies();
    return Scaffold(
      appBar: _buildAppbar(),
      backgroundColor: AppColor.secondaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCurrentDate(),
          _buildStartTimer(
            onTap: () async {
              if (Get.find<TimeCounterController>().isRunning.isFalse &&
                  Get.find<TimelineGlobalController>()
                          .startOrEndTimerResponse
                          ?.startOrStopTimer !=
                      null) {
                await Get.find<TimelineGlobalController>()
                    .startOrEndTimer(timerType: StartOrEndTimer.start.name);

                Get.find<TimeCounterController>().isRunningHorizontalLine(true);
              }
            },
          ),
          const Spacer(
            flex: 2,
          ),
          Obx(
            () => Get.find<TimelineGlobalController>().isEndTimerLoading.isTrue
                ? const CupertinoActivityIndicator(
                    color: AppColor.cardColor,
                  )
                : _buildSaveButton(
                    onAction: () async {
                      if (Get.find<TimeCounterController>().isRunning.isTrue) {
                        await Get.find<TimelineGlobalController>()
                            .startOrEndTimer(
                                timerType: StartOrEndTimer.end.name)
                            .then((value) {
                          Get.find<TimelineGlobalController>().getProjectList();
                          if (context.mounted) {
                            customButtonSheet(
                                height: .6,
                                context: context,
                                isDismissible: false,
                                child: AddToTaskScreen(
                                  isEmployee: isEmployee,
                                ));
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
}

_buildAppbar() {
  return customAppbar(title: AppString.text_timer.tr);
}

_buildCurrentDate() {
  return Center(
      child: Padding(
    padding: marginLayout.copyWith(top: 20),
    child: Text(
      DateFormat('E, d MMMM - yyyy').format(DateTime.now()),
      style: AppStyle.normal_text_grey.copyWith(
          fontSize: Dimensions.fontSizeDefault + 4, color: AppColor.cardColor),
    ),
  ));
}

_buildStartTimer({required Function onTap}) {
  return GestureDetector(
    onTap: () => onTap(),
    child: SizedBox(
        width: double.infinity,
        height: AppLayout.getWidth(400),
        child: const TimerAnimation()),
  );
}

_buildSaveButton({required Function onAction}) {
  return GestureDetector(
    onTap: () {
      onAction();
    },
    child: SizedBox(
      height: AppLayout.getHeight(50),
      width: AppLayout.getWidth(220),
      child: Card(
          shape: roundedRectangleBorder.copyWith(
              borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
          color: Get.find<TimeCounterController>().isRunning.isTrue
              ? AppColor.cardColor.withOpacity(0.3)
              : AppColor.cardColor.withOpacity(0.1),
          elevation: 0,
          child: Center(
              child: Text(
            AppString.text_done_of_save.tr,
            style: AppStyle.mid_large_text.copyWith(
                color: Get.find<TimeCounterController>().isRunning.isTrue
                    ? AppColor.cardColor
                    : AppColor.cardColor.withOpacity(0.6),
                fontSize: Dimensions.fontSizeMid - 2),
          ))),
    ),
  );
}
