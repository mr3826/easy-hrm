import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget  floatingButton({required Color bgBtnColor,required String btnText,required Function onAction,IconData ?icon}) {
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
            customSpacerWidth(width: 30),
             Icon(icon??Icons.add,color: AppColor.cardColor,size: 17,),
            customSpacerWidth(width: 4),
            Expanded(child: Text(btnText,style: AppStyle.mid_large_text.copyWith(color: AppColor.cardColor,fontWeight: FontWeight.w700,fontSize: Dimensions.radiusMid-1,overflow: TextOverflow.ellipsis),)),
            customSpacerWidth(width: 4),

          ],
        ),
      ),
    ),
  );
}


Widget  startTimerOpenBtn({required Color bgBtnColor,required String btnText,required Function onAction,IconData ?icon}) {
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
             Icon(Icons.check_box_outline_blank,color: AppColor.cardColor.withOpacity(0.9),size: 20,),
            customSpacerWidth(width: 4),
            Center(child: Text(btnText,style: AppStyle.normal_text_grey.copyWith(color: AppColor.cardColor,fontSize: Dimensions.fontSizeDefault+1),)),
          ],
        ),
      ),
    ),
  );
}