import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/images.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({super.key});

  final List _onboardImage = [
    Images.employee_on,
    Images.time_log_on,
    Images.leave_on,
  ];

  final List _title = [
    AppString.text_mange_your_employee,
    AppString.text_track_your_time,
    AppString.text_manage_your_leave,
  ];

  final List _description = [
    AppString.text_mange_your_employee_with,
    AppString.text_with_the_help_etc,
    AppString.text_leave_management_etc,
  ];

  final RxInt _currentIndex = 0.obs;
  final ExitAppController _controller = Get.put(ExitAppController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _controller.willPop(),
      child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Expanded(
                      flex: 2,
                      child: _onboardByImage(
                          imageUrl: _onboardImage[_currentIndex.toInt()]),
                    )),
                customSpacerHeight(height: 25),
                Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      decoration: AppStyle.ContainerStyle.copyWith(
                          color: AppColor.primaryColor.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => _dotsDecorator(
                                  onboardImg: _onboardImage.length,
                                  currentIndex: _currentIndex.toInt()),
                            ),
                            Obx(() => _onboardTitleText(
                                text: '${_title[_currentIndex.toInt()]}')),
                            Obx(() => _descriptionText(
                                text:
                                    '${_description[_currentIndex.toInt()]}')),
                            _buttonLayout(
                                titleText: _title,
                                context: context,
                                currentIndex: _currentIndex)
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}

Widget _skipButton({context}) {
  return TextButton(
    onPressed: () async {
      await GetStorage().write(AppString.IS_LOGGED_IN_FIRST_TIME, false);
      Get.toNamed(Routes.SIGN_IN_SCREEN);
    },
    child: Text(
      AppString.text_skip,
      style: TextStyle(
          fontSize: Dimensions.fontSizeDefault,
          color: AppColor.primaryColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500),
    ),
  );
}

Widget _buttonLayout({context, currentIndex, titleText}) {

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () async{
          if (currentIndex == titleText.length - 1) {
            await GetStorage().write(AppString.IS_LOGGED_IN_FIRST_TIME, false);
            Get.offAndToNamed(Routes.SIGN_IN_SCREEN);
          } else {
            currentIndex + 1;
          }
        },
        child: const CircleAvatar(
          radius: 27,
          backgroundColor: AppColor.primaryColor,
          child: Icon(
            Icons.arrow_forward,
            color: AppColor.backgroundColor,
          ),
        ),
      ),
      _skipButton(context: context),
    ],
  );
}

Widget _dotsDecorator({required onboardImg, required currentIndex}) {
  return DotsIndicator(
    dotsCount: onboardImg,
    position: currentIndex,
    decorator: const DotsDecorator(
        color: AppColor.backgroundColor,
        activeColor: AppColor.primaryColor,
        size: Size.square(10.0),
        activeSize: Size(18.0, 7),
        activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(5.0), left: Radius.circular(5.0)))),
  );
}

Widget _onboardByImage({required imageUrl}) {
  return Center(
    child: SvgPicture.asset(
      imageUrl.toString(),
      fit: BoxFit.cover,
    ),
  );
}

Widget _descriptionText({required text}) {
  return Text(
    text,
    style: TextStyle(
        color: AppColor.normalTextColor.withOpacity(0.5),
        fontFamily: "Poppins",
        fontSize: Dimensions.fontSizeMid - 2,
        fontWeight: FontWeight.w300),
  );
}

Widget _onboardTitleText({text}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins",
      fontSize: Dimensions.fontSizeLarge + 2,
      color: AppColor.normalTextColor,
    ),
  );
}

class ExitAppController extends GetxController {
  Future<bool> willPop() async {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
    return false;
  }
}
