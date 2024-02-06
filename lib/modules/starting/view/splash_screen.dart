import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/images.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<SplashController>()) {
      Get.delete<SplashController>();
    }
    Get.put(SplashController());
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: decorationStyle,
          child: _logoLayout()),
    );
  }

  _logoLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Images.splash_logo),
        customSpacerHeight(height: 50)
      ],
    );
  }
}

BoxDecoration get decorationStyle {
  return const BoxDecoration(color: AppColor.backgroundColor);
}
