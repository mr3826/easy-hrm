import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../widget/build_access_level.dart';
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
        child: SingleChildScrollView(
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
              _buildAllCandidates(),
              customSpacerHeight(height: 12),
              _buildLeaveRequest(),
              customSpacerHeight(height: 12),
              _buildLogRequest(),
              customSpacerHeight(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitleText(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: customTitleText(
          text: labelText,
          textStyle: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.fontSizeMid)),
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

  _buildAllCandidates() {
    return BuildAccessLevel(
      bgColor: AppColor.interViewCandidatesColor,
      imgUrl: Images.INTERVIEW_CANDIDATES,
      labelText: "All candidates",
      value: "120",
    );
  }

  _buildLeaveRequest() {
    return BuildAccessLevel(
      bgColor: AppColor.pendingColor,
      imgUrl: Images.LEAVE_REQ,
      labelText: "Leave request",
      value: "12",
    );
  }

  _buildLogRequest() {
    return BuildAccessLevel(
      bgColor: AppColor.timeLogRequestColor,
      imgUrl: Images.TIMELOG_REQ,
      labelText: "Log request",
      value: "34",
    );
  }
}
