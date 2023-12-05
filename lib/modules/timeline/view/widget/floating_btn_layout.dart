import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget  floatingButton({required Color bgBtnColor,required btnText,required onAction}) {
  return  Expanded(
    child: InkWell(
      onTap: ()=>onAction(),
      child: Container(
        decoration: BoxDecoration(
            color: bgBtnColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)
        ),
        height: AppLayout.getHeight(46),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add,color: AppColor.cardColor,size: 17,),
            customSpacerWidth(width: 4),
            Center(child: Text(btnText,style: AppStyle.mid_large_text.copyWith(color: AppColor.cardColor,fontWeight: FontWeight.w700,fontSize: Dimensions.radiusMid-1),)),
          ],
        ),
      ),
    ),
  );
}