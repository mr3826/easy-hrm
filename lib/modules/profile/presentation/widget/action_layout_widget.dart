import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';


Widget actionLayout({required userName,required departmentText }){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customButtonSheetAppbar(text: "$userName",subtext: "$departmentText"),
       customSpacerHeight(height: 20),
      _fieldLayout(hintText:AppString.text_edit_profile.tr,prefixIcon: Icons.edit ),
      _fieldLayout(hintText:AppString.text_change_password.tr,prefixIcon: Icons.key )

    ],
  );
}

_fieldLayout({required hintText,required IconData ?prefixIcon}) {
  return Padding(
    padding: marginLayout,
    child: Column(
      children: [
        customSpacerHeight(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$hintText",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor.withOpacity(0.7),fontSize: Dimensions.fontSizeDefault+1),),
             Icon(prefixIcon,color: AppColor.hintColor,),
          ],
        ),
        customSpacerHeight(height: 12),
        const Divider(thickness: 1,),
      ],
    ),
  );
}