import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/edit_profile_widget.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';

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
                  userTextFieldLayout(titleText: AppString.text_email+ "*".tr,controller: emailController,hintText: AppString.text_min_8_character.tr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.the_email_field_is_required.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  customSpacerHeight(height: 20),
                  CustomDoubleAppButton(buttonText: AppString.text_continue.tr, onAction: (){
                    if (_formKey.currentState!.validate()) {
                    }

                  }, cancelAction: (){
                    Navigator.pop(context);
                  }),
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
