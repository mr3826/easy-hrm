import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/employee/presentation/controller/employment_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import '../../../../../../modules/profile/model/user_profile.dart';
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: controller.obx(
            (state) => Padding(
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
            onLoading: const LoadingIndicator()),
      ),
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
        department: controller
            .employeeProfileInfo?.getOrganizationUserDetails?.department?.name,
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
    return MonthlyStatusWidget(
      status: MonthlyStatus(
          leaveBalance: "0.0", monthlyGoal: "0.0", loggedTime: "0.0"),
    );
  }

  String? _getEmploymentContactType() {
    EmploymentController controller = Get.find<EmploymentController>();
    if (controller.employeeWorkHistory?.getOrganizationUserHistory
                ?.employmentHistories !=
            null &&
        controller.employeeWorkHistory!.getOrganizationUserHistory!
            .employmentHistories!.isNotEmpty) {
      return controller.employeeWorkHistory?.getOrganizationUserHistory
          ?.employmentHistories?.first.employmentStatus?.name;
    }
  }

  String? _getEmploymentContactColor() {
    EmploymentController controller = Get.find<EmploymentController>();
    if (controller.employeeWorkHistory?.getOrganizationUserHistory
                ?.employmentHistories !=
            null &&
        controller.employeeWorkHistory!.getOrganizationUserHistory!
            .employmentHistories!.isNotEmpty) {
      controller.employeeWorkHistory?.getOrganizationUserHistory
          ?.employmentHistories?.first.employmentStatus?.color
          ?.replaceAll("#", "");
    }
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
