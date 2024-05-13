import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_style.dart';
import '../../../utils/dimensions.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  int _currentIndex = 0;
  final ExitAppController _controller = Get.put(ExitAppController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _controller.willPop(),
      child: Scaffold(
          body: PageView.builder(
        controller: _pageController,
        itemCount: onboardInfoList.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              AspectRatio(
                aspectRatio: 2,
                child:
                    _onboardByImage(imageUrl: onboardInfoList[index]["image"]),
              ),
              const Spacer(),
              Padding(
                padding: marginLayout,
                child: Container(
                  decoration: AppStyle.ContainerStyle.copyWith(
                      color: AppColor.bgColorWithPrimary,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusMid + 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List.generate(onboardInfoList.length, (index) {
                            return ActiveDot(
                              isActive: _currentIndex == index,
                            );
                          }),
                        ),
                        customSpacerHeight(height: 20),
                        _onboardTitleText(
                            text: onboardInfoList[index]["title"]),
                        customSpacerHeight(height: 12),
                        _descriptionText(
                            text: onboardInfoList[index]["description"]),
                        customSpacerHeight(height: 70),
                        _buttonLayout(
                            index: _currentIndex,
                            onAction: () {
                              setState(() {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              });

                              if (_currentIndex == 2) {
                                GetStorage().write(
                                    AppString.IS_LOGGED_IN_FIRST_TIME, false);
                                Get.offAndToNamed(Routes.SIGN_IN_SCREEN);
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              customSpacerHeight(height: 20),
            ],
          );
        },
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

Widget _buttonLayout({context, onAction, int index = 0}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: onAction,
        child: CircleAvatar(
          radius: 27,
          backgroundColor: AppColor.primaryColor,
          child: index == 2
              ? const Icon(
                  Icons.done,
                  color: AppColor.backgroundColor,
                )
              : const Icon(
                  Icons.arrow_forward,
                  color: AppColor.backgroundColor,
                ),
        ),
      ),
      _skipButton(context: context),
    ],
  );
}

class ActiveDot extends StatelessWidget {
  final bool isActive;
  const ActiveDot({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: 9,
          backgroundColor:
              isActive ? AppColor.primaryColor : Colors.transparent,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: isActive ? AppColor.cardColor : Colors.transparent,
            child: CircleAvatar(
              radius: 6,
              backgroundColor: isActive
                  ? AppColor.primaryColor
                  : AppColor.primaryColor.withOpacity(0.6),
            ),
          ),
        ));
  }
}

Widget _descriptionText({required text}) {
  return Text(
    text,
    style: TextStyle(
        color: AppColor.hintColor,
        fontFamily: "Poppins",
        fontSize: Dimensions.fontSizeDefault,
        fontWeight: FontWeight.w300),
    textAlign: TextAlign.center,
  );
}

Widget _onboardTitleText({text}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins",
      fontSize: Dimensions.fontSizeMid,
      color: AppColor.normalTextColor,
    ),
    textAlign: TextAlign.center,
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

class ExitAppController extends GetxController {
  Future<bool> willPop() async {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
    return false;
  }

  Future<bool> willPopForTimeLog() async {
    return false;
  }
}
