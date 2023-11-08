import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payrun_mobile/common/input_controller.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/sign_in.dart';
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
      buttonText: AppString.text_sign_in,
      onPressed: () {},
      buttonColor: AppColor.primaryColor,
      isButtonExpanded: false,
    );
  }

  _backToLoginLayout() {
    return GestureDetector(
        onTap: ()=>Get.toNamed(Routes.SIGN_IN_SCREEN),
        child: Center(child: Text(AppString.text_back_to_login.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),)));

  }

  _forgotTitleText() {
    return   Center(child: Text(AppString.text_forgot_password,style:  GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.fontSizeLarge+2,
      color: AppColor.normalTextColor,


    ),));
  }

}

TextStyle get style{
  return   GoogleFonts.poppins(
  color: AppColor.normalTextColor.withOpacity(0.7),
  fontSize: Dimensions.fontSizeMid-3, fontWeight: FontWeight.w300);
}