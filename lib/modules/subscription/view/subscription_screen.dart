import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(child: Text("Your access to the app has been restricted due to the expiration of your subscription. Please contact the administrator for assistance.",style: AppStyle.small_text_black,textAlign: TextAlign.center,)),
    );
  }
}
