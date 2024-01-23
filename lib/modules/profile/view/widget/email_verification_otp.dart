import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/screen/chnage_email.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Future otpVerificationLayout(context) {
  final selectedValue = Get.put(SelectedOtpVerifyController());

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 18),
              color: AppColor.cardColor,
              height: AppLayout.getHeight(70),
              width: AppLayout.getWidth(70),
              child: customSvgImage(imageUrl: Images.EMAIL_POP),
            ),
            customSpacerHeight(height: 12),
            Text(
              AppString.text_verify_your_email_address.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault + 3),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Center(
                  child: Text(
                AppString.text_we_have_sent_a_verification_etc.tr,
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: Dimensions.fontSizeDefault - 3),
                textAlign: TextAlign.center,
              )),
            ),
            const OtpLayout(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.text_do_not_receive_email.tr,
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.normalTextColor,
                      fontSize: Dimensions.fontSizeDefault),
                ),
                GestureDetector(
                    onTap: () {
                      Get.find<UserProfileController>()
                          .resendOtp(emailAddress: changeEmailController.text);
                    },
                    child: Text(
                      AppString.text_resend.tr,
                      style: AppStyle.normal_text_grey.copyWith(
                          color: AppColor.primaryColor,
                          fontSize: Dimensions.fontSizeDefault),
                    )),
              ],
            ),
            customSpacerHeight(height: 16),
            Obx(
              () => Get.find<UserProfileController>()
                      .isVerificationApiLoading
                      .isTrue
                  ? const Center(
                      child: CupertinoActivityIndicator(
                          color: Colors.blueAccent, radius: 12))
                  : _verifyBtnLayout(verifyAction: () {
                      selectedValue.isSelected(true);
                      Navigator.pop(context);
                    }, closeAction: () {
                      selectedValue.isSelected(true);
                      Navigator.pop(context);
                    }),
            ),
            customSpacerHeight(height: 16)
          ],
        ),
      ),
    ),
  );
}

_verifyBtnLayout({verifyAction, closeAction}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8),
    child: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: closeAction,
            child: SizedBox(
              height: AppLayout.getHeight(50),
              child: Card(
                elevation: 0,
                shape: roundedRectangleBorder.copyWith(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radiusExtraLarge,
                    ),
                    side: const BorderSide(
                        width: 1, color: AppColor.hintColor)), //close
                color: AppColor.cardColor,
                child: Center(
                    child: Text(
                  "close",
                  style: AppStyle.small_text_black.copyWith(
                      color: AppColor.hintColor,
                      fontSize: Dimensions.fontSizeDefault),
                )),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: verifyAction,
            child: SizedBox(
              height: AppLayout.getHeight(50),
              child: Card(
                elevation: 0,
                shape: roundedRectangleBorder.copyWith(
                    borderRadius: BorderRadius.circular(
                        Dimensions.radiusExtraLarge)), //close
                color: AppColor.primaryColor,
                child: Center(
                    child: Text(
                  "Verify",
                  style: AppStyle.small_text_black.copyWith(
                      color: AppColor.cardColor,
                      fontSize: Dimensions.fontSizeDefault),
                )),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class OtpLayout extends StatelessWidget {
  const OtpLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PinCodeTextField(
        appContext: context,
        length: 6,
        onChanged: (value) {
          // Handle OTP changes
          print("value :: $value");
        },
        onCompleted: (verificationCode) {
          Get.find<UserProfileController>()
              .submitVerificationCode(verificationCode: verificationCode);
        },
        backgroundColor: Colors.white,
        keyboardType: TextInputType.number,
        cursorColor: AppColor.primaryColor,
        animationType: AnimationType.fade,
        onSubmitted: (verificationCode) {
          Get.find<UserProfileController>()
              .submitVerificationCode(verificationCode: verificationCode);
        },
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          inactiveColor: AppColor.hintColor,
          selectedColor: AppColor.primaryColor,
          activeColor: Colors.black,
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          disabledColor: AppColor.hintColor,
          borderWidth: 1,
          activeBorderWidth: 1,
          disabledBorderWidth: 1,
          selectedFillColor: AppColor.primaryColor,
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
        ),
      ),
    );
  }
}
