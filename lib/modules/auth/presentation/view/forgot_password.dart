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
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../utils/utils.dart';

class ForgotScreen extends GetView<ForgotPasswordController> {
  ForgotScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingLarge),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      imageLayout(url: Images.forgot),
                      customSpacerHeight(height: 50),
                      _forgotTitleText(),
                      customSpacerHeight(height: 4),
                      _descriptionText(),
                      customSpacerHeight(height: 40),

                      ///Email address text field
                      _emailAddressLayout(),
                      customSpacerHeight(height: 40),

                      ///Send code button
                      _sendCodeBtnLayout(),
                      customSpacerHeight(height: 40),
                      _backToLoginLayout(),
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
      ),
    );
  }

  _emailAddressLayout() {
    return CustomInputField(
      hint: AppString.text_email,
      prefixIcon: Icons.email_outlined,
      controller: restPasswordController,
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_email_field_is_required;
        } else {
          return null;
        }
      },
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
            if (_formKey.currentState!.validate()) {
              await controller.forgotPassword();
            }
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
          fontSize: Dimensions.fontSizeMid - 2,
          color: AppColor.normalTextColor,
          fontFamily: "Poppins"),
    ));
  }

  _descriptionText() {
    return Text(
      AppString.text_dont_not_worry.tr,
      textAlign: TextAlign.center,
      style: style.copyWith(
          fontSize: Dimensions.fontSizeDefault - 2, color: AppColor.hintColor),
    );
  }
}

TextStyle get style {
  return TextStyle(
      color: AppColor.normalTextColor.withOpacity(0.7),
      fontFamily: "Poppins",
      fontSize: Dimensions.fontSizeMid - 5,
      fontWeight: FontWeight.w300);
}

Widget  imageLayout({required url}) {
  return Center(
      child: SvgPicture.asset(
        url,
        fit: BoxFit.cover,
      ));
}