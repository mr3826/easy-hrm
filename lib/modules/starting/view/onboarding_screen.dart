// import 'package:payrun_mobile/common/widget/custom_spacer.dart';
// import 'package:payrun_mobile/utils/app_color.dart';
// import 'package:payrun_mobile/utils/app_string.dart';
// import 'package:payrun_mobile/utils/dimensions.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pay_day_mobile/common/widget/custom_appbar.dart';
// import 'package:pay_day_mobile/common/widget/custom_button.dart';
// import 'package:pay_day_mobile/common/widget/custom_spacer.dart';
// import 'package:pay_day_mobile/utils/app_color.dart';
// import 'package:pay_day_mobile/utils/app_string.dart';
// import 'package:pay_day_mobile/utils/dimensions.dart';
// import 'package:pay_day_mobile/utils/images.dart';
// import '../../../common/widget/custom_appbar.dart';
// import '../../../routes/app_pages.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final List _onboardImage = [
//     // Images.calendar,
//     // Images.easy_leave,
//   ];
//   final List _title = [
//      AppString.onboardTileMainAttend,
//      AppString.onboardTileEasy,
//   ];
//   final List _description = [
//     AppString.onboardTileMainAttendDes,
//     AppString.onboardTileEasyDes,
//   ];
//   final RxInt _currentIndex = 0.obs;
//   bool isleft = false;
//
//   leftRight() {
//     setState(() {
//       isleft = !isleft;
//     });
//   }
//
//   @override
//   void initState() {
//     Future.delayed(const Duration(milliseconds: 100), () {
//       leftRight();
//     });
//     super.initState();
//   }
//   final ExitAppController _controller = Get.put(ExitAppController());
//   @override
//   Widget build(BuildContext context) {
//     double _height = MediaQuery.of(context).size.height / 5;
//     double _width = MediaQuery.of(context).size.width;
//     return WillPopScope(
//       onWillPop: () =>_controller. willPop(),
//       child: Scaffold(
//           backgroundColor: AppColor.backgroundColor,
//           body: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 customSpacerHeight(height: 50),
//                 SizedBox(
//                     height: _height,
//                     width: _width,
//                     child: Stack(
//                       children: [_headerLayout(isLeft: isleft)],
//                     )),
//                 Obx(() => Expanded(
//                     flex: 2,
//                     child: _onboardByImage(
//                         imageUrl: _onboardImage[_currentIndex.toInt()]))),
//                 customSpacerHeight(height: 25),
//                 Obx(() =>
//                     _onboardTitleText(text: '${_title[_currentIndex.toInt()]}')),
//                 customSpacerHeight(height: 20),
//                 Obx(() => _descriptionText(
//                     text: '${_description[_currentIndex.toInt()]}')),
//                 customSpacerHeight(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Obx(
//                           () => _dotsDecorator(
//                           onboardImg: _onboardImage.length,
//                           currentIndex: _currentIndex.toDouble()),
//                     ),
//                   ],
//                 ),
//                 customSpacerHeight(height: 30),
//                 _buttonLayout(
//                     context: context,
//                     titleText: _title,
//                     currentIndex: _currentIndex)
//               ],
//             ),
//           )),
//     );
//   }
// }
//
// Widget _skipButton({context}) {
//   return TextButton(
//     onPressed: (){},
//     child: Text(
//       AppString.text_skip,
//       style: GoogleFonts.poppins(
//           fontSize: Dimensions.fontSizeMid,
//           color: AppColor.primaryColor,
//           fontWeight: FontWeight.w600),
//     ),
//   );
// }
//
// Widget _buttonLayout({context, currentIndex, titleText}) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       _skipButton(context: context),
//       // CustomSmallButton(AppString.text_next, () {
//       //   if (currentIndex == titleText.length - 1) {
//       //     Get.offAndToNamed(Routes.SIGN_IN);
//       //   } else {
//       //     currentIndex + 1;
//       //   }
//       // }),
//     ],
//   );
// }
//
//
//
//
//
// Widget _headerLayout({isLeft}) {
//   return Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: AnimatedContainer(
//       duration: const Duration(milliseconds: 400),
//       alignment: isLeft ? Alignment.topCenter : Alignment.topRight,
//       curve: Curves.easeInOut,
//       child: svgIcon(),
//     ),
//   );
// }
//
// Widget _dotsDecorator({required onboardImg, required currentIndex}) {
//   return DotsIndicator(
//     dotsCount: onboardImg,
//     position: currentIndex,
//     decorator: const DotsDecorator(
//         color: AppColor.disableColor,
//         activeColor: AppColor.primaryColor,
//         size: Size.square(8.0),
//         activeSize: Size(16.0, 7),
//         activeShape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.horizontal(
//                 right: Radius.circular(5.0), left: Radius.circular(5.0)))),
//   );
// }
//
// Widget _onboardByImage({required imageUrl}) {
//   return Center(
//     child: SvgPicture.asset(
//       imageUrl.toString(),
//     ),
//   );
// }
//
//
// Widget _descriptionText({required text}) {
//   return Text(
//     text,
//     style: GoogleFonts.poppins(
//         fontSize: Dimensions.fontSizeMid, fontWeight: FontWeight.w300),
//   );
// }
//
// Widget _onboardTitleText({text}) {
//   return Text(
//     text,
//     style: GoogleFonts.poppins(
//         fontWeight: FontWeight.bold,
//         fontSize: Dimensions.fontSizeLarge+7,
//         color: AppColor.normalTextColor),
//   );
// }
//
// class ExitAppController extends GetxController {
//   Future<bool> willPop() async{
//     if (Platform.isAndroid) {
//       SystemNavigator.pop();
//     } else if (Platform.isIOS) {
//       exit(0);}
//     return false;
//   }
// }