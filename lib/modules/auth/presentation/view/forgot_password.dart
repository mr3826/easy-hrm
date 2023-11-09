import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/input_controller.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingLarge),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customSpacerHeight(height: 50),
                _imageLayout(),
                customSpacerHeight(height: 50),
              _forgotTitleText(),
                customSpacerHeight(height: 12),

                Center(child: Text(AppString.text_dont_not_worry.tr,style: style,)),
                Center(child: Text(AppString.text_associated.tr,style: style,)),
                _emailAddressLayout(),
                customSpacerHeight(height: 40),

                _sendCodeBtnLayout(),
                customSpacerHeight(height: 40),
                _backToLoginLayout(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  _imageLayout() {
    return   Center(
      child: SizedBox(
          height: AppLayout.getHeight(200),
          width: AppLayout.getWidth(200),
          child: Image(image: AssetImage(Images.forgot),fit: BoxFit.cover,)),
    );
  }
  _emailAddressLayout() {
    var controller = Get.find<InputController>();

    return AppInputField(
      hint: AppString.text_email,
      prefixIcon: Icons.email_outlined,
      controller: controller.restPasswordController,
    );
  }

  _sendCodeBtnLayout() {
    return AppButton(
      buttonText: AppString.text_send_code.tr,
      onPressed: ()=>Get.toNamed(Routes.OTP),
      buttonColor: AppColor.primaryColor,
      btnTextSize: Dimensions.fontSizeMid+2,
      isButtonExpanded: false,
    );
  }

  _backToLoginLayout() {
    return GestureDetector(
        onTap: ()=>Get.toNamed(Routes.SIGN_IN_SCREEN),
        child: Center(child: Text(AppString.text_back_to_login.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault+2),)));

  }

  _forgotTitleText() {
    return   Center(child: Text(AppString.text_forgot_password,style:  TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.fontSizeLarge+2,
      color: AppColor.normalTextColor,
        fontFamily: "Poppins"


    ),));
  }

}

TextStyle get style{
  return   TextStyle(
  color: AppColor.normalTextColor.withOpacity(0.7),
      fontFamily: "Poppins",
  fontSize: Dimensions.fontSizeMid-5, fontWeight: FontWeight.w300);
}