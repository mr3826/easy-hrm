import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/forgot_password.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class PasswordUpdateScreen extends StatelessWidget {
  const PasswordUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: marginLayout,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _passwordUpdateText(),
            customSpacerHeight(height: 12),
            Center(
                child: Text(
              AppString.text_your_password_has_been_etc.tr,
              style: style,
            )),
            Center(
                child: Text(
              AppString.text_password_to_log_in.tr,
              style: style,
            )),
            customSpacerHeight(height: 40),
            _continueBtnLayout()
          ],
        ),
      ),
    );
  }

  _passwordUpdateText() {
    return Center(
        child: Text(
      AppString.text_password_update.tr,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeLarge + 2,
          color: AppColor.normalTextColor,
          fontFamily: "Poppins"),
    ));
  }

  _continueBtnLayout() {
    return AppButton(
      buttonText: Text(
        AppString.text_continue.tr,
        overflow: TextOverflow.ellipsis,
        style: AppStyle.normal_text.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      btnTextSize: Dimensions.fontSizeMid + 2,
      onPressed: () {
        Get.toNamed(Routes.SIGN_IN_SCREEN);
      },
      buttonColor: AppColor.primaryColor,
      isButtonExpanded: false,
    );
  }
}
