import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/modules/auth/presentation/controller/password_showing_controller.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/change_email_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';

class ChangeEmailScreen extends StatelessWidget {
   ChangeEmailScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            customButtonSheetAppbar(text: AppString.text_confirm_your_password.tr),
            customSpacerHeight(height: 22),

            Padding(
              padding: marginLayout,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("${AppString.text_password} *",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeMid-2),),
                 customSpacerHeight(height: 12),
                  Obx(() =>  _userPasswordField()),
                  customSpacerHeight(height: 30),
                  CustomDoubleAppButton(buttonText: AppString.text_continue.tr, onAction: (){
                    if (_formKey.currentState!.validate()) {
                      customButtonSheet(context: context,child: ChangEmailFieldLayout(),height: .7);
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



}

class SelectedOtpVerifyController extends GetxController {

  RxBool isSelected=false.obs;

}
