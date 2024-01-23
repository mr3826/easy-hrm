import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../utils/utils.dart';
import '../../../starting/view/onboarding_screen.dart';
import '../controller/signin_controller.dart';

class SignInScreen extends GetView<SignInController> {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final ExitAppController _controller = Get.put(ExitAppController());

  @override
  Widget build(BuildContext context) {
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
                          _logoLayout(context),
                          customSpacerHeight(height: 70),
                          Obx(() => _organizationNameLayout()),
                          customSpacerHeight(height: 8),
                          Obx(() => _organizationNameErrorLayout()),
                          customSpacerHeight(height: 20),
                          _emailAddressLayout(),
                          customSpacerHeight(height: 20),
                          Obx(() => _userPasswordField()),
                          customSpacerHeight(height: 12),
                          _forgotPassword(),
                          customSpacerHeight(height: 34),
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
    return CustomPassInputField(
      hint: AppString.text_password.tr,
      controller: passwordController,
      prefixIcon: Icons.lock_open_outlined,
      obsValue: controller.isValue.value,
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
        onPressed: () => controller.changeVal(),
        icon: controller.isValue.isTrue
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
    return Focus(
      onFocusChange: (value) {
        if (value == false) {
          controller.getOrganizationDomain();
        }
      },
      child: TextFormField(
        controller: orgNameController,
        style: AppStyle.mid_large_text.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault),
        autofocus: false,
        decoration: InputDecoration(
          hintText: AppString.text_organization_name.tr,
          hintStyle: TextStyle(
              color: AppColor.hintColor,
              fontFamily: "Poppins",
              fontSize: Dimensions.fontSizeDefault + 1),
          prefixIcon: const Icon(
            Icons.home_work_outlined,
            color: AppColor.hintColor,
          ),
          suffixIcon: SizedBox(
              height: 2,
              width: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: controller.isLoading.value
                    ? const Center(
                        child: CupertinoActivityIndicator(
                        animating: true,
                      ))
                    : Container(),
              )),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 0.0, color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
          ),
          focusColor: AppColor.primaryColor,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.disableColor)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.disableColor),
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
        ),
      ),
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
          if (GetStorage().read(AppString.ORGANIZATION_ID) != null) {
            await controller.login(
                email: emailController.text,
                password: passwordController.text,
                orgId: GetStorage().read(AppString.ORGANIZATION_ID));
          } else {
            showErrorMessage(message: AppString.organizationNotFoundMessage.tr);
          }
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
        Images.app_logo,
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
