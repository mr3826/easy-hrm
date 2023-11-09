import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/input_controller.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/modules/auth/presentation/controller/password_view_controller.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../starting/view/onboarding_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final ExitAppController _controller = Get.put(ExitAppController());
  var controller = Get.find<InputController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _controller.willPop(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
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
                      customSpacerHeight(height: 100),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         _logoLayout(),
                          customSpacerHeight(height: 70),
                          _emailAddressLayout(),
                          Obx(() => _userPasswordField()),
                          customSpacerHeight(height: 12),
                          _forgotPassword(),
                          customSpacerHeight(height: 34),
                          _logInBtnLayout(),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  _userPasswordField() {
    return AppInputField(
        hint: AppString.text_password.tr,
        controller: controller.passwordController,
        isPasswordField: true,
        prefixIcon: Icons.lock_open_outlined,
        obsValue: Get.find<PasswordController>().isValue.value,
      validator: (value) {
        if (value!.isEmpty) {
          return AppString
              .the_password_field_is_required;
        } else if (value.length < 6) {
          return AppString
              .incorrect_user_or_password;
        } else {
          return null;
        }
      },
        weight: IconButton(
          onPressed: () => Get.find<PasswordController>().changeVal(),
          icon: Get.find<PasswordController>().isValue.isTrue
              ? const Icon(
                  Icons.visibility_off_outlined,
                  color: AppColor.hintColor,
                )
              : const Icon(
                  Icons.remove_red_eye_outlined,
                  color: AppColor.hintColor,
                ),
        ),

    );
  }

  _forgotPassword() {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.FIRGIR_PASSWORD_SCREEN),
      child: Align(
          alignment: Alignment.topRight,
          child: Text(
            AppString.forgotPassword,
            style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor.withOpacity(0.7),fontSize: Dimensions.fontSizeDefault-1),
          )),
    );
  }

  _emailAddressLayout() {
    return AppInputField(
      hint: AppString.text_email,
      prefixIcon: Icons.email_outlined,
      controller: controller.emailController,
        validator: (value) {
      if (value!.isEmpty) {
        return AppString
            .the_email_field_is_required;
      } else if (value.isEmpty ||
          !RegExp(emailExp()).hasMatch(value)) {
        return AppString
            .please_insert_a_valid_email_address;
      } else {
        return null;
      }
    },
    );
  }

  _logInBtnLayout() {
    return AppButton(
      buttonText: AppString.text_sign_in,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (_formKey.currentState!.validate()) {
          print("Done !");
        }
      },
      buttonColor: AppColor.primaryColor,
      isButtonExpanded: false,
    );
  }

  _logoLayout() {
    return  SizedBox(
      height: AppLayout.getHeight(100),
      width: double.infinity,
      child: Image(image: AssetImage( Images.app_logo,
        ),fit: BoxFit.fitHeight,),
    );
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


