import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/profile/view/widget/department_layout_widget.dart';
import 'package:payrun_mobile/modules/profile/view/widget/employee_stauts_layout.dart';
import '../../../../common/widget/custom_drawer.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../common/widget/loading_indicator.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../auth/presentation/view/otp_screen.dart';
import '../../controller/user_profile_controller.dart';
import '../widget/chnage_email_notify_layout.dart';
import '../widget/common_widget.dart';

class ProfileScreen extends GetView<UserProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return controller.obx(
        (sate) => Scaffold(
              backgroundColor: AppColor.primaryColor,
              body: Stack(
                children: [
                  _buildBackgroundContainer(context),
                  _buildProfileImage(screenHeight, screenWidth),
                ],
              ),
            ),
        onLoading: const LoadingIndicator());
  }

  /// Background Container with Profile Layout
  Widget _buildBackgroundContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 10),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  /// Positioned Profile Image
  Widget _buildProfileImage(double screenHeight, double screenWidth) {
    return Positioned(
      top: screenHeight * 0.11,
      left: screenWidth * 0.05,
      right: screenWidth * 0.05,
      child: userImageLayout(),
    );
  }

  /// Profile Header with Title and Menu Button
  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppString.text_profile.tr,
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.cardColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeMid + 1,
              ),
            ),
            IconButton(
              onPressed: () {
                showCustomDrawer(
                  context: context,
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: endDrawer(context),
                  ),
                );
              },
              icon: const Icon(Icons.menu, color: AppColor.cardColor),
            ),
          ],
        ),
      ),
    );
  }

  /// Main Content Container
  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(30),
            topStart: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: marginLayout,
          child: Column(
            children: [
              customSpacerHeight(height: 50),

              /// User info section
              userInfoLayout(context),
              customSpacerHeight(height: 30),

              /// RefreshIndicator with scrollable content
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _fetchProfileData, // Call the refresh method
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Monthly layout
                        monthlyStatusLayout(),

                        customSpacerHeight(height: 25),

                        /// User description
                        descriptionTextLayout(),

                        customSpacerHeight(height: 8),

                        /// User email
                        const BuildEmail(),

                        /// Phone number
                        _buildPhoneNumberSection(),

                        /// Employee address
                        addressText(),
                        customSpacerHeight(height: 15),

                        /// Department layout
                        _buildDepartmentLayout(context),

                        customSpacerHeight(height: 5),

                        /// Designation history
                        _buildDesignationHistoryLayout(context),
                        customSpacerHeight(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Fetches the latest profile data from the server.
  Future<void> _fetchProfileData() async {
    try {
      await controller.getUserProfile();
      await controller.getEmploymentInfo();
      await controller.getUserLogHistory();
      await controller.getOrganizationInfo();
    } catch (e) {
      // Optionally handle errors or show a message
      Get.snackbar('Error', 'Failed to refresh data');
    }
  }

  Widget _buildPhoneNumberSection() {
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

  Widget _buildDepartmentLayout(BuildContext context) {
    String? department = Get.find<UserProfileController>()
        .userDetails
        ?.getOrganizationUserDetails
        ?.department
        ?.name;
    if (department != null) {
      return departmentLayout(context);
    }
    return const SizedBox.shrink();
  }


  Widget _buildDesignationHistoryLayout(BuildContext context) {
    return employeeStatusLayout(context: context);
  }
}
