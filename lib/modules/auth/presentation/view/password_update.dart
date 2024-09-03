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
import '../../../../utils/images.dart';

class PasswordUpdateScreen extends StatelessWidget {
  const PasswordUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: marginLayout,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  ///Password updated image
                  imageLayout(url: Images.passwordResetSuccessfully),
                  customSpacerHeight(height: 50),

                  ///Title text
                  _passwordUpdateTitleText(),
                  customSpacerHeight(height: 6),

                  ///Description
                  _descriptionText(),
                  customSpacerHeight(height: 25),

                  ///Continue button
                  _continueBtnLayout(),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _descriptionText() {
    return Text(
      "${AppString.text_your_password_has_been_etc.tr} ${AppString.text_password_to_log_in.tr}",
      textAlign: TextAlign.center,
      style: style.copyWith(
          fontSize: Dimensions.fontSizeDefault - 2, color: AppColor.hintColor),
    );
  }

  _passwordUpdateTitleText() {
    return Center(
        child: Text(
      AppString.text_password_update.tr,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeMid - 2,
          color: AppColor.normalTextColor,
          fontFamily: "Poppins"),
    ));
  }

  _continueBtnLayout() {
    return CustomAppButton(
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
