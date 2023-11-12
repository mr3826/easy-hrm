import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/forgot_password.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        padding: marginLayout,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageLayout(),
            customSpacerHeight(height: 50),

            _codeTitleText(),
            customSpacerHeight(height: 6),

            Center(child: Text(AppString.text_a_5_digit_has_been_etc.tr,style: style,)),
            customSpacerHeight(height: 30),

            OtpTextField(
              numberOfFields: 5,
              borderColor: AppColor.primaryColor,
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              margin: const EdgeInsets.all(4),
              fieldWidth: AppLayout.getWidth(60),
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              onSubmit: (String verificationCode) {


              }, // end onSubmit
            ),
            customSpacerHeight(height: 36),
            customSpacerHeight(height: 12),

            _resendCodeBtnLayout(),
            customSpacerHeight(height: 22),

            _backToLoginLayout(),


          ],
        ),
      ),
    );
  }

  _codeTitleText() {
    return   Center(child: Text(AppString.text_enter_code.tr,style:  TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.fontSizeLarge+2,
      color: AppColor.normalTextColor,
        fontFamily: "Poppins"


    ),));
  }

  _resendCodeBtnLayout() {
    return AppButton(
      buttonText: Text(
        AppString.text_resend_code.tr,overflow: TextOverflow.ellipsis,
        style: AppStyle.normal_text.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: ()=>Get.toNamed(Routes.RESET_PASSWORD),
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

  _imageLayout() {
    return   Center(
      child: SizedBox(
          height: AppLayout.getHeight(200),
          width: AppLayout.getWidth(200),
          child:SvgPicture.asset(Images.otp,fit: BoxFit.cover)),
    );}
}
EdgeInsets get marginLayout {
  return EdgeInsets.only(
      left: AppLayout.getHeight(20), right: AppLayout.getWidth(20));
}