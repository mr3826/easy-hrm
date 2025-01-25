// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../common/widget/custom_drawer.dart';
// import '../../../../common/widget/custom_spacer.dart';
// import '../../../../common/widget/loading_indicator.dart';
// import '../../../../utils/app_color.dart';
// import '../../../../utils/app_string.dart';
// import '../../../../utils/app_style.dart';
// import '../../../../utils/dimensions.dart';
// import '../../controller/profile_module/hr_profile_controller.dart';
// import '../../controller/user_profile_controller.dart';
// import '../widget/common_widget.dart';
// import '../widget/profile_tabbar_body/build_profile_leave_record.dart';
// import '../widget/profile_tabbar_body/build_profile_overview.dart';
// import '../widget/profile_tabbar_body/leave_summary/leave_summary_widget.dart';
//
// class ProfileScreen extends GetView<UserProfileController> {
//   final List? profileTabView;
//   const ProfileScreen({super.key, this.profileTabView});
//
//   @override
//   Widget build(BuildContext context) {
//
//     final screenHeight = MediaQuery.sizeOf(context).height;
//     final screenWidth = MediaQuery.sizeOf(context).width;
//
//     return controller.obx(
//             (sate) => Scaffold(
//           backgroundColor: AppColor.primaryColor,
//           body: Stack(
//             children: [
//
//               _buildBackgroundContainer(context),
//               _buildProfileImage(screenHeight, screenWidth),
//
//             ],
//           ),
//         ),
//         onLoading: const LoadingIndicator());
//   }
//
//   /// Background Container with Profile Layout
//   Widget _buildBackgroundContainer(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         color: AppColor.primaryColor,
//         borderRadius: BorderRadiusDirectional.only(
//           topEnd: Radius.circular(25),
//           topStart: Radius.circular(25),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 50.0),
//         child: Column(
//           children: [
//             _buildHeader(context),
//             const SizedBox(height: 10),
//             _buildContent(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Positioned Profile Image
//   Widget _buildProfileImage(double screenHeight, double screenWidth) {
//     return Positioned(
//       top: screenHeight * 0.11,
//       left: screenWidth * 0.05,
//       right: screenWidth * 0.05,
//       child: userImageLayout(),
//     );
//   }
//
//   /// Profile Header with Title and Menu Button
//   Widget _buildHeader(BuildContext context) {
//     return SizedBox(
//       height: 70,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               AppString.text_profile.tr,
//               style: AppStyle.mid_large_text.copyWith(
//                 color: AppColor.cardColor,
//                 fontWeight: FontWeight.w600,
//                 fontSize: Dimensions.fontSizeMid + 1,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 showCustomDrawer(
//                   context: context,
//                   child: Container(
//                     color: Colors.transparent,
//                     width: double.infinity,
//                     child: endDrawer(context),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.menu, color: AppColor.cardColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Main Content Container
//   Widget _buildContent(BuildContext context) {
//     return Expanded(
//       child: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           color: AppColor.cardColor,
//           borderRadius: BorderRadiusDirectional.only(
//             topEnd: Radius.circular(30),
//             topStart: Radius.circular(30),
//           ),
//         ),
//         child: Column(
//           children: [
//             customSpacerHeight(height: 50),
//
//             /// User info section
//             userInfoLayout(),
//             customSpacerHeight(height: 30),
//             monthlyStatusLayout(),
//
//             customSpacerHeight(height: 20),
//
//             if (profileTabView?.length != 3)
//               _buildProfileTabBar([
//                 const BuildProfileOverView(),
//                 const Expanded(child: BuildLeaveRecord()),
//                 const Expanded(child: BuildProfileLeaveSummary())
//               ])
//             else const BuildProfileOverView()
//           ],
//         ),
//       ),
//     );
//   }
//
//   _buildProfileTabBar(List<Widget> profileTabView) {
//     // GetX Controller to manage the selected tab index
//     HrProfileController controller = Get.find<HrProfileController>();
//
//     return Expanded(
//       child: Column(
//         children: [
//           _tabBarList(
//               controller), // Pass the controller to manage the selected index
//           Obx(() => profileTabView.isNotEmpty
//               ? profileTabView[controller.profileTabIndex.value]
//               : Container()),
//         ],
//       ),
//     );
//   }
//
//   _tabBarList(HrProfileController controller) {
//     List<String> tabIndex = ["Overview", "Leave records", "Leave summary"];
//
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             offset: const Offset(0, 1),
//             blurRadius: 6,
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Center(
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: tabIndex.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 controller.profileTabIndex.value =
//                     index; // Change the selected tab index
//                 if (controller.profileTabIndex.value == 1) {
//                   if (controller.leaveRecordList == null) {
//                     controller.getLeaveRecordsData();
//                   }
//                 } else if (controller.profileTabIndex.value == 2) {
//                   if (controller.leaveSummary?.getOrganizationUsersLeaveSummary == null) {
//                     controller.getLeaveSummary();
//                   }
//                 }
//               },
//               child: Obx(
//                     () => Center(
//                   child: Column(
//                     children: [
//                       const Spacer(),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: Text(
//                           tabIndex[index],
//                           style: TextStyle(
//                             color: controller.profileTabIndex.value == index
//                                 ? AppColor.primaryColor // Active tab color
//                                 : Colors.black.withOpacity(0.4),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                       const Spacer(),
//                       // Show underline for active tab with dynamic width
//                       if (controller.profileTabIndex.value == index)
//                         Container(
//                           width: _calculateTextWidth(
//                               tabIndex[index],
//                               const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               )),
//                           height: 2,
//                           color: AppColor.primaryColor, // Underline color
//                         )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
// // Function to calculate text width
//   double _calculateTextWidth(String text, TextStyle style) {
//     final TextPainter textPainter = TextPainter(
//       text: TextSpan(text: text, style: style),
//       maxLines: 1,
//       textDirection: TextDirection.ltr,
//     )..layout();
//     return textPainter.width;
//   }
// }