import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/timeline_calender/slelected_date_picker.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../common/widget/hr_timeline/floating_timmer_button.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/controller/user_info_controller.dart';
import '../../../../global/view/widget/show_subscription_dialog.dart';
import '../../../settings/bindings/setting_bindings.dart';
import '../../bindings/timeline_bindings.dart';
import '../../controllers/start_timer_controller.dart';
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

    TimelineBindings().dependencies();
    SettingBindings().dependencies();

    _tabController = TabController(length:  1,vsync: this);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _isEmployeeSilverAppbar,
            _sliverAppbarBody(_tabController),
          ],
        ),
        floatingActionButton: _timerBtnLayout(context),
      ),
    );
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
                  buildTimelineShortSummary(),
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
          const TimelineCalendar()
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
        child: const BuildSelectDateLayout()

      ),
    );
  }


  _timerBtnLayout(BuildContext context) {
    final StartTimerController controller = Get.find<StartTimerController>();
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
              : _timerStringBtn(context),
          customSpacerWidth(width: 18),
          _addTimeEntryBtn(),
        ],
      ),
    );
  }

  _timerStringBtn(BuildContext context) {
    return floatingTimmerButton(
        bgBtnColor: AppColor.secondaryColor,
        onAction: () {
          if (Get.find<UserInfoController>()
              .isSubscriptionTimeTrackingIsAllow
              .isFalse) {
            showSubscriptionDialog(context);
          } else {
            Get.toNamed(Routes.TIMER_SCREEN);
          }
        },
        btnText: AppString.text_stat_timer.tr);
  }

  _addTimeEntryBtn() {
    return floatingTimmerButton(
        bgBtnColor: AppColor.primaryColor,
        onAction: () {
          Get.toNamed(Routes.NEW_ENTRY_SCREEN);
        },
        btnText: AppString.text_add_time_entry.tr);
  }

  _timerStringOpenBtn({required time}) {
    return startTimerOpenBtn(
        bgBtnColor: AppColor.secondaryColor,
        onAction: () => Get.toNamed(Routes.TIMER_SCREEN),
        btnText: time.toString());
  }

  _timelineText() {
    return Text(
      AppString.text_time_line.tr,
      style: AppStyle.mid_large_text.copyWith(fontSize: 20),
    );
  }


}
