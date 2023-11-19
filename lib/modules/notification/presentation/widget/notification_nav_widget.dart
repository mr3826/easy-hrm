import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

 AppBar notificationAppbar(){
  return AppBar(
    leadingWidth: AppLayout.getWidth(200),
    backgroundColor: AppColor.backgroundColor,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(top: 16.0,left: 18),
      child: Text(AppString.text_notications,style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontWeight: FontWeight.w600,fontSize: Dimensions.fontSizeMid+1),),
    ),);
}