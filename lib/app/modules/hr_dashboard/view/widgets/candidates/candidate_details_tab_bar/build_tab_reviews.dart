import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/candidates_details_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import '../../../../../../global/view/widget/app_margin.dart';
import 'build_rating_section.dart';
import 'build_reviewer_list.dart';

class ReviewTab extends GetView<CandidateDetailsController> {
  const ReviewTab({super.key});

  @override
  Widget build(BuildContext context) {

    return controller.obx((state)=>Padding(
      padding: marginLayout,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CandidateRatingSection(),
            customSpacerHeight(height: 20),
            const BuildReviewerList(),
          ],
        ),
      ),
    ),onLoading: const LoadingIndicator());

  }
}
