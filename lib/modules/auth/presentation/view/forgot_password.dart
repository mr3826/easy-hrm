import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/modules/auth/presentation/controller/forgot_password_controller.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../utils/utils.dart';

class ForgotScreen extends GetView<ForgotPasswordController> {
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
                Center(
                    child: Text(
                  AppString.text_dont_not_worry.tr,
                  style: style,
                )),
                Center(
                    child: Text(
                  AppString.text_associated.tr,
                  style: style,
                )),
                customSpacerHeight(height: 40),
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
    return Center(
      child: SizedBox(
          height: AppLayout.getHeight(200),
          width: AppLayout.getWidth(200),
          child: SvgPicture.asset(Images.forgot, fit: BoxFit.cover)),
    );
  }

  _emailAddressLayout() {
    return CustomInputField(
      hint: AppString.text_email,
      prefixIcon: Icons.email_outlined,
      controller: restPasswordController,
    );
  }

  _sendCodeBtnLayout() {
    return Obx(() => CustomAppButton(
          buttonText: controller.isLoading.isTrue
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : Text(
                  AppString.text_send_code.tr,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.normal_text.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          onPressed: () async {
            await controller.forgotPassword();
          },
          buttonColor: AppColor.primaryColor,
          btnTextSize: Dimensions.fontSizeLarge,
          isButtonExpanded: false,
        ));
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

  _forgotTitleText() {
    return Center(
        child: Text(
      AppString.text_forgot_password,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeLarge,
          color: AppColor.normalTextColor,
          fontFamily: "Poppins"),
    ));
  }
}

TextStyle get style {
  return TextStyle(
      color: AppColor.normalTextColor.withOpacity(0.7),
      fontFamily: "Poppins",
      fontSize: Dimensions.fontSizeMid - 5,
      fontWeight: FontWeight.w300);
}
