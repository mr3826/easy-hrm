import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'build_rating_section.dart';
import 'build_reviewer_list.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
