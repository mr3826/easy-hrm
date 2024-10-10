import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../common/widget/employee/user_Info_widget.dart';
import '../widget/employee_profile_view/overview/overview_widget.dart';

class EmployeeProfileViewScreen extends StatelessWidget {
  const EmployeeProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: Padding(
            padding: marginLayout.copyWith(left: 12, right: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  UserInfoWidget(
                    employeeStatus: EmployeeStatus(
                        firstName: "Rifat",
                        lastName: "Hasan",
                        department: "Mobile App",
                        profileImageKey: "",
                        currentEmployeeStatus: "Active",
                        employmentContractType: "Permanent",
                        employmentStatusColorCode: "0CAA1B"),
                  ),
                  MonthlyStatusWidget(
                    status: MonthlyStatus(
                        leaveBalance: "0.0",
                        monthlyGoal: "0.0",
                        loggedTime: "0.0"),
                  ),
              
              
                  customSpacerHeight(height: 20),
              
                  _buildTabBar(),
                  customSpacerHeight(height: 20),
              
                  _buildTabBarView()
              
              
                ],
              ),
            ),
          ),
        ));
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
    child: TabBarView(
      children: [
         OverviewWidget(),
        Container(),
      ],
    ),
  );
}