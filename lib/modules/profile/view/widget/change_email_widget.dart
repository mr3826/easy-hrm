import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/widget/email_verification_otp.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';
import 'edit_profile_widget.dart';

class ChangEmailFieldLayout extends StatelessWidget {
  ChangEmailFieldLayout({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            customButtonSheetAppbar(text: AppString.text_change_email.tr),
            customSpacerHeight(height: 22),
            Padding(
              padding: marginLayout,
              child: Column(
                children: [
                  userTextFieldLayout(
                    titleText: AppString.text_email.tr,
                    controller: changeEmailController,
                    hintText: AppString.text_enter_new_email_address.tr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.the_email_field_is_required.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  customSpacerHeight(height: 20),
                  Obx(() => Get.find<UserProfileController>().isLoading.isTrue
                      ? const Center(
                          child: CupertinoActivityIndicator(
                              color: Colors.blueAccent, radius: 16),
                        )
                      : CustomDoubleAppButton(
                          buttonText: AppString.text_save.tr,
                          onAction: () async {
                            if (_formKey.currentState!.validate()) {
                              final response =
                                  await Get.find<UserProfileController>()
                                      .changeMail(
                                          newEmail: changeEmailController.text);

                              if (response == false) {
                                showErrorMessage(message: AppString.error_text);
                              } else {
                                if (context.mounted) {
                                  otpVerificationLayout(context);
                                  Get.find<UserProfileController>().seconds.value = 59;
                                  Get.find<UserProfileController>().startTimer();
                                }
                              }
                            }
                          },
                          cancelAction: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            changeEmailController.clear();
                          })),
                ],
              ),
            ),
            customSpacerHeight(height: 300)
          ],
        ),
      ),
    );
  }
}
