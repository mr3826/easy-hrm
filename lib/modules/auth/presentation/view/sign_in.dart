import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
import '../../../../utils/utils.dart';
import '../../../starting/view/onboarding_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final ExitAppController _controller = Get.put(ExitAppController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _controller.willPop(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _body(),
      ),
    );
  }

  _body() {
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
                         _logoLayout(),
                          customSpacerHeight(height: 70),
                          _organizationNameLayout(),
                          customSpacerHeight(height: 8),
                           Text("Organization field is required !",style: AppStyle.normal_text_black.copyWith(color: AppColor.errorColor,fontSize: Dimensions.fontSizeDefault-2),),
                          customSpacerHeight(height: 20),

                          _emailAddressLayout(),
                          customSpacerHeight(height: 20),
                          Obx(() => _userPasswordField()),
                          customSpacerHeight(height: 12),
                          _forgotPassword(),
                          customSpacerHeight(height: 34),
                          _logInBtnLayout(),

                        ],
                      ),

                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _userPasswordField() {
    return CustomPassInputField(
      hint: AppString.text_password.tr,
      controller: passwordController,
      prefixIcon: Icons.lock_open_outlined,
      obsValue: Get.find<PasswordController>().isValue.value,
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_password_field_is_required;
        } else if (value.length < 6) {
          return AppString.incorrect_user_or_password;
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
      prefixIcon: Icons.email_outlined,
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_email_field_is_required;
        } else if (value.isEmpty || !RegExp(emailExp()).hasMatch(value)) {
          return AppString.please_insert_a_valid_email_address;
        } else {
          return null;
        }
      },
    );
  }

  _organizationNameLayout() {
    RxBool isLoading=false.obs;
    return Obx(() => CustomInputField(
      hint: AppString.text_organization_name.tr,
      prefixIcon: Icons.home_work_outlined,
      controller: orgNameController,
      weight:  SizedBox(
          height: 2,
          width: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: isLoading.value?const Center(child: CircularProgressIndicator(strokeWidth: 2,)):Container(),
          )),
    ));
  }

  _logInBtnLayout() {
    RxBool isLoading=false.obs;

    return AppButton(
      buttonText: Text(
        AppString.text_sign_in.tr,overflow: TextOverflow.ellipsis,
        style: AppStyle.normal_text.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (_formKey.currentState!.validate()) {
          Get.toNamed(Routes.MAIN_SCREEN);
        }
      },
      buttonColor: AppColor.primaryColor,
      isButtonExpanded: false,
    );
  }

  _logoLayout() {

    double height = AppLayout.getHeight(120);
    double width = MediaQuery.of(context).size.width;
    return  SizedBox(
      height: height,
      width: width,
      child:  SvgPicture.asset(
        Images.app_logo,fit: BoxFit.fitHeight,

      ),
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
