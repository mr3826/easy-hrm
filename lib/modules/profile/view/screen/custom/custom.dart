import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widget/custom_drawer.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../auth/presentation/view/otp_screen.dart';
import '../../widget/common_widget.dart';
import 'department_with_emplyee_status/department_with_employee_status.dart';
import 'final.dart';


class ProfileScreen extends StatelessWidget {

 final UserInformation ?userInformation;
 final List ?listOfTabBar;

  const ProfileScreen({super.key,this.userInformation,this.listOfTabBar});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          _buildBackgroundContainer(context,userInformation??UserInformation()),
          _buildProfileImage(screenHeight, screenWidth,url: userInformation?.profileImgUrl??"",errorText: "Er"),

        ],
      ),
    );

  }

  /// Background Container with Profile Layout
  Widget _buildBackgroundContainer(BuildContext context,UserInformation userInformation) {
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
            _buildContent(context,userInformation),
          ],
        ),
      ),
    );
  }
  /// Positioned Profile Image
  Widget _buildProfileImage(double screenHeight, double screenWidth,{String ?errorText,required String url }) {
    return Positioned(
      top: screenHeight * 0.11,
      left: screenWidth * 0.05,
      right: screenWidth * 0.05,
      child: buildUserImageLayout(errorText: errorText??"Er",url:url ),
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
  Widget _buildContent(BuildContext context,UserInformation userInformation ) {
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
               ProfileUserInformation(userInformation:userInformation),


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
                        BuildMonthlyGoal(userInformation:userInformation),

                        customSpacerHeight(height: 25),

                        /// User description
                        BuildDescription(description: userInformation.description??"",),

                        customSpacerHeight(height: 8),

                        /// User email
                         BuildEmailWithCopied(email: userInformation.userEmail??"",),

                        /// Phone number
                        _buildPhoneNumberSection(userInformation.personalPhoneNumber??"",userInformation.emergencyPhoneNumber??""),

                        /// Employee address
                        buildAddressText(address:  userInformation.userEmail??""),
                        customSpacerHeight(height: 15),

                        /// Department layout
                        BuildDepartmentWithEmployeeStatus(userInformation: userInformation),

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
      // await controller.getUserProfile();
      // await controller.getEmploymentInfo();
      // await controller.getUserLogHistory();
      // await controller.getOrganizationInfo();
    } catch (e) {
      // Optionally handle errors or show a message
      Get.snackbar('Error', 'Failed to refresh data');
    }
  }

  Widget _buildPhoneNumberSection(String personalNumber,emergencyPersonalNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customSpacerHeight(height: 15),
        buildPhoneNumberText(personalNumber: personalNumber),
        customSpacerHeight(height: 15),
        buildEmergencyPhoneNumber(emergencyPersonalNumber: emergencyPersonalNumber),
        customSpacerHeight(height: 15),
      ],
    );
  }

  Widget _buildDepartmentLayout(BuildContext context,UserInformation userInformation) {
    // List<DeptHistories>? departmentHistory = controller.employeeWorkHistory
    //     ?.getOrganizationUserHistory
    //     ?.deptHistories;
    // if (departmentHistory != null && departmentHistory.isNotEmpty) {
    //   return departmentLayout(context);
    // }
    return BuildDepartmentWithEmployeeStatus(userInformation: userInformation,);
  }

  Widget _buildDesignationHistoryLayout(BuildContext context) {
    // List<DesignationHistories>? designationHistory = controller
    //     .employeeWorkHistory
    //     ?.getOrganizationUserHistory
    //     ?.designationHistories;
    // if (designationHistory != null && designationHistory.isNotEmpty) {
    //   return employeeStatusLayout(context: context);
    // }
    return const SizedBox.shrink();
  }
   // return employeeStatusLayout(context: context);



  }













class UserInformation {
  String? profileImgUrl;
  String? userName;
  String? userEmail;
  String? userAddress;
  String? personalPhoneNumber;
  String? emergencyPhoneNumber;
  String? employeeId;
  String? leaveBalance;
  String? monthGoal;
  String? loggedTime;
  String? departmentName;
  String? description;
  DepartmentInfo? departmentInfo;
  List? employmentStatus = [];
  UserInformation({this.userName, this.profileImgUrl,this.departmentInfo,this.departmentName, this.employeeId,this.employmentStatus,this.leaveBalance,this.loggedTime,this.monthGoal,this.description,this.userEmail,this.personalPhoneNumber,this.userAddress,this.emergencyPhoneNumber});
}


class DepartmentInfo {
  final String departmentName;
  final String? parentDepartmentName;
  final String startDate;
  final String workShiftStartTime;
  final String workShiftName;
  final String workShiftEndTime;
  final List<Map<String, dynamic>> workingDays;

  ///Using for department history
  final Function onAction;

  DepartmentInfo({
    required this.departmentName,
    this.parentDepartmentName,
    required this.onAction,
    required this.startDate,
    required this.workShiftStartTime,
    required this.workShiftName,
    required this.workShiftEndTime,
    required this.workingDays,
  });
}

