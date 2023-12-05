import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget durationTimeLayout({required Color?bgColor,}){
  return SizedBox(
    height: AppLayout.getHeight(200),
    width: double.infinity,
    child: Card(
      color: bgColor,
      child: Column(
        children: [
          Text("Thu,21 April -2022",style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeDefault,color: AppColor.normalTextColor),),
          Text("Duration",style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeDefault,color: AppColor.normalTextColor),),
          Text("00h 00m",style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeMid,fontWeight: FontWeight.w900,color: AppColor.normalTextColor),),

        ],
      ),
    ),
  );
}