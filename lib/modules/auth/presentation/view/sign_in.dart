import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/widget/common_widget.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../common/widget/custom_password_text_field.dart';
import '../../../../utils/utils.dart';
import '../../../starting/view/onboarding_screen.dart';
import '../controller/signin_controller.dart';

class SignInScreen extends GetView<SignInController> {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final ExitAppController _controller = Get.put(ExitAppController());

  @override
  Widget build(BuildContext context) {
    Get.put(SignInController());
    return WillPopScope(
      onWillPop: () => _controller.willPop(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customSpacerHeight(height: 36),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customSpacerHeight(height: 50),

                          ///App logo
                          _logoLayout(context),
                          customSpacerHeight(height: 70),
                          Obx(() => _organizationNameErrorLayout()),
                          customSpacerHeight(height: 20),

                          ///Email address
                          _emailAddressLayout(),
                          customSpacerHeight(height: 20),

                          ///User password
                          _userPasswordField(),
                          customSpacerHeight(height: 12),

                          ///Forgot password
                          _forgotPassword(),
                          customSpacerHeight(height: 34),

                          ///Login button
                          Obx(() => _logInBtnLayout(context)),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  _userPasswordField() {
    return CustomPasswordInputField(
      controller: passwordController,
      hitText: AppString.text_password.tr,
      prefixIcon: Image.asset(Images.LOCK_ICON),
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_password_field_is_required.tr;
        } else if (value.length < 6) {
          return AppString.incorrect_user_or_password.tr;
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

  _forgotPassword() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.FIRGIR_PASSWORD_SCREEN);
        clearInputField();
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Text(
            AppString.forgotPassword.tr,
            style: AppStyle.normal_text_grey.copyWith(
                color: AppColor.normalTextColor.withOpacity(0.7),
                fontSize: Dimensions.fontSizeDefault - 1),
          )),
    );
  }
  _emailAddressLayout() {
    return CustomInputField(
      hint: AppString.text_email.tr,
      prefixWidget: SizedBox(width: 47, child: Image.asset(Images.EMAIL_ICON)),
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_email_field_is_required.tr;
        } else if (value.isEmpty || !RegExp(emailExp()).hasMatch(value)) {
          return AppString.please_insert_a_valid_email_address.tr;
        } else {
          return null;
        }
      },
    );
  }

  _logInBtnLayout(BuildContext context) {
    return CustomAppButton(
      buttonText: controller.isSignInLoading.isFalse
          ? Text(
              AppString.text_sign_in.tr,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.normal_text.copyWith(
                fontWeight: FontWeight.w600,
              ),
            )
          : const CupertinoActivityIndicator(
              color: Colors.white,
            ),
      onPressed: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        if (_formKey.currentState!.validate()) {
          await controller.login(
              email: emailController.text, password: passwordController.text);
        }
      },
      buttonColor: AppColor.primaryColor,
      isButtonExpanded: false,
    );
  }

  _logoLayout(BuildContext context) {
    double height = AppLayout.getHeight(120);
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: SvgPicture.asset(
        Images.appLogo,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  _organizationNameErrorLayout() {
    return controller.organizationAvailabilityMessage.value.isNotEmpty
        ? Text(controller.organizationAvailabilityMessage.value,
            style: AppStyle.normal_text_black.copyWith(
                color: AppColor.errorColor,
                fontSize: Dimensions.fontSizeDefault - 2))
        : Container();
  }
}

emailExp() {
  const pattern =
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
  return pattern;
}

passwordExp() {
  return r"(?=.*\d)(?=.*[a-z])(?=.*\W)";
}
