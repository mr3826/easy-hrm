import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/app/modules/profile/models/user_log_history.dart';
import '../../../auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/model/user_log_history.dart';
import '../../../../global/view/widget/app_margin.dart';
import '../../controller/employment_controller.dart';
import '../widget/employee_profile_view/leave/leave_widget.dart';
import '../widget/employee_profile_view/leave_summary/leave_summary_widget.dart';
import '../widget/employee_profile_view/overview/overview_widget.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../common/widget/employee/user_Info_widget.dart';

class EmployeeProfileViewScreen extends GetView<EmploymentController> {
  const EmployeeProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: controller.obx(
            (state) => DefaultTabController(
              length: 3,
              child: Padding(
                    padding: marginLayout.copyWith(left: 12, right: 12),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildUserInfo(),
                          _buildMonthlyGoal(),
                          customSpacerHeight(height: 20),
                          _buildTabBar(),
                          customSpacerHeight(height: 20),
                          _buildTabBarView()
                        ],
                      ),
                    ),
                  ),
            ),
            onLoading: const LoadingIndicator()),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColor.hintColor,
          size: 18,
        ),
      ),
      title: Text(
        AppString.text_profile.tr,
        style: AppStyle.mid_large_text.copyWith(
          color: AppColor.normalTextColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeMid + 1,
        ),
      ),
    );
  }



  _buildUserInfo() {
    EmploymentController controller = Get.find<EmploymentController>();
    return UserInfoWidget(
      employeeStatus: EmployeeStatus(
        firstName: controller.employeeProfileInfo?.getOrganizationUserDetails
                ?.profile?.firstName ??
            "",
        lastName: controller.employeeProfileInfo?.getOrganizationUserDetails
                ?.profile?.lastName ??
            "",
        department: _getUserDesignation(),
        profileImageKey: controller.employeeProfileInfo
                ?.getOrganizationUserDetails?.profile?.image ??
            "",
        currentEmployeeStatus: controller
                .employeeProfileInfo?.getOrganizationUserDetails?.status ??
            "",
        employmentContractType: _getEmploymentContactType() ?? "",
        employmentStatusColorCode: _getEmploymentContactColor() ?? "0CAA1B",
      ),
    );
  }

  _buildMonthlyGoal() {
    GeTimelogAndLeaveAvailabilityForApp? timelogAndLeaveAvailabilityForApp =
        Get.find<EmploymentController>()
            .employeesLogHistory
            ?.geTimelogAndLeaveAvailabilityForApp;
    return MonthlyStatusWidget(
      status: MonthlyStatus(
          leaveBalance:
              timelogAndLeaveAvailabilityForApp?.balanceLeave ?? "0.0",
          monthlyGoal:
              timelogAndLeaveAvailabilityForApp?.totalSchedule ?? "0.0",
          loggedTime: timelogAndLeaveAvailabilityForApp?.totalLogged ?? "0.0"),
    );
  }

  String? _getEmploymentContactType() {
    if (controller.employeeWorkHistory?.getOrganizationUserHistory
                ?.employmentHistories !=
            null &&
        controller.employeeWorkHistory!.getOrganizationUserHistory!
            .employmentHistories!.isNotEmpty) {
      return controller.employeeWorkHistory?.getOrganizationUserHistory
          ?.employmentHistories?.first.employmentStatus?.name;
    }
    return null;
  }

  String? _getEmploymentContactColor() {
    if (controller.employeeWorkHistory?.getOrganizationUserHistory
                ?.employmentHistories !=
            null &&
        controller.employeeWorkHistory!.getOrganizationUserHistory!
            .employmentHistories!.isNotEmpty) {
      return controller.employeeWorkHistory?.getOrganizationUserHistory
          ?.employmentHistories?.first.employmentStatus?.color
          ?.replaceAll("#", "");
    }
    return null;
  }

  _getUserDesignation() {
    if (controller.employeeWorkHistory?.getOrganizationUserHistory
                ?.designationHistories !=
            null &&
        controller.employeeWorkHistory!.getOrganizationUserHistory!
            .designationHistories!.isNotEmpty) {
      return controller.employeeWorkHistory?.getOrganizationUserHistory
              ?.designationHistories?.first.designation?.name ??
          AppString.notAddedText.tr;
    }
    return AppString.notAddedText.tr;
  }
}

Widget _buildTabBar() {
  return TabBar(
    indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
    padding: EdgeInsets.zero,
    labelPadding: EdgeInsets.zero,
    indicatorColor: AppColor.primaryColor,
    labelColor: AppColor.primaryColor,
    unselectedLabelColor: AppColor.hintColor,
    labelStyle: AppStyle.normal_text_grey.copyWith(
        fontWeight: FontWeight.w600, fontSize: Dimensions.fontSizeDefault),
    tabs: [
      AppString.textOverview.tr,
      AppString.text_leave.tr,
      AppString.textLeaveSummary.tr,
    ].map((text) => _buildTabBarText(text)).toList(),
  );
}

Widget _buildTabBarText(String text) {
  return SizedBox(
    height: 40,
    child: Center(
      child: Text(
        text,
      ),
    ),
  );
}

Widget _buildTabBarView() {
  return SizedBox(
    height: MediaQuery.of(Get.context!).size.height,
    child: const TabBarView(
      children: [
        OverviewWidget(),
        LeaveWidget(),
        LeaveSummaryWidget(),
      ],
    ),
  );
}
