import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/profile/controller/global_profile_controller.dart';
import 'package:payrun_mobile/app/modules/profile/controller/hr_profile_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../modules/leave/domain/leave_record_response.dart';
import '../../models/user_profile.dart';
import 'tab_bar_body/leave_record/build_profile_leave_record.dart';
import 'tab_bar_body/leave_summary/leave_summary_widget.dart';
import 'tab_bar_body/employee_over_view/employee_overview.dart';

class ProfileTabBar extends StatefulWidget {
  final UserDetails userDetails;
  final RxBool isDataLoading;
  final List<GetLeaveRecordsForApp> leaveRecordList;

  const ProfileTabBar(
      {super.key,
      required this.userDetails,
      required this.isDataLoading,
      required this.leaveRecordList});

  @override
  State<ProfileTabBar> createState() => _CandidateDetailsTabBarState();
}

class _CandidateDetailsTabBarState extends State<ProfileTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final HrProfileController hrProfileController =
      Get.find<HrProfileController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(_onTabChanged);
  }

  // void _onTabChanged() {
  //   if (_tabController.index == 1) {
  //     if (hrProfileController.leaveRecordList?.isEmpty ?? true) {
  //       _getLeaveRecord();
  //     }
  //   } else if (_tabController.index == 2) {
  //     if (hrProfileController
  //             .leaveSummary?.getOrganizationUsersLeaveSummary?.isEmpty ??
  //         true) {
  //       _getLeaveSummary();
  //     }
  //   }
  // }

  // void _getLeaveRecord() {
  //   hrProfileController.getLeaveRecordsData();
  // }

  void _getLeaveSummary() {
    hrProfileController.getLeaveSummary();
  }

  @override
  void dispose() {
    // _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ProfileOverView(
                    userDetails: widget.userDetails,
                    onRefresh: () {},
                  ),
                  BuildLeaveRecord(
                    isDataLoading: widget.isDataLoading,
                    leaveRecordList: widget.leaveRecordList,
                  ),
                  BuildProfileLeaveSummary(
                    leaveSummaryApiCall: () =>
                        hrProfileController.getLeaveSummary(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabAlignment: TabAlignment.start,
      unselectedLabelStyle: AppStyle.normal_text_black.copyWith(
        color: AppColor.hintColor,
        fontSize: Dimensions.fontSizeExtraDefault - .5,
      ),
      labelStyle: AppStyle.normal_text_black.copyWith(
        color: AppColor.primaryColor,
        fontSize: Dimensions.fontSizeExtraDefault - .5,
      ),
      isScrollable: true,
      tabs: const [
        Tab(text: "Overview"),
        Tab(text: "Leave Records"),
        Tab(text: "Leave Summary"),
      ],
    );
  }
}
