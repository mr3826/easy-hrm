import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget durationTimeLayout({required Color?bgColor,}){
  return SizedBox(
    width: double.infinity,
    child: Card(
      color: bgColor,
      elevation: 0,
      shape: roundedRectangleBorder,
      child: Padding(
        padding: marginLayout.copyWith(top: 14,bottom: 14),
        child: Column(
          children: [
            Text("Thu,21 April -2022",style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeDefault,color: AppColor.normalTextColor),),
            customSpacerHeight(height: 18),
            Text("Duration",style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeDefault,color: AppColor.hintColor),),
            Text("00h 00m",style: AppStyle.normal_text_grey.copyWith(fontSize: Dimensions.fontSizeMid+5,fontWeight: FontWeight.w900,color: AppColor.normalTextColor),),
            customSpacerHeight(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _verticalDivider(height: 13,bgColor: AppColor.hintColor.withOpacity(0.3)),
                customSpacerWidth(width: 30),
                _verticalDivider(height: 17,bgColor: AppColor.hintColor.withOpacity(0.5)),
                customSpacerWidth(width: 30),

                _verticalDivider(height: 22,bgColor: AppColor.hintColor.withOpacity(0.7)),
                customSpacerWidth(width: 30),

                _verticalDivider(height: 24,bgColor: AppColor.hintColor.withOpacity(0.9)),
                customSpacerWidth(width: 30),

                _verticalDivider(height: 22,bgColor: AppColor.hintColor.withOpacity(0.7)),
                customSpacerWidth(width: 30),

                _verticalDivider(height: 17,bgColor: AppColor.hintColor.withOpacity(0.5)),
                customSpacerWidth(width: 30),

                _verticalDivider(height: 13,bgColor: AppColor.hintColor.withOpacity(0.3)),
              ],
            )

          ],
        ),
      ),
    ),
  );
}

_verticalDivider({ required double height,required Color bgColor}) {
  return Container(
    height: height,
    width: 1,
    color: bgColor,
  );
}


