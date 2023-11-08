import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        padding: marginLayout,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleText(context),
            _imageLayout(),

            OtpTextField(
              numberOfFields: 5,
              borderColor: AppColor.primaryColor,
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              margin: const EdgeInsets.all(15),
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              onSubmit: (String verificationCode) {

              }, // end onSubmit
            ),
            customSpacerHeight(height: 36),
            customSpacerHeight(height: 12),

          ],
        ),
      ),
    );
  }

  _titleText(context) {
    return   Center(child: Text(AppString.text_forgot_password,style:  GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.fontSizeLarge+2,
      color: AppColor.normalTextColor,


    ),));


  }





  _imageLayout() {
    return   Center(
      child: SizedBox(
          height: AppLayout.getHeight(200),
          width: AppLayout.getWidth(200),
          child: Image(image: AssetImage(Images.otp),fit: BoxFit.cover,)),
    );}





  // }


}
EdgeInsets get marginLayout {
  return EdgeInsets.only(
      left: AppLayout.getHeight(20), right: AppLayout.getWidth(20));
}