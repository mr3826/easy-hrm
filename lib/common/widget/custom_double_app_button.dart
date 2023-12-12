import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class CustomDoubleAppButton extends StatelessWidget {
  final String buttonText;

  final Color btnColor;
  final Function onAction;
  final Function  cancelAction;
  const CustomDoubleAppButton(
      {super.key, required this.buttonText, required this.onAction,required this.cancelAction,this.btnColor=AppColor.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: ()=> cancelAction(),
            child: Container(
              height: AppLayout.getHeight(48),
              decoration: BoxDecoration(
                color: AppColor.backgroundColor,
                border: Border.all(
                    width: 1, color: AppColor.hintColor.withOpacity(0.5)),
                borderRadius:
                    BorderRadius.circular(Dimensions.radiusExtraLarge),
              ),
              child: Center(
                  child: Text(AppString.text_close.tr,
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.hintColor.withOpacity(0.8),
                    fontSize: Dimensions.fontSizeMid - 3,
                    fontWeight: FontWeight.w700),
              )),
            ),
          ),
        ),
        customSpacerWidth(width: 20),
        Expanded(
          child: GestureDetector(
            onTap: ()=>onAction(),
            child: Container(
              height: AppLayout.getHeight(48),
              decoration: BoxDecoration(
                color: btnColor,
                borderRadius:
                    BorderRadius.circular(Dimensions.radiusExtraLarge),
              ),
              child: Center(
                  child:  Text(
                    buttonText,
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.cardColor,
                    fontSize: Dimensions.fontSizeMid - 3,
                    fontWeight: FontWeight.w700),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
