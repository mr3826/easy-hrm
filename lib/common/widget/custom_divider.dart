import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:flutter/material.dart';


Widget customDivider(double  height, double width){
  return Padding(
    padding: const EdgeInsets.only(left: 0.0,right: 0),
    child: Container(width: AppLayout.getWidth(width),height: AppLayout.getHeight(height),color: AppColor.disableColor,),
  );

}