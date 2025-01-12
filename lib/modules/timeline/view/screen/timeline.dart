import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
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
import '../../../../app/global/controller/user_info_controller.dart';
import '../../../../utils/app_style.dart';
import '../../../dashboard/presentation/view/widget/entry_time_widget.dart';
import '../widget/custom_timeline_calendar.dart';

class TimelineScreen extends GetView<TimelineController> {
  const TimelineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered()) {
      Get.delete<TimelineController>();
    }
    Get.put(TimelineController());
    return controller.obx(
        (state) => Scaffold(
              backgroundColor: AppColor.backgroundColor,
              body: RefreshIndicator(
                backgroundColor: Colors.white,
                onRefresh: _refreshScreen,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [

                    sliverAppBar,
                    sliverList,

                  ],
                ),
              ),
              floatingActionButton: Obx(() => _timerBtnLayout(context)),
            ),
        onLoading: const LoadingIndicator());
  }

  ///component
  _timerBtnLayout(context) {
    final TimeCounterController controller = Get.put(TimeCounterController());

    return Padding(
      padding: EdgeInsets.only(
          left: 35.0,
          bottom: Platform.isAndroid ? 18 : 4,
          top: Platform.isAndroid ? 0 : 40),
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
        onAction: () {
          if (Get.find<UserInfoController>()
              .isSubscriptionTimeTrackingIsAllow
              .isFalse) {
            alertForSubscriptionRequired();
          } else {
            Get.put(TimeCounterController()).timerStatus();
            Get.toNamed(Routes.TIMER_SCREEN);
          }
        },
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

  Future<void> _refreshScreen() async {
    await controller.getTimelineSummaryByMonth(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");

    await controller.getCalendarTimelineDataByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");
    await controller.getTimelineSummaryByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");
  }
}


SliverAppBar get sliverAppBar {
  return SliverAppBar(
    expandedHeight: AppLayout.getHeight(284),
    elevation: 0,
    bottom: _buttonRadiusLayout(),
    pinned: true,
    backgroundColor: AppColor.primaryColor,
    flexibleSpace: FlexibleSpaceBar(
      background: Padding(
        padding: marginLayout,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpacerHeight(height: 45),
                _timelineText(),
                customSpacerHeight(height: 12),
                timelineLayout(),
                customSpacerHeight(height: 6),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

SliverList get sliverList {
  return SliverList(
    delegate: SliverChildListDelegate(



        [
      const CustomTimelineCalendar()
      // Add more content here if needed
    ]


    ),
  );
}


_timelineText() {
  return Text(
    AppString.text_time_line.tr,
    style: AppStyle.mid_large_text.copyWith(fontSize: 20),
  );
}

_buttonRadiusLayout() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(26),
    child: Container(
      decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radiusMid + 15),
              topLeft: Radius.circular(Dimensions.radiusMid + 15))),
      width: double.maxFinite,
      padding: const EdgeInsets.only(top: 12, bottom: 5),
      child: Obx(
        () => dateCalendarLayout(),
      ),
    ),
  );
}

