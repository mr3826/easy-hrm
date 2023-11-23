import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget userInfoSectionLayout({required staticText,required dynamicText,isChangeEmailVisible=false,onAction,}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("$staticText",style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault,),),
      customSpacerHeight(height: 2),
      Text("$dynamicText",style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-2),),
      customSpacerHeight(height: 8),
      isChangeEmailVisible ==true?  GestureDetector(
          onTap: onAction,
          child: Text(AppString.text_change_email.tr,style: AppStyle.normal_text_grey.copyWith(color: AppColor.secondaryColor,fontSize: Dimensions.fontSizeDefault-2),)):Container(),

    ],
  );

}
//message


