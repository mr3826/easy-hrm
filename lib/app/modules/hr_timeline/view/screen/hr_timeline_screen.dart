import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/bindings/time_sheet_bindings.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/time_sheet_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/screen/start_timmer_screen.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/timeline_calender/slelected_date_picker.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../common/controller/date_time_controller.dart';
import '../../../../../common/widget/custom_svg_image.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import '../../../../global/view/custom_tabbar_with_search.dart';
import '../../bindings/hr_timeline_bindings.dart';
import '../../models/timeline_summary_by_date.dart';
import '../widgets/time_sheet/build_select_month.dart';
import '../widgets/time_sheet/build_timesheet_list.dart';
import '../widgets/timeline_calender/build_hr_timeline_calendar.dart';
import 'employee_timeline_screen.dart';

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
    HrTimelineBindings().dependencies();
    Get.find<TimelineGlobalController>().isEmployee(false);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
        if (_tabController.index == 1) {
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
            _isAdminSilverAppbar(_tabController),
            _sliverAppbarBody(_tabController),
          ],
        ),
        floatingActionButton: Obx(() => timerBtnLayout(
            context,
            () => Get.to(const StartTimerScreen(
                  isEmployee: false,
                )))),
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
                    unselectedLabelStyle: AppStyle.normal_text
                        .copyWith(fontSize: Dimensions.fontSizeDefault + 1),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor.primaryColor,
                    ),
                    indicatorPadding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: AppStyle.normal_text
                        .copyWith(fontSize: Dimensions.fontSizeDefault + 1),
                    tabs: [
                      Tab(text: AppString.textCalendar.tr),
                      Tab(text: AppString.text_time_sheet.tr),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildEmployeeSearch(tabController),
            ],
          ),
        ),
      ),
      centerTitle: true,
      bottom: _bottomLayout(_tabController.index), // Use the current tab index
    );
  }

  _sliverAppbarBody(TabController tabController) {
    HrTimelineController controller = Get.find<HrTimelineController>();
    return SliverList(
      delegate: SliverChildListDelegate([
        tabController.index == 0
            ? Obx(() => controller.isTimelineCalendarByDateLoading.isTrue ||
                    controller.isTimelineSummaryByDateLoading.isTrue
                ? const CupertinoActivityIndicator(
                    color: AppColor.primaryColor,
                    radius: 20,
                  )
                : TimelineCalendar(
                    timelineSummaryByDate: Get.find<TimelineGlobalController>()
                            .timelineSummaryByDate ??
                        TimelineSummaryByDate())
        )
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
        child: tabIndex == 0 ? _buildSelectedDate() : const BuildSelectMonth(),
      ),
    );
  }

  _buildTimeSheet() {
    return const BuildTimesheetList();
  }

  _buildEmployeeSearch(TabController tabController) {
    return CustomSearchBar(
      onValueSelected: (String orgId) async {
        if (tabController.index == 0) {
          Navigator.pop(context);
          String startDate = "${Get.find<DateTimeController>().requestedDate.value} 00:00:00.000";
          String endDate = "${Get.find<DateTimeController>().requestedDate.value} 23:59:59.000";

          await Get.find<TimelineGlobalController>().getTimelineSummaryByDate(startDate: startDate, endDate: endDate, orgId: orgId);
          await Get.find<HrTimelineController>().getTimelineCalenderByDate(startDate: startDate, endDate: endDate, orgId: orgId);

        } else {
          Navigator.pop(context);
          Get.find<TimeSheetController>().getTimesheetByDate(orgId: orgId);
        }
      },
      onClearAction: () async {
        if (tabController.index == 0) {
          String startDate =
              "${Get.find<DateTimeController>().requestedDate.value} 00:00:00.000";
          String endDate =
              "${Get.find<DateTimeController>().requestedDate.value} 23:59:59.000";

          await Get.find<TimelineGlobalController>()
              .getTimelineSummaryByDate(startDate: startDate, endDate: endDate);
          await Get.find<HrTimelineController>().getTimelineCalenderByDate(
              startDate: startDate, endDate: endDate);
        } else {
          Get.find<TimeSheetController>().getTimesheetByDate();
        }
      },
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
        await Get.find<HrTimelineController>()
            .getTimelineCalenderByDate(startDate: startDate, endDate: endDate);
      },
    );
  }
}
