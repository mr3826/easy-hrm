import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/forgot_password.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/widget/common_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../common/widget/warning_message.dart';
import '../../controller/forgot_password_controller.dart';
import '../../controller/otp_controller.dart';

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
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),

                    ///Otp image
                    imageLayout(url: Images.otp),
                    customSpacerHeight(height: 50),

                    ///Title Text
                    _codeTitleText(),
                    customSpacerHeight(height: 6),

                    ///Description Text
                    _descriptionText(),
                    customSpacerHeight(height: 30),

                    ///Otp layout
                    _otpLayout(),
                    customSpacerHeight(height: 15),

                    ///Resend otp button
                    _resendBtnLayout(),
                    customSpacerHeight(height: 18),

                    ///Confirm button
                    _confirmBtnLayout(),
                    customSpacerHeight(height: 22),

                    ///Back login button
                    backToLoginLayout(),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _resendBtnLayout() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        AppString.text_do_not_receive_otp.tr,
        style: style,
      ),
      customSpacerWidth(width: 4),
      timerActive == true
          ? Text("$seconds s")
          : GestureDetector(
              onTap: () async {
                await Get.find<OtpController>()
                    .resendOtp(mailAddress: emailAddress);
                seconds = 59;
                startTimer();
              },
              child: Obx(() =>
                  Get.find<OtpController>().isResendLoading.isTrue
                      ? const CupertinoActivityIndicator(
                          color: AppColor.primaryColor,
                        )
                      : Text(AppString.text_resend,
                          style: TextStyle(
                              color: AppColor.secondaryColor,
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.bold))),
            ),
    ]);
  }

  _codeTitleText() {
    return Center(
        child: Text(
      AppString.text_enter_code.tr,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeMid - 2,
          color: AppColor.normalTextColor,
          fontFamily: "Poppins"),
    ));
  }

  _descriptionText() {
    return Text(
      AppString.text_we_have_sent_a_verification_etc.tr,
      textAlign: TextAlign.center,
      style: style.copyWith(
          fontSize: Dimensions.fontSizeDefault - 2, color: AppColor.hintColor),
    );
  }

  _confirmBtnLayout() {
    return Obx(() => CustomAppButton(
          buttonText: Get.find<OtpController>().isLoading.isTrue
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : Text(
                  AppString.confirmText.tr,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.normal_text.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.fontSizeMid),
                ),
          onPressed: () async {
            if (OTPCode.isNotEmpty && OTPCode.length == 6) {
              Get.find<OtpController>().verifyOtp(confirmationCode: OTPCode);
            } else {
              showWarningMessage(message: AppString.validOtpText.tr);
            }
          },
          buttonColor: isOTPProvided == false
              ? AppColor.primaryColor.withOpacity(.5)
              : AppColor.primaryColor,
          btnTextSize: Dimensions.fontSizeMid + 2,
          isButtonExpanded: false,
        ));
  }

  _otpLayout() {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      onChanged: (verificationCode) {
        // Handle OTP changes
        log("value :: $verificationCode");
        OTPCode = verificationCode;
      },
      onCompleted: (verificationCode) {
        setState(() {
          isOTPProvided = true;
        });
      },
      backgroundColor: Colors.white,
      keyboardType: TextInputType.number,
      cursorColor: AppColor.primaryColor,
      animationType: AnimationType.fade,
      onSubmitted: (verificationCode) {
        log(verificationCode);
        OTPCode = verificationCode;
        setState(() {
          isOTPProvided = true;
        });
      },
      pinTheme: _pinThemStyle(),
    );
  }

  _pinThemStyle() {
    return PinTheme(
      shape: PinCodeFieldShape.box,
      inactiveColor: AppColor.disableColor.withOpacity(0.7),
      selectedColor: AppColor.primaryColor,
      activeColor: Colors.black,
      borderRadius: BorderRadius.circular(Dimensions.radiusDefault - 4),
      disabledColor: AppColor.disableColor,
      borderWidth: 0.5,
      activeBorderWidth: 0.5,
      disabledBorderWidth: 0.5,
      selectedFillColor: AppColor.primaryColor,
      fieldHeight: 50,
      fieldWidth: Get.size.width / 7.5,
      activeFillColor: Colors.white,
    );
  }
}

EdgeInsets get marginLayout {
  return EdgeInsets.only(
      left: AppLayout.getHeight(20), right: AppLayout.getWidth(20));
}
