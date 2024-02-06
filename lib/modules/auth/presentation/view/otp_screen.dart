import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
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

import '../../../../common/widget/warning_message.dart';
import '../controller/forgot_password_controller.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final String emailAddress = Get.arguments[0];
  int seconds = 59;
  bool timerActive = false;
  bool isOTPProvided = false;
  String OTPCode = "";

  void startTimer() {
    setState(() {
      timerActive = true;
    });

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (seconds == 0) {
        timer.cancel();
        setState(() {
          timerActive = false;
        });
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: marginLayout,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customSpacerHeight(height: 50),
                _imageLayout(),
                customSpacerHeight(height: 50),
                _codeTitleText(),
                customSpacerHeight(height: 6),
                Center(
                    child: Text(
                  "${AppString.text_a_6_digit_has_been_etc.tr}$emailAddress",
                  textAlign: TextAlign.center,
                  style: style,
                )),
                customSpacerHeight(height: 30),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: AppColor.primaryColor,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  margin: const EdgeInsets.all(4),
                  fieldWidth: AppLayout.getWidth(45),
                  onSubmit: (String verificationCode) {
                    log(verificationCode);
                    OTPCode = verificationCode;
                    setState(() {
                      isOTPProvided = true;
                    });
                  }, // end onSubmit
                ),
                customSpacerHeight(height: 36),
                _resetBtnLayout(),
                customSpacerHeight(height: 12),
                _confirmBtnLayout(),
                customSpacerHeight(height: 22),
                _backToLoginLayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _resetBtnLayout() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        AppString.text_do_not_receive_otp.tr,
        style: style,
      ),
      customSpacerWidth(width: 8),
      timerActive == true
          ? Text("$seconds s")
          : InkWell(
              onTap: () async {
                await Get.find<ForgotPasswordController>()
                    .resendOtp(mailAddress: emailAddress);
                seconds = 59;
                startTimer();
              },
              child: Text(AppString.text_resend,
                  style: TextStyle(color: Colors.blue.shade900, fontSize: 18)),
            ),
    ]);
  }

  _codeTitleText() {
    return Center(
        child: Text(
      AppString.text_enter_code.tr,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeLarge + 2,
          color: AppColor.normalTextColor,
          fontFamily: "Poppins"),
    ));
  }

  _confirmBtnLayout() {
    return CustomAppButton(
      buttonText: Get.find<ForgotPasswordController>().isLoading.isTrue
          ? const CupertinoActivityIndicator(
              color: Colors.white,
            )
          : Text(
              AppString.confirmText.tr,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.normal_text.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
      onPressed: () async {
        if (OTPCode.isNotEmpty && OTPCode.length == 6) {
          Get.toNamed(Routes.RESET_PASSWORD,
              arguments: [OTPCode, emailAddress]);
        } else {
          showWarningMessage(message: AppString.validOtpText.tr);
        }
      },
      buttonColor: isOTPProvided == false
          ? AppColor.primaryColor.withOpacity(.5)
          : AppColor.primaryColor,
      btnTextSize: Dimensions.fontSizeMid + 2,
      isButtonExpanded: false,
    );
  }

  _backToLoginLayout() {
    return GestureDetector(
        onTap: () => Get.toNamed(Routes.SIGN_IN_SCREEN),
        child: Center(
            child: Text(
          AppString.text_back_to_login.tr,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeDefault + 2),
        )));
  }

  _imageLayout() {
    return Center(
      child: SizedBox(
          height: AppLayout.getHeight(200),
          width: AppLayout.getWidth(200),
          child: SvgPicture.asset(Images.otp, fit: BoxFit.cover)),
    );
  }
}

EdgeInsets get marginLayout {
  return EdgeInsets.only(
      left: AppLayout.getHeight(20), right: AppLayout.getWidth(20));
}
