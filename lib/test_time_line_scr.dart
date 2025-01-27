import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/bindings/time_sheet_bindings.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/time_sheet_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/timeline_calender/slelected_date_picker.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../common/widget/custom_svg_image.dart';
import '../../../../../common/widget/hr_timeline/floating_timmer_button.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import 'app/global/controller/timmer_controller.dart';
import 'app/global/controller/user_info_controller.dart';
import 'app/global/view/custom_tabbar_with_search.dart';
import 'app/global/view/widget/show_subscription_dialog.dart';
import 'app/modules/hr_timeline/bindings/timeline_bindings.dart';
import 'app/modules/hr_timeline/controllers/start_timer_controller.dart';
import 'app/modules/hr_timeline/view/widgets/time_sheet/build_select_month.dart';
import 'app/modules/hr_timeline/view/widgets/time_sheet/build_timesheet_list.dart';
import 'app/modules/hr_timeline/view/widgets/timeline_calender/buid_timeline_short_summury.dart';
import 'app/modules/hr_timeline/view/widgets/timeline_calender/build_hr_timeline_calendar.dart';
import 'app/modules/settings/bindings/setting_bindings.dart';




bool isEmployee = false;

class HrTimelineScreen extends StatefulWidget {
  const HrTimelineScreen({super.key});


  @override
  State<HrTimelineScreen> createState() => _HrTimelineScreenState();
}

class _HrTimelineScreenState extends State<HrTimelineScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {

    TimelineBindings().dependencies();
    SettingBindings().dependencies();

    _tabController = TabController(length: isEmployee == true ? 1 : 2, vsync: this);
    _tabController.addListener(() {

      if (_tabController.indexIsChanging) {
        setState(() {});
        if(_tabController.index==1){
          TimeSheetBindings().dependencies();
          Get.find<TimeSheetController>().getTimesheetByDate();
        }
      }

    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            isEmployee == true
                ? _isEmployeeSilverAppbar
                : _isAdminSilverAppbar(_tabController),
            _sliverAppbarBody(_tabController),
          ],
        ),
        floatingActionButton: _timerBtnLayout(context),
      ),
    );
  }


  _isAdminSilverAppbar(TabController tabController) {
    return SliverAppBar(
      backgroundColor: AppColor.cardColor,
      foregroundColor: AppColor.cardColor,
      floating: true,
      pinned: true,
      expandedHeight: AppLayout.getHeight(248),
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18),
          child: Column(
            children: [
              _buildAppbar(),
              Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: SizedBox(
                  height: AppLayout.getHeight(40),
                  child: TabBar(
                    labelColor: AppColor.cardColor,
                    controller: tabController,
                    unselectedLabelColor: AppColor.normalTextColor,
                    unselectedLabelStyle: AppStyle.normal_text.copyWith(fontSize: Dimensions.fontSizeDefault + 1),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor.primaryColor,
                    ),
                    indicatorPadding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: AppStyle.normal_text.copyWith(fontSize: Dimensions.fontSizeDefault + 1),
                    tabs: [
                      Tab(text: AppString.textCalendar.tr),
                      Tab(text: AppString.text_time_sheet.tr),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildEmployeeSearch(),
            ],
          ),
        ),
      ),
      centerTitle: true,
      bottom: _bottomLayout(_tabController.index), // Use the current tab index
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
        if (isEmployee)
          const TimelineCalendar()
        else
          tabController.index == 0
              ? const TimelineCalendar()
              : _buildTimeSheet(),
      ]),
    );
  }


  _buildAppbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppString.text_time_line.tr,
            style: AppStyle.normal_text_black.copyWith(
              fontSize: Dimensions.fontSizeMid,
            ),
          ),
          customSvgImage(
            imageUrl: Images.notificationIconNavOutLine,
            height: 26,
            width: 26,
          ),
        ],
      ),
    );
  }


  _bottomLayout([int? tabIndex]) {
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
        child: isEmployee == true
            ? const BuildSelectDateLayout()
            : tabIndex == 0
            ? const BuildSelectDateLayout()
            : const BuildSelectMonth(),
      ),
    );
  }


  _timerBtnLayout(BuildContext context) {
    final TimeCounterController controller = Get.find<TimeCounterController>();
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


  _buildTimeSheet() {
    return const BuildTimesheetList();
  }

  _buildEmployeeSearch() {
    return  CustomSearchBar(
      onValueSelected: (String orgId){

        Get.find<TimeSheetController>().getTimesheetByDate(orgId: orgId);
        Navigator.pop(context);

      },
      onClearAction: (){
        Get.find<TimeSheetController>().getTimesheetByDate();
      },
    );
  }



}
