// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../auth/view/screens/otp_screen.dart';
// import '../../../../../../../common/widget/custom_spacer.dart';
// import '../../../../../../../utils/app_color.dart';
// import '../../../../../../../utils/app_string.dart';
// import '../../../../../../../utils/app_style.dart';
// import '../../../../../../../utils/dimensions.dart';
// import '../../../../../../../modules/profile/controller/user_profile_controller.dart';
// import '../../../../../../../modules/profile/model/user_profile.dart';
// import '../change_email/chnage_email_notify_layout.dart';
// import '../../../../../../../modules/profile/view/widget/common_widget.dart';
// import '../../../../../../../modules/profile/view/widget/department_layout_widget.dart';
// import '../../../../../../../modules/profile/view/widget/employee_stauts_layout.dart';
// import '../../../../../../../modules/profile/view/widget/expanded_text_layout.dart';
// import '../../../../../../../modules/profile/view/widget/user_info_section_layout.dart';
//
//
// class BuildProfileOverView extends StatelessWidget {
//
//  final UserDetails? userDetails;
//  const BuildProfileOverView({super.key,this.userDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: RefreshIndicator(
//           onRefresh: _fetchProfileData, // Call the refresh method
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Padding(
//               padding: marginLayout,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /// Monthly layout
//
//                   customSpacerHeight(height: 25),
//
//                   /// User description
//                   _descriptionTextLayout(),
//
//                   customSpacerHeight(height: 8),
//
//                   /// User email
//                   const BuildEmail(),
//
//                   /// Phone number
//                   _buildPhoneNumberSection(),
//
//                   /// Employee address
//                   _addressText(),
//                   customSpacerHeight(height: 15),
//
//                   /// Department layout
//                   _buildDepartmentLayout(context),
//
//                   customSpacerHeight(height: 5),
//
//                   /// Designation history
//                   _buildDesignationHistoryLayout(context),
//                   customSpacerHeight(height: 50),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//   }
//
//
//
//
//
//
//
//   Widget _buildPhoneNumberSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         customSpacerHeight(height: 15),
//         _phoneNumberText(),
//         customSpacerHeight(height: 15),
//         _emergencyPhoneNumber(),
//         customSpacerHeight(height: 15),
//       ],
//     );
//   }
//
//   Widget _buildDepartmentLayout(BuildContext context) {
//     String? department = Get.find<UserProfileController>()
//         .userDetails
//         ?.getOrganizationUserDetails
//         ?.department
//         ?.name;
//     if (department != null) {
//       return departmentLayout(context);
//     }
//     return const SizedBox.shrink();
//   }
//
//   Widget _buildDesignationHistoryLayout(BuildContext context) {
//     return employeeStatusLayout(context: context);
//   }
//
//   /// Fetches the latest profile data from the server.
//   Future<void> _fetchProfileData() async {
//     try {
//       // await controller.getUserProfile();
//       // await controller.getEmploymentInfo();
//       // await controller.getUserLogHistory();
//       // await controller.getOrganizationInfo();
//     } catch (e) {
//       // Optionally handle errors or show a message
//       Get.snackbar('Error', 'Failed to refresh data');
//     }
//   }
//
//   _descriptionTextLayout() {
//     String drc =
//         userDetails
//         ?.getOrganizationUserDetails
//         ?.profile
//         ?.about ??
//         '';
//     final wordCount = drc.split(' ').length;
//     if (wordCount > 20) {
//       return ExpandedText(
//         text: drc,
//       );
//     } else {
//       return Text(
//         drc,
//         style: AppStyle.mid_large_text.copyWith(
//             color: AppColor.hintColor, fontSize: Dimensions.fontSizeDefault),
//       );
//     }
//   }
//
//   _addressText() {
//       return userInfoSectionLayout(
//           staticText: AppString.text_address.tr,
//           dynamicText:
//               userDetails
//               ?.getOrganizationUserDetails
//               ?.profile
//               ?.address ??
//               "");
//
//   }
//
//
//  _phoneNumberText() {
//    return userInfoSectionLayout(
//      staticText: AppString.text_phone.tr,
//      dynamicText:
//          userDetails
//          ?.getOrganizationUserDetails
//          ?.profile
//          ?.personalNumber ??
//          "",
//    );
//  }
//
//  _emergencyPhoneNumber() {
//    return userInfoSectionLayout(
//      staticText: AppString.text_emergency_phone.tr,
//      dynamicText:
//          userDetails
//          ?.getOrganizationUserDetails
//          ?.profile
//          ?.emergencyNumber ??
//          "",
//    );
//  }
//
// }