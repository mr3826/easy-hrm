import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../leave/view/widget/custom_title_text_widget.dart';
import '../../controller/password_controller.dart';
import '../widget/change_email_widget.dart';

class ChangeEmailScreen extends StatelessWidget {
  ChangeEmailScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            customButtonSheetAppbar(
                text: AppString.text_confirm_your_password.tr),
            customSpacerHeight(height: 22),
            Padding(
              padding: marginLayout,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTitleText(
                      text: AppString.text_password.tr, isRequired: true),
                  customSpacerHeight(height: 12),
                  Obx(() => _userPasswordField()),
                  customSpacerHeight(height: 30),
                  Obx(() => Get.find<UserProfileController>().isLoading.isTrue
                      ? const Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.blueAccent,
                            radius: 16,
                          ),
                        )
                      : CustomDoubleAppButton(
                          buttonText: AppString.text_continue.tr,
                          onAction: () async {
                            if (_formKey.currentState!.validate()) {
                              final response =
                                  await Get.find<UserProfileController>()
                                      .getPasswordVerification(
                                          password:
                                              editMailPasswordController.text);
                              if (response == false) {
                                showErrorMessage(
                                    message: AppString.password_not_matched.tr);
                              } else {
                                if (context.mounted) {
                                  editMailPasswordController.clear();
                                  customButtonSheet(
                                      context: context,
                                      child: ChangEmailFieldLayout(),
                                      height: .7);
                                }
                              }
                            }
                          },
                          cancelAction: () {
                            Navigator.pop(context);
                          })),
                  customSpacerHeight(height: 300),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _userPasswordField() {
    return CustomPassInputField(
      hint: AppString.text_min_8_character.tr,
      controller: editMailPasswordController,
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
      weight: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: IconButton(
          onPressed: () => Get.find<PasswordController>().changeVal(),
          icon: Get.find<PasswordController>().isValue.isTrue
              ? _showHideText("Show")
              : _showHideText("Hide"),
        ),
      ),
    );
  }

  _showHideText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Text(
        text,
        style: AppStyle.mid_large_text.copyWith(
            fontSize: Dimensions.fontSizeExtraDefault - 1,
            color: AppColor.secondaryColor),
      ),
    );
  }
}

class SelectedOtpVerifyController extends GetxController {
  RxBool isSelected = false.obs;
}
