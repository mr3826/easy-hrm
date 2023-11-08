import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(width: double.infinity, decoration: linearGradient,
          child: _logoLayout()
      ),
    );
  }

  _logoLayout() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Image.asset(Images.app_logo)
      ],
    );
  }
}

BoxDecoration get linearGradient {
  return  const BoxDecoration(
  color: AppColor.backgroundColor
  );
}
