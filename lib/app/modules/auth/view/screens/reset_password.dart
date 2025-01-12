import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/warning_message.dart';
import 'package:payrun_mobile/app/modules/auth/controller/forgot_password_controller.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/forgot_password.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/widget/common_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../common/widget/custom_password_text_field.dart';
import '../../../../../utils/utils.dart';
import '../../../../global/view/widget/app_margin.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final String otpCode = Get.arguments[0];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: marginLayout,
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

                      ///Reset password image
                      imageLayout(url: Images.resetPassword),
                      customSpacerHeight(height: 50),

                      ///Title Text
                      _codeTitleText(),
                      customSpacerHeight(height: 6),

                      ///Description text
                      _descriptionText(),
                      customSpacerHeight(height: 30),

                      ///New password text field
                      _newPasswordLayout(),
                      customSpacerHeight(height: 20),

                      ///Confirm password text field
                      _confirmPasswordLayout(),
                      customSpacerHeight(height: 25),

                      ///Submit button
                      _submitBtnLayout(),
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
      ),
    );
  }

  _codeTitleText() {
    return Center(
        child: Text(
      AppString.text_reset_password.tr,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeMid - 2,
          color: AppColor.normalTextColor,
          fontFamily: "Poppins"),
    ));
  }

  _descriptionText() {
    return Text(
      "${AppString.text_setup_your_code_etc.tr}.",
      textAlign: TextAlign.center,
      style: style.copyWith(
          fontSize: Dimensions.fontSizeDefault - 2, color: AppColor.hintColor),
    );
  }

  _submitBtnLayout() {
    return Obx(() => CustomAppButton(
          buttonText: Get.find<ForgotPasswordController>().isLoading.isTrue
              ? const CupertinoActivityIndicator(color: Colors.white)
              : Text(
                  AppString.text_submit.tr,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.normal_text.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.fontSizeMid),
                ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (newPasswordController.text ==
                  confirmPasswordController.text) {
                await Get.find<ForgotPasswordController>()
                    .resetPassword(confirmationCode: otpCode);
              } else {
                showWarningMessage(message: AppString.password_not_matched);
              }
            }
          },
          buttonColor: AppColor.primaryColor,
          isButtonExpanded: false,
          btnTextSize: Dimensions.fontSizeMid - 2,
        ));
  }

  _newPasswordLayout() {
    return CustomPasswordInputField(
      controller: newPasswordController,
      hitText: AppString.text_new_password.tr,
      prefixIcon: Image.asset(Images.LOCK_ICON),
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_new_password_field_is_required.tr;
        } else {
          return null;
        }
      },
      hintStyle: TextStyle(
          color: AppColor.normalTextColor.withOpacity(0.4),
          fontFamily: "Poppins",
          fontSize: Dimensions.fontSizeDefault + 1),
    );
  }

  _confirmPasswordLayout() {
    return CustomPasswordInputField(
      controller: confirmPasswordController,
      hitText: AppString.text_confirm_password.tr,
      prefixIcon: Image.asset(Images.LOCK_ICON),
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_confirm_password_field_is_required.tr;
        } else {
          return null;
        }
      },
      hintStyle: TextStyle(
          color: AppColor.normalTextColor.withOpacity(0.4),
          fontFamily: "Poppins",
          fontSize: Dimensions.fontSizeDefault + 1),
    );
  }
}
