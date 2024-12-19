import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../auth/presentation/view/otp_screen.dart';
import '../../../controller/user_profile_controller.dart';
import '../chnage_email_notify_layout.dart';
import '../common_widget.dart';
import '../department_layout_widget.dart';
import '../employee_stauts_layout.dart';

class BuildProfileOverView extends GetView<UserProfileController> {
  const BuildProfileOverView({super.key});

  @override
  Widget build(BuildContext context) {

    return
      /// RefreshIndicator with scrollable content
      Expanded(
        child: RefreshIndicator(
          onRefresh: _fetchProfileData, // Call the refresh method
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: marginLayout,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Monthly layout

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
      );
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

}