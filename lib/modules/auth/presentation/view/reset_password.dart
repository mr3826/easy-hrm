import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/forgot_password.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

import '../../../../utils/utils.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body: Container(
      padding: marginLayout,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customSpacerHeight(height: 50),
            _imageLayout(),
            customSpacerHeight(height: 50),
            _codeTitleText(),
            customSpacerHeight(height: 6),
            Center(child: Text(AppString.text_setup_your_code_etc.tr,style: style,)),
            customSpacerHeight(height: 40),

            _newPasswordLayout(),
            customSpacerHeight(height: 20),

            _confirmPasswordLayout(),
            customSpacerHeight(height: 36),
            customSpacerHeight(height: 12),
            _submitBtnLayout(),
            customSpacerHeight(height: 22),

            _backToLoginLayout(),


          ],
        ),
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

  _submitBtnLayout() {
    return CustomAppButton(
      buttonText: Text(
        AppString.text_submit.tr,overflow: TextOverflow.ellipsis,
        style: AppStyle.normal_text.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: ()=>Get.toNamed(Routes.PASSWORD_UPDATE_SCRREN),
      buttonColor: AppColor.primaryColor,
      isButtonExpanded: false,
      btnTextSize: Dimensions.fontSizeMid+2,

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
          child:SvgPicture.asset(Images.reset_password,fit: BoxFit.cover)
      ),
    );}

  _newPasswordLayout() {

    return CustomInputField(
      hint: AppString.text_new_password.tr,
      prefixIcon: Icons.lock_open,
      controller: newPasswordController,
    );
  }
  _confirmPasswordLayout() {
    return CustomInputField(
      hint: AppString.text_confirm_password,
      prefixIcon: Icons.lock_open,
      controller: confirmPasswordController,
    );
  }


}
