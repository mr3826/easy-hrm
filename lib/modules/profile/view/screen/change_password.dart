import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/modules/profile/controller/update_profile_controller.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';

import '../../../auth/presentation/view/otp_screen.dart';
import '../widget/edit_profile_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            customButtonSheetAppbar(text: AppString.text_set_new_password.tr),
            Padding(
              padding: marginLayout,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSpacerHeight(height: 14),
                  userTextFieldLayout(
                    titleText: AppString.text_current_password.tr,
                    controller: currentPasswordController,
                    hintText: AppString.text_min_8_character.tr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.the_password_field_is_required;
                      } else {
                        return null;
                      }
                    },
                  ),
                  userTextFieldLayout(
                    titleText: AppString.text_new_password.tr,
                    controller: newPasswordController,
                    hintText: AppString.text_min_8_character.tr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.the_new_password_field_is_required;
                      } else {
                        return null;
                      }
                    },
                  ),
                  userTextFieldLayout(
                    titleText: AppString.text_confirm_password.tr,
                    controller: confirmPasswordController,
                    hintText: AppString.text_min_8_character.tr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.the_confirm_password_field_is_required;
                      } else {
                        return null;
                      }
                    },
                  ),
                  customSpacerHeight(height: 30),
                  Obx(() => Get.find<UpdateProfileController>().isLoading.isTrue
                      ? const Center(
                          child: CupertinoActivityIndicator(
                              radius: 16, color: Colors.blueAccent),
                        )
                      : CustomDoubleAppButton(
                          buttonText: AppString.text_save.tr,
                          onAction: () {
                            if (_formKey.currentState!.validate()) {
                              if (newPasswordController.text ==
                                  confirmPasswordController.text) {
                                Get.find<UpdateProfileController>()
                                    .changePassword(
                                        currentPassword:
                                            currentPasswordController.text,
                                        newPassword:
                                            confirmPasswordController.text);
                              } else {
                                showErrorMessage(
                                    message: AppString.password_not_matched.tr);
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
}
