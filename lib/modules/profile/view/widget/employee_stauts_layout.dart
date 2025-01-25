// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:payrun_mobile/common/widget/custom_card_style.dart';
// import 'package:payrun_mobile/common/widget/custom_spacer.dart';
// import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
// import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
// import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
// import 'package:payrun_mobile/modules/profile/model/user_profile.dart';
// import 'package:payrun_mobile/app/modules/profile/view/widgets/tab_bar_body/employee_over_view/designation_layout.dart';
// import 'package:payrun_mobile/modules/profile/view/widget/employeement_status_layout.dart';
// import 'package:payrun_mobile/utils/app_color.dart';
// import 'package:payrun_mobile/utils/app_string.dart';
// import 'package:payrun_mobile/utils/app_style.dart';
// import 'package:payrun_mobile/utils/dimensions.dart';
// import 'package:payrun_mobile/utils/images.dart';
// import '../../../timeline/view/widget/timeline_calendar.dart';
// import 'department_layout_widget.dart';
//
// Widget employeeStatusLayout({BuildContext? context}) {
//   Designation? designation = Get.find<UserProfileController>()
//       .userDetails
//       ?.getOrganizationUserDetails
//       ?.designation;
//
//   EmploymentStatusData? employmentStatus = Get.find<UserProfileController>()
//       .userDetails
//       ?.getOrganizationUserDetails
//       ?.employmentStatus;
//
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       if (designation != null)
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               Get.find<UserProfileController>().getEmploymentInfo();
//               customAntButtonSheet(
//                   child: const DesignationLayout(), context: context!);
//             },
//             child: SizedBox(
//               child: Card(
//                 elevation: 0,
//                 color: AppColor.bgColorWithPrimary.withOpacity(0.3),
//                 shape: roundedRectangleBorder,
//                 child: Padding(
//                   padding: marginLayout.copyWith(top: 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       customSvgImage(
//                           imageUrl: Images.EMPLOYEE_STATUS,
//                           height: 25,
//                           width: 25),
//                       customSpacerHeight(height: 12),
//                       _designationInfo(),
//                       customSpacerHeight(height: 12),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       if (employmentStatus != null) ...[
//         customSpacerWidth(width: 4),
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               Get.find<UserProfileController>().getEmploymentInfo();
//               customAntButtonSheet(
//                   context: context!, child: const EmploymentLayout());
//             },
//             child: SizedBox(
//               child: Card(
//                 elevation: 0,
//                 color: AppColor.bgColorWithPrimary.withOpacity(0.3),
//                 shape: roundedRectangleBorder,
//                 child: Padding(
//                   padding: marginLayout.copyWith(top: 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       customSvgImage(
//                           imageUrl: Images.FLAG, height: 25, width: 25),
//                       customSpacerHeight(height: 12),
//                       _employmentInfo(),
//                       customSpacerHeight(height: 12),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ]
//     ],
//   );
// }
//
// _employmentInfo() {
//   EmploymentStatusData? employmentStatus = Get.find<UserProfileController>()
//       .userDetails
//       ?.getOrganizationUserDetails
//       ?.employmentStatus;
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(
//         height: 40,
//         child: Text(
//           employmentStatus?.name ?? "",
//           style: AppStyle.mid_large_text.copyWith(
//               color: AppColor.normalTextColor,
//               overflow: TextOverflow.ellipsis,
//               fontSize: Dimensions.fontSizeMid),
//           maxLines: 1,
//         ),
//       ),
//       customSpacerWidth(width: 4),
//       Text(
//         "${AppString.text_from.tr} - ${getDateTimeFormat("")}",
//         style: AppStyle.mid_large_text.copyWith(
//             color: AppColor.hintColor,
//             fontSize: Dimensions.fontSizeDefault - 1),
//       ),
//     ],
//   );
// }
//
// _designationInfo() {
//   Designation? designation = Get.find<UserProfileController>()
//       .userDetails
//       ?.getOrganizationUserDetails
//       ?.designation;
//
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(
//         height: 40,
//         child: Text(
//           designation?.name ?? "",
//           style: AppStyle.mid_large_text.copyWith(
//               color: AppColor.normalTextColor,
//               overflow: TextOverflow.ellipsis,
//               fontSize: Dimensions.fontSizeMid),
//           maxLines: 1,
//         ),
//       ),
//       Text(
//         "${AppString.text_from.tr} - ${getDateTimeFormat("")}",
//
//         ///todo [api query]
//         style: AppStyle.mid_large_text.copyWith(
//             color: AppColor.hintColor,
//             fontSize: Dimensions.fontSizeDefault - 1),
//       ),
//     ],
//   );
// }
