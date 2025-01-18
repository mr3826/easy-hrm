import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/candidates_details_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import 'build_tab_activities.dart';
import 'build_tab_details.dart';
import 'build_tab_reviews.dart';

class CandidateDetailsTabBar extends GetView<CandidateDetailsController> {
  const CandidateDetailsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: Column(
          children: [
            _buildTabBar(),
            const Expanded(
              child: TabBarView(
                children: [
                  BuildTabDetails(),
                  BuildTabActivities(),
                  ReviewTab(),
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
