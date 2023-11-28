import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';


Widget timerTextField(
    {required String hintText,  required IconData dobIcon ,dobIconAction}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),

    child: TextField(

      readOnly: true,
      onTap: () => dobIconAction(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: hintText,

        focusColor: AppColor.primaryColor,

        hintStyle: AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor, fontSize: Dimensions.fontSizeDefault),
        filled: false,
        fillColor: AppColor.backgroundColor,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          const BorderSide( color: AppColor.solidGray),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide:  const BorderSide(color: AppColor.hintColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
        ),

        border: OutlineInputBorder(
          borderSide:
          const BorderSide(width: 0.0, color: AppColor.hintColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),

        suffixIcon: IconButton(
          onPressed: () => dobIconAction(), icon: Icon(dobIcon,size: 27,color: AppColor.hintColor.withOpacity(0.9),),
        ),


      ),

    ),

  );
}
