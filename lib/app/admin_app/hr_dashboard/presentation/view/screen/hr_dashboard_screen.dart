import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../widget/build_employee_overview.dart';
import '../widget/build_job_opening.dart';
import '../widget/deshboard_widget.dart';

class HrDashboardScreen extends StatelessWidget {
  const HrDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: marginLayout.copyWith(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            userInfoAppbarLayout(),

            customSpacerHeight(height: 30),

            _buildTitleText("Employee overview"),

            const BuildEmployeeOverview(),

            customSpacerHeight(height: 24),

            _buildJobTitleText(value: "3"),

            const BuildJobOpening(),









          ],
        ),
      ),
    );
  }

  _buildTitleText(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: customTitleText(text: labelText, fontSize: Dimensions.fontSizeMid),
    );
  }

  _buildJobTitleText({String? value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitleText("Job openings ($value)"),
        Icon(
          Icons.arrow_forward,
          color: AppColor.normalTextColor.withOpacity(0.8),
        )
      ],
    );
  }
}
