import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../utils/app_color.dart';

customDialog(
    {required context,
    required icon,
    drcFontSize,
    required titleText,
    required subText,
    required saveBtnAction,
    required btnText,
     Widget? childForSaveBtn,
    drcText,
    required iconBgColor,
    required btnBgColor}) {
  showDialog(
    context: context,
    builder: (context) => CustomDialog(
        subtext: subText,
        drcFontSize: drcFontSize,
        titleText: titleText,
        icon: icon,
        saveBtnAction: saveBtnAction,
        btnText: btnText,
        drcText: drcText,
        childForSaveBtn: childForSaveBtn,
        iconBgColor: btnBgColor,
        btnBgColor: btnBgColor),
  );
}

class CustomDialog extends StatelessWidget {
  final IconData icon;
  final String titleText;
  final String subtext;
  final String drcText;
  final String btnText;
  final Color iconBgColor;
  final Color btnBgColor;
  final double? drcFontSize;
  final Widget ?childForSaveBtn;
  final Function saveBtnAction;
  final isOTPVisible = false;

  const CustomDialog(
      {super.key,
      required this.icon,
      required this.titleText,
      this.drcFontSize,
      required this.iconBgColor,
      required this.btnBgColor,
      this.subtext = "",
        this.childForSaveBtn,
      required this.saveBtnAction,
      required this.btnText,
      required this.drcText});
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: roundedRectangleBorder,
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(Dimensions.radiusDefault)),
          margin: const EdgeInsets.only(top: 16),
          child: SizedBox(
            height: AppLayout.getHeight(230),
            child: Padding(
              padding: marginLayout.copyWith(bottom: 16),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: iconBgColor.withOpacity(0.2),
                    radius: 32,
                    child: Icon(
                      icon,
                      size: 40,
                      color: btnBgColor,
                    ),
                  ),
                  customSpacerHeight(height: 12),
                  Text(
                    titleText,
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.normalTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                  customSpacerHeight(height: 12),
                  Center(
                      child: Text(
                    subtext,
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize:
                            drcFontSize ?? Dimensions.fontSizeDefault - 3),
                  )),
                  Center(
                      child: Text(
                    drcText,
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 3),
                  )),
                  const Spacer(),
                  CustomDoubleAppButton(
                    buttonText: btnText,
                    onAction: saveBtnAction,
                    cancelAction: () => Get.back(),
                    btnColor: btnBgColor,
                    saveBtn:childForSaveBtn,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
