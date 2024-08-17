import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../common/widget/custom_password_text_field.dart';
import '../../../leave/presentation/view/widget/custom_title_text_widget.dart';
import '../../../timeline/view/widget/timeline_calendar.dart';
import '../widget/change_email_widget.dart';

class ChangeEmailScreen extends StatelessWidget {
  ChangeEmailScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  _userPasswordField(),
                  customSpacerHeight(height: 30),
                  Obx(() => Get.find<UserProfileController>().isLoading.isTrue
                      ? const Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.blueAccent,
                            radius: 16,
                          ),
                        )
                      : CustomDoubleAppButton(
                          buttonText: AppString.text_confirm.tr,
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
                                  customAntButtonSheet(
                                    context: context,
                                    child: ChangEmailFieldLayout(),
                                  );
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
    return CustomPasswordInputField(
      controller: editMailPasswordController,
      hitText: AppString.text_min_8_character.tr,
      suffixHideText: AppString.text_hide.tr,
      suffixShowText: AppString.text_show.tr,
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_password_field_is_required.tr;
        } else if (value.length < 6) {
          return AppString.incorrect_user_or_password.tr;
        } else {
          return null;
        }
      },
      hintStyle: TextStyle(
          color: AppColor.normalTextColor.withOpacity(0.4),
          fontFamily: "Poppins",
          fontSize: Dimensions.fontSizeDefault + 1),
    );
  }
}

class SelectedOtpVerifyController extends GetxController {
  RxBool isSelected = false.obs;
}
