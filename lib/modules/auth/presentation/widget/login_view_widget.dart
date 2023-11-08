// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pay_day_mobile/common/widget/custom_appbar.dart';
// import 'package:pay_day_mobile/common/widget/custom_button.dart';
// import 'package:pay_day_mobile/utils/app_color.dart';
// import 'package:pay_day_mobile/utils/app_layout.dart';
// import 'package:pay_day_mobile/utils/app_string.dart';
// import 'package:pay_day_mobile/utils/app_style.dart';
// import 'package:pay_day_mobile/utils/dimensions.dart';
// import '../../../../common/widget/custom_spacer.dart';
//
// Widget logInButton({required onAction}) {
//   return Padding(
//     padding: buttonPadding,
//     child: CustomButton(AppString.text_log_in, () => onAction()),
//   );
// }
//
// EdgeInsets get buttonPadding {
//   return EdgeInsets.only(
//       left: AppLayout.getWidth(18), right: AppLayout.getWidth(18));
// }
//
// Widget containerLayout({isLeft}) {
//   return Padding(
//     padding: EdgeInsets.only(
//         left: AppLayout.getWidth(20),
//         right: AppLayout.getWidth(20),
//         top: AppLayout.getHeight(20),
//         bottom: AppLayout.getHeight(20)),
//     child: animatedContainer(isLeft: isLeft),
//   );
// }
//
// Widget animatedContainer({required isLeft}) {
//   return AnimatedContainer(
//     duration: const Duration(milliseconds: 400),
//     alignment: isLeft ? Alignment.topCenter : Alignment.topRight,
//     curve: Curves.easeInOut,
//     child: svgIcon(width: 44, height: 44),
//   );
// }
//
// Widget rememberText() {
//   return Text(
//     AppString.text_remember_me,
//     style: AppStyle.normal_text_grey.copyWith(
//       color: AppColor.normalTextColor.withOpacity(0.7),
//       letterSpacing: 0.2,
//       fontWeight: FontWeight.w600,
//     ),
//   );
// }
//
// Widget forgotButton({required onAction}) {
//   return TextButton(
//       style: TextButton.styleFrom(
//           padding: EdgeInsets.zero,
//           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           alignment: Alignment.centerLeft),
//       onPressed: () => onAction(),
//       child: Text(AppString.text_forgot_password,
//           style: GoogleFonts.poppins(
//               fontSize: Dimensions.fontSizeDefault,
//               color: AppColor.primaryColor,
//               fontWeight: FontWeight.w500,
//               letterSpacing: 0.2)));
// }
//
// Widget bodyContent() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         "login".tr,
//         style: GoogleFonts.poppins(
//             fontWeight: FontWeight.w600,
//             fontSize: Dimensions.fontSizeLarge + 5),
//       ),
//       customSpacerHeight(height: Dimensions.fontSizeDefault - 7),
//       titleSubText(),
//       customSpacerHeight(height: Dimensions.fontSizeLarge - 6),
//     ],
//   );
// }
//
// Widget titleSubText() {
//   return Text(
//     'login_to_your_dashboard'.tr,
//     style: GoogleFonts.poppins(
//         fontWeight: FontWeight.w400,
//         fontSize: Dimensions.fontSizeMid - 2,
//         color: AppColor.hintColor,
//         letterSpacing: 0.3),
//   );
// }
