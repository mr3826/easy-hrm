import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/tab_bar_body/change_email/email_verification_otp.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../controller/global_profile_controller.dart';
import '../../edit_profile_text_field.dart';

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
                  Obx(() => Get.find<ProfileGlobalController>().isLoadingChangeEmail.isTrue
                      ? const Center(
                          child: CupertinoActivityIndicator(
                              color: Colors.blueAccent, radius: 16),
                        )
                      : CustomDoubleAppButton(
                          buttonText: AppString.text_save.tr,
                          onAction: () async {
                            if (_formKey.currentState!.validate()) {
                              final response =
                                  await Get.find<ProfileGlobalController>()
                                      .changeMail(
                                          newEmail: changeEmailController.text);

                              if (response == false) {
                                showErrorMessage(message: AppString.error_text);
                              } else {
                                if (context.mounted) {
                                  otpVerificationLayout(context);
                                  Get.find<ProfileGlobalController>().seconds.value = 59;
                                  Get.find<ProfileGlobalController>().startTimer();
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
