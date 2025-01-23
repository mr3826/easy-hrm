import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/hr_deshboard_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../global/view/widget/app_margin.dart';
import '../../bindings/dashboard_bindings.dart';
import '../widgets/build_employee_overview.dart';
import '../widgets/build_job_opening.dart';
import '../widgets/build_section_card.dart';
import '../widgets/deshboard_widget.dart';

class HrDashboardScreen extends GetView<HrDashBoardController> {
  const HrDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardBindings().dependencies();
    return controller.obx(
        (state) => RefreshIndicator(
          onRefresh: _refreshScreen,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userInfoAppbarLayout(context),
                customSpacerHeight(height: 30),
                _buildTitleText(AppString.text_employee_overview.tr),
                const BuildEmployeeOverview(),
                customSpacerHeight(height: 24),
                _buildOpenJob(),
                _buildAllCandidates(),
                _buildLeaveRequest(controller.leaveTimeLogSummary
                        ?.getLeaveAndTimelogRequestSummary?.leaveRequest
                        .toString() ??
                    "0"),
                customSpacerHeight(height: 12),
                _buildLogRequest(controller.leaveTimeLogSummary
                        ?.getLeaveAndTimelogRequestSummary?.timelogRequest
                        .toString() ??
                    "0"),
                customSpacerHeight(height: 30),
              ],
            ),
          ),
        ),
        onLoading: const LoadingIndicator());
  }

  _buildOpenJob() {
    if (controller.jobOpening?.getJobs?.data?.isNotEmpty ?? false) {
      return Column(
        children: [
          _buildJobTitleText(
              value: controller.jobOpening?.getJobs?.data?.length.toString() ??
                  "0"),
          const BuildJobOpening(),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _buildTitleText(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0,left: 20,right: 20),
      child: customTitleText(
          text: labelText,
          textStyle: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.fontSizeMid)),
    );
  }

  _buildJobTitleText({String? value}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0,bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitleText("Job openings ($value)"),
          Icon(
            Icons.arrow_forward,
            color: AppColor.normalTextColor.withOpacity(0.8),
          ),

        ],
      ),
    );
  }

  _buildAllCandidates() {
    if (controller.leaveTimeLogSummary?.getLeaveAndTimelogRequestSummary
            ?.totalCandidates !=
        0) {
      return Column(
        children: [
          BuildSectionCard(
            onClick: () {
              controller.getCandidateBySearch();
              Get.toNamed(Routes.ALL_CANDIDATES);
            },
            bgColor: AppColor.interViewCandidatesColor,
            imgUrl: Images.INTERVIEW_CANDIDATES,
            labelText: AppString.text_all_candidate.tr,
            value: controller.leaveTimeLogSummary
                    ?.getLeaveAndTimelogRequestSummary?.totalCandidates
                    .toString() ??
                "0",
          ),
          customSpacerHeight(height: 12),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _buildLeaveRequest(String value) {
    return BuildSectionCard(
      bgColor: AppColor.pendingColor,
      imgUrl: Images.LEAVE_REQ,
      labelText: AppString.text_leave_req.tr,
      value: value,
    );
  }

  _buildLogRequest(String value) {
    return BuildSectionCard(
      bgColor: AppColor.timeLogRequestColor,
      imgUrl: Images.TIMELOG_REQ,
      labelText: AppString.text_log_request.tr,
      value: value,
    );
  }

  Future<void> _refreshScreen() async {
    await controller.getJobOpening();
    await controller.getEmployeeOverView();
  }
}
