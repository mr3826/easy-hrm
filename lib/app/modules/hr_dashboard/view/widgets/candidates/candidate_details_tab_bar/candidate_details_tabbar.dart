import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/candidates_details_controller.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/hr_deshboard_controller.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import 'build_tab_activities.dart';
import 'build_tab_details.dart';
import 'build_tab_reviews.dart';


class CandidateDetailsTabBar extends StatefulWidget {
  const CandidateDetailsTabBar({super.key});

  @override
  State<CandidateDetailsTabBar> createState() => _CandidateDetailsTabBarState();
}

class _CandidateDetailsTabBarState extends State<CandidateDetailsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final CandidateDetailsController candidateDetailsController = Get.find<CandidateDetailsController>();
  final HrDashBoardController hrDashBoardController = Get.find<HrDashBoardController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: candidateDetailsController.initialTabIndex);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.index == 1) {
      // Check if activities logs are null or empty before calling _getActivities
      if (candidateDetailsController.candidateActivitiesLogs?.getLogs?.isEmpty ?? true) {
        _getActivities();
      }
    } else if (_tabController.index == 2) {
      // Check if reviews data is null or empty before calling _getReviews
      if (candidateDetailsController.candidateReviewModel?.getTeamNotes?.data?.isEmpty ?? true) {
        _getReviews();
      }
    }
  }

  void _getActivities() {
    String selectedJobApplicationId = hrDashBoardController.selectedJobApplicationId.value;
    candidateDetailsController.getCandidateActivitiesLogs(selectedJobApplicationId);
  }

  void _getReviews() {
    String selectedJobApplicationId = hrDashBoardController.selectedJobApplicationId.value;
    candidateDetailsController.getCandidateReview(selectedJobApplicationId);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
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
              child: Obx(
                    () => candidateDetailsController.isReviewLoading.isTrue
                    ? const LoadingIndicator()
                    : TabBarView(
                  controller: _tabController,
                  children: const [
                    BuildTabDetails(),
                    BuildTabActivities(),
                    ReviewTab(),
                  ],
                ),
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
        Tab(text: 'Details'),
        Tab(text: 'Activities'),
        Tab(text: 'Reviews'),
      ],
    );
  }
}

