import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:flutter/cupertino.dart';

Widget customSpacerHeight({required double height}){
  return  SizedBox(
      height: AppLayout.getHeight(
        height,
      ));
}


Widget customSpacerWidth({required double width}) {
  return SizedBox(
      width: AppLayout.getWidth(
        width,
      ));
}
