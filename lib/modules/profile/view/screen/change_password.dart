import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
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
                  customSpacerHeight(height: 12),
                  userTextFieldLayout(titleText: AppString.text_current_password.tr,controller: currentPassword,hintText: AppString.text_min_8_character.tr,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppString.the_password_field_is_required;
                    } else {
                      return null;
                    }
                  },
                  ),
                  userTextFieldLayout(titleText: AppString.text_new_password.tr,controller: newPasswordController,hintText: AppString.text_min_8_character.tr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.the_new_password_field_is_required;
                      } else {
                        return null;
                      }
                    },
                  ),
                  userTextFieldLayout(titleText: AppString.text_confirm_password.tr,controller: confirmPasswordController,hintText: AppString.text_min_8_character.tr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.the_confirm_password_field_is_required;
                      } else {
                        return null;
                      }
                    },

                  ),

                  customSpacerHeight(height: 20),

                  CustomDoubleAppButton(buttonText: AppString.text_save.tr, onAction: (){

                  if (_formKey.currentState!.validate()) {
                    
                  }
                  }, cancelAction: (){
                    Navigator.pop(context);
                  }),
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

