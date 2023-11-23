import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/profile/presentation/view/chnage_email.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/email_verification_otp.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class ChangeEmailNotifyLayout extends StatelessWidget {
  ChangeEmailNotifyLayout({super.key});

  final selectedValue = Get.put(PopupMenuController());
  final selectedVerifyValue=Get.put(SelectedOtpVerifyController());

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.text_email.tr,
                  style: AppStyle.normal_text_grey.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeDefault+1,
                  ),
                ),
                customSpacerHeight(height: 2),
                Text(
                  "rifat@gmail.com",
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.hintColor,
                      fontSize: Dimensions.fontSizeDefault - 1),
                ),
                customSpacerHeight(height: 8),
                GestureDetector(
                    onTap: () => customButtonSheet(
                        context: context,
                        height: .7,
                        child: ChangeEmailScreen()),
                    child: Text(
                      AppString.text_change_email.tr,
                      style: AppStyle.normal_text_grey.copyWith(
                          color: AppColor.secondaryColor,
                          fontSize: Dimensions.fontSizeDefault - 1),
                    )),
                customSpacerHeight(height: 12),
              ],
            ),
            
            Obx(() => selectedVerifyValue.isSelected.value==true?
            PopupMenuButton(
              onSelected: (value) {
                print("value ==> $value");
                Get.find<PopupMenuController>().selectedValue.value = value;
                value==AppString.text_verify_email.tr?  otpVerificationLayout(context):Container();

              value==AppString.text_revert_change.tr?  selectedVerifyValue.isSelected(false):Container();
              },
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(Dimensions.radiusDefault)),
              itemBuilder: (context) => [
                PopupMenuItem(
                    value: AppString.text_verify_email.tr,
                    child: Text(
                      AppString.text_verify_email.tr,
                      style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeDefault + 1),
                    )),
                PopupMenuItem(
                    value: AppString.text_revert_change.tr,
                    child: Text(
                      AppString.text_revert_change.tr,
                      style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeDefault + 1),
                    ))
              ],
            ):Container())

          ],
        ),
        Obx(
          () => selectedVerifyValue.isSelected.value==true && selectedValue.selectedValue.value== AppString.text_verify_email.tr
              ? _alertMessageLayout(message: "")
              : Container(),
        ),
      ],
    );
  }
}

_alertMessageLayout({required String message}) {
  return Card(
    elevation: 0,
    shape: roundedRectangleBorder,
    color: AppColor.pendingColor.withOpacity(0.08),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        AppString.text_email_change_request_is_in_pendding_etc.tr,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.pendingColor, fontSize: Dimensions.fontSizeDefault),
      ),
    ),
  );
}

class PopupMenuController extends GetxController {
  RxString selectedValue = AppString.text_verify_email.tr.obs;
}
