import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/employee_timeline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/screen/start_timmer_screen.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/timeline_calender/slelected_date_picker.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../common/controller/date_time_controller.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../common/widget/hr_timeline/floating_timmer_button.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/controller/timmer_controller.dart';
import '../../../../global/controller/user_info_controller.dart';
import '../../../../global/view/widget/show_subscription_dialog.dart';
import '../../bindings/timeline_employee_bindings.dart';
import '../../models/timeline_summary_by_date.dart';
import '../widgets/timeline_calender/buid_timeline_short_summury.dart';
import '../widgets/timeline_calender/build_hr_timeline_calendar.dart';

class EmployeeTimelineScreen extends StatefulWidget {
  const EmployeeTimelineScreen({super.key});

  @override
  State<EmployeeTimelineScreen> createState() => _HrTimelineScreenState();
}

class _HrTimelineScreenState extends State<EmployeeTimelineScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    EmployeeTimelineBindings().dependencies();
    Get.find<TimelineGlobalController>().isEmployee(true);
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Get.find<EmployeeTimelineController>().isTimelineSummaryLoading.isTrue
            ? const LoadingIndicator()
            : Scaffold(
                body: RefreshIndicator(
                  onRefresh: _refreshScreen,
                  child: CustomScrollView(
                    slivers: [
                      _isEmployeeSilverAppbar,
                      _sliverAppbarBody(_tabController),
                    ],
                  ),
                ),
                floatingActionButton: Obx(() => timerBtnLayout(
                    context,
                    () => Get.to(() => const StartTimerScreen(
                          isEmployee: true,
                        )))),
              ));
  }

  SliverAppBar get _isEmployeeSilverAppbar {
    return SliverAppBar(
      expandedHeight: AppLayout.getHeight(276),
      elevation: 0,
      bottom: _bottomLayout(),
      pinned: true,
      floating: true,
      backgroundColor: AppColor.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSpacerHeight(height: 45),
                  _timelineText(),
                  customSpacerHeight(height: 12),
                  buildTimelineShortSummary(
                      Get.find<EmployeeTimelineController>()
                              .timelineSummaryByMonth ??
                          TimelineSummaryByMonth()),
                  customSpacerHeight(height: 6),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sliverAppbarBody(TabController tabController) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Obx(() => Get.find<EmployeeTimelineController>()
                    .isTimelineCalendarByDateLoading
                    .isTrue ||
                Get.find<EmployeeTimelineController>()
                    .isTimelineSummaryByDateLoading
                    .isTrue
            ? const CupertinoActivityIndicator(
                color: AppColor.primaryColor,
                radius: 20,
              )
            : TimelineCalendar(
                timelineSummaryByDate: Get.find<TimelineGlobalController>()
                        .timelineSummaryByDate ??
                    TimelineSummaryByDate()))
      ]),
    );
  }

  _bottomLayout() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(86),
      child: Container(
          decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radiusMid + 15),
                  topLeft: Radius.circular(Dimensions.radiusMid + 15))),
          width: double.maxFinite,
          padding: const EdgeInsets.only(top: 12, bottom: 15),
          child: _buildSelectedDate()),
    );
  }

  _buildSelectedDate() {
    return BuildSelectDateLayout(
      dateRange: (date) async {
        String startDate =
            "${Get.find<DateTimeController>().requestedDate.value} 00:00:00.000";
        String endDate =
            "${Get.find<DateTimeController>().requestedDate.value} 23:59:59.000";
        await Get.find<TimelineGlobalController>()
            .getTimelineSummaryByDate(startDate: startDate, endDate: endDate);
        await Get.find<EmployeeTimelineController>()
            .getTimelineCalenderByDate(startDate: startDate, endDate: endDate);
      },
    );
  }

  _timelineText() {
    return Text(
      AppString.text_time_line.tr,
      style: AppStyle.mid_large_text.copyWith(fontSize: 20),
    );
  }
}

timerBtnLayout(BuildContext context, Function onRoute) {
  return Padding(
    padding: EdgeInsets.only(
        left: 35.0,
        bottom: Platform.isAndroid ? 18 : 4,
        top: Platform.isAndroid ? 0 : 40),
    child: Row(
      children: [
        Get.find<TimeCounterController>().isRunning.value
            ? _timerStringOpenBtn(
                time: Get.find<TimeCounterController>()
                    .starTimeDashboard
                    .toString(),
                onRoute: onRoute)
            : _timerStringBtn(context, onRoute),
        customSpacerWidth(width: 18),
        _addTimeEntryBtn(),
      ],
    ),
  );
}

_addTimeEntryBtn() {
  return floatingTimmerButton(
      bgBtnColor: AppColor.primaryColor,
      onAction: () {
        Get.toNamed(Routes.NEW_ENTRY_SCREEN);
      },
      btnText: AppString.text_add_time_entry.tr);
}

_timerStringBtn(BuildContext context, Function onRoute) {
  return floatingTimmerButton(
      bgBtnColor: AppColor.secondaryColor,
      onAction: () {
        if (Get.find<UserInfoController>()
            .isSubscriptionTimeTrackingIsAllow
            .isFalse) {
          showSubscriptionDialog(context);
        } else {
          Get.find<TimeCounterController>().timerStatus();
          onRoute();
        }
      },
      btnText: AppString.text_stat_timer.tr);
}

_timerStringOpenBtn({required time, required Function onRoute}) {
  return startTimerOpenBtn(
      bgBtnColor: AppColor.secondaryColor,
      onAction: () => onRoute(),
      btnText: time.toString());
}

Future<void> _refreshScreen() async {
  String startDates =
      "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}";
  String endDates =
      "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}";

  await Get.find<EmployeeTimelineController>().getTimelineSummaryByMonth(
      startDate:
          "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
      endDate:
          "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");

  await Get.find<EmployeeTimelineController>()
      .getTimelineCalenderByDate(startDate: startDates, endDate: endDates);

  await Get.find<EmployeeTimelineController>()
      .getTimelineSummaryByDate(startDate: startDates, endDate: endDates);
}
