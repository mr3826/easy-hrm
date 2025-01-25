import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/widget/department_layout_widget.dart';
import 'package:payrun_mobile/modules/profile/view/widget/employee_stauts_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import '../../../../../app/modules/auth/view/screens/otp_screen.dart';
import '../../../../../common/widget/custom_drawer.dart';
import '../../widget/common_widget.dart';
import '../../widget/profile_appbar.dart';


class ProfileScreen extends GetView<UserProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
          (state) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: buildProfileAppBar(
          onAction: () {
            /// Displays a custom drawer when the action is triggered.
            showCustomDrawer(
              context: context,
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: endDrawer(context),
              ),
            );
          },
        ),
        body: Padding(
          padding: marginLayout,
          child: RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: _fetchProfileData, // Refresh callback
            child: ListView(
              children: [
                customSpacerHeight(height: 6),

                // ///User info section
                userInfoLayout(),
                customSpacerHeight(height: 30),

                ///Monthly layout
                monthlyStatusLayout(),
                customSpacerHeight(height: 30),

                ///Edit profile and change password in button sheet action button
                actionBtnLayout(context),
                customSpacerHeight(height: 25),
                descriptionTextLayout(),
                _buildProfileDivider(),

                ///Change email
              //  ChangeEmailNotifyLayout(),

                ///Phone number
                _buildPhoneNumberSection(),

                ///Employee address
                addressText(),
                customSpacerHeight(height: 15),

                ///Department layout
                _buildDepartmentLayout(context),

                customSpacerHeight(height: 5),

                ///Designation history
                _buildDesignationHistoryLayout(context),
                customSpacerHeight(height: 50),
              ],
            ),
          ),
        ),
      ),
      // Loading state: Displays a loading indicator while data is being fetched.
      onLoading: const LoadingIndicator(),
    );
  }

  /// Fetches the latest profile data from the server.
  Future<void> _fetchProfileData() async {
   // await controller.getUserProfile();
    await controller.getEmploymentInfo();
    await controller.getUserLogHistory();
    await controller.getOrganizationInfo();
  }

  _buildProfileDivider() {
    // Display the divider only if the user's profile "about" section is not null or empty.
    if (controller.userDetails?.getOrganizationUserDetails?.profile?.about !=
        null &&
        controller.userDetails!.getOrganizationUserDetails!.profile!.about!
            .isNotEmpty) {
      return horizontalDivider();
    }
    return const SizedBox.shrink();
  }

  _buildDepartmentLayout(context) {
    // Display department layout if the department histories exist and are not empty.
    if (Get.find<UserProfileController>()
        .employeeWorkHistory
        ?.getOrganizationUserHistory
        ?.deptHistories !=
        null &&
        Get.find<UserProfileController>()
            .employeeWorkHistory!
            .getOrganizationUserHistory!
            .deptHistories!
            .isNotEmpty) {
      return departmentLayout(context);
    }
    return const SizedBox.shrink();
  }

  _buildDesignationHistoryLayout(context) {
    // Display employee status layout if the designation histories exist and are not empty.
    if (Get.find<UserProfileController>()
        .employeeWorkHistory
        ?.getOrganizationUserHistory
        ?.designationHistories !=
        null &&
        Get.find<UserProfileController>()
            .employeeWorkHistory!
            .getOrganizationUserHistory!
            .designationHistories!
            .isNotEmpty) {
      return employeeStatusLayout(context: context);
    }
    return const SizedBox.shrink();
  }

  _buildPhoneNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customSpacerHeight(height: 15),
        phoneNumberText(),
        customSpacerHeight(height: 15),
        emergencyPhoneNumber(),
        customSpacerHeight(height: 15),
      ],
    );
  }
}

