import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/presentation/view/chnage_email.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

Future otpVerificationLayout(context) {
  final selectedValue=Get.put(SelectedOtpVerifyController());

  return showDialog(context: context, builder: (context) => Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      height: AppLayout.getHeight(400),
      decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(12)
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: marginLayout,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 18),
                  color: AppColor.cardColor,
                  height: AppLayout.getHeight(70),width: AppLayout.getWidth(70),

                  child: customSvgImage(imageUrl: Images.EMAIL_POP),
                ),
                customSpacerHeight(height: 12),

                Text(AppString.text_verify_your_email_address.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault+3),),
                customSpacerHeight(height: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text(AppString.text_we_have_sent_a_verification_etc.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-3),)),
                  ],
                ),
                customSpacerHeight(height: 12),
              ],
            ),
          ),

          customSpacerHeight(height: 12),
          Row(
            children: [
              Expanded(
                child: OtpTextField(
                  numberOfFields: 6,
                  borderColor: AppColor.primaryColor,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  cursorColor: AppColor.secondaryColor,
                  enabledBorderColor: AppColor.normalTextColor,
                  //runs when a code is typed in
                  borderWidth: .4,
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  onSubmit: (String verificationCode) {}, // end onSubmit
                ),
              ),
            ],
          ),

          customSpacerHeight(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppString.text_do_not_receive_email.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault),),
              GestureDetector(
                  onTap: (){},
                  child: Text(AppString.text_resend.tr,style: AppStyle.normal_text_grey.copyWith(color: AppColor.primaryColor,fontSize: Dimensions.fontSizeDefault),)),
            ],
          ),

          const Spacer(),

          Padding(
            padding: marginLayout,
            child: CustomDoubleAppButton(buttonText: AppString.text_continue.tr, onAction: (){}, cancelAction: (){

              selectedValue.isSelected(true);
              Navigator.pop(context);
              Get.toNamed(Routes.MAIN_SCREEN);

            }),
          ),
          customSpacerHeight(height: 16),


        ],
      ),
    ),

  ));
}