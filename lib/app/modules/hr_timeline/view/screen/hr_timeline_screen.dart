import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/time_sheet/build_time_sheet.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../common/widget/custom_appbar.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../common/widget/custom_svg_image.dart';
import '../../../../../common/widget/hr_timeline/floating_timmer_button.dart';
import '../../../../../modules/timeline/view/widget/custom_timeline_calendar.dart';
import '../../../../../modules/timeline/view/widget/timeline_widget.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import '../../../../global/controller/user_info_controller.dart';
import '../../../../global/view/custom_tabbar_with_search.dart';
import '../../../../global/view/widget/show_subscription_dialog.dart';
import '../../controllers/start_timer_controller.dart';
import '../widgets/timeline_calender/build_hr_timeline_calendar.dart';

class HrTimelineScreen extends StatelessWidget {
  const HrTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StartTimerController());

    bool isEmployee=false;
    return  Scaffold(
      appBar: isEmployee==true? null:_buildAppbar(),
      floatingActionButton: _timerBtnLayout(context),
      body:isEmployee==true? _isEmployeeView():_buildTabBarWithSearchSection(),

    );
  }

  _buildAppbar() {
    return customAppbar(
      leadingIcon: Text(
        AppString.text_time_line.tr,
        style: AppStyle.normal_text_black.copyWith(
          fontSize: Dimensions.fontSizeMid,
        ),
      ),
      leadingWidth: MediaQuery.of(Get.context!).size.width / 3,
      centerTitle: false,
      actions: [
        customSvgImage(
          imageUrl: Images.notificationIconNavOutLine,
          height: 26,
          width: 26,
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}

_isEmployeeView(){
  return CustomScrollView(
    slivers: [
      sliverAppBar,
      sliverList,
    ],
  );

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
        padding: const EdgeInsets.only(left: 20,right: 20),
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
    delegate: SliverChildListDelegate([
      const ISEmployeeTimelineCalendar()
    ]
    ),
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
      child: Obx(() => dateCalendarLayout()),
    ),
  );
}


_timelineText() {
  return Text(
    AppString.text_time_line.tr,
    style: AppStyle.mid_large_text.copyWith(fontSize: 20),
  );
}




Widget _buildTabBarWithSearchSection() {
  List<TabItem> tabs = [
    TabItem(label: AppString.textCalendar.tr, body: const ISAdminTimelineCalendar()),
    TabItem(label: AppString.text_time_sheet.tr, body: const BuildTimeSheet()),
  ];
  return TabBarWidget(
    tabs: tabs,
    onTabSelect: (index) {
      print("Selected tab index: $index");
    },
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
            ? _timerStringOpenBtn(time: controller.starTimeDashboard.toString())
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

        if (Get.find<UserInfoController>().isSubscriptionTimeTrackingIsAllow.isFalse) {

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