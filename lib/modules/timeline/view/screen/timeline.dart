import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/controller/timer_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/floating_btn_layout.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timeline_widget.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../leave/view/widget/widget.dart';
import '../widget/custom_timeline_calendar.dart';

class TimelineScreen extends GetView<TimelineController> {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return controller.obx(
        (state) => Scaffold(
              backgroundColor: AppColor.backgroundColor,
              body: CustomScrollView(
                slivers: [sliverAppBar, sliverToBoxAdapter],
              ),
              floatingActionButton: Obx(() => _timerBtnLayout(context)),
            ),
        onLoading: const LoadingIndicator());
  }

  //component
  _timerBtnLayout(context) {
    final TimeCounterController controller = Get.put(TimeCounterController());

    return   Get.find<TimelineController>().isTimelineSummaryByDateLoading.isTrue &&  Get.find<TimelineController>().isTimelineSummaryByDateLoading.isTrue?
  const CircularProgressIndicator():
      Padding(
            padding: const EdgeInsets.only(left: 35.0, bottom: 18),
            child: Row(
              children: [
                controller.isRunning.value
                    ? _timerStringOpenBtn(
                        time: controller.starTimeDashboard.toString())
                    : _timerStringBtn(),
                customSpacerWidth(width: 18),
                _addTimeEntryBtn(),
              ],
            ),
          );
  }
  _timerStringBtn() {
    return floatingButton(
        bgBtnColor: AppColor.secondaryColor,
        onAction: () => Get.toNamed(Routes.TIMER_SCREEN),
        btnText: AppString.text_stat_timer.tr);
  }

  _addTimeEntryBtn() {
    return floatingButton(
        bgBtnColor: AppColor.primaryColor,
        onAction: () {
          if (Get.isRegistered<DateTimeController>()) {
            Get.delete<DateTimeController>();
          }
          Get.put(DateTimeController());
          Get.toNamed(Routes.NEW_ENTRY_SCREEN);
        },
        btnText: AppString.text_add_time_entry.tr);
  }

  _timerStringOpenBtn({required time}) {
    return startTimerOpenBtn(
        bgBtnColor: AppColor.secondaryColor,
        onAction: () => Get.toNamed(Routes.TIMER_SCREEN),
        btnText: "$time");
  }
}

SliverAppBar get sliverAppBar {
  return SliverAppBar(
    expandedHeight: AppLayout.getHeight(230),
    elevation: 0,
    bottom: _buttonRadiusLayout(),
    pinned: true,
    backgroundColor: AppColor.primaryColor,
    flexibleSpace: FlexibleSpaceBar(
      background: SizedBox(
        height: AppLayout.getHeight(100),
        width: AppLayout.getWidth(200),
        child: Padding(
          padding: marginLayout,
          child: Column(
            children: [
              customSpacerHeight(height: 6),
              appBar(text: AppString.text_time_line.tr),
              customSpacerHeight(height: 4),
              timelineLayout(),
              customSpacerHeight(height: 14),
            ],
          ),
        ),
      ),
    ),
  );
}

_buttonRadiusLayout() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(12),
    child: Container(
        decoration: BoxDecoration(
            color: AppColor.cardColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radiusMid + 100),
                topLeft: Radius.circular(Dimensions.radiusMid + 100))),
        width: double.maxFinite,
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        child: const Center(
            child: Text(
          "",
          style: TextStyle(fontSize: 12),
        ))),
  );
}

SliverToBoxAdapter get sliverToBoxAdapter {

  return const SliverToBoxAdapter(
    child: CustomTimelineCalendar(),
  );
}
