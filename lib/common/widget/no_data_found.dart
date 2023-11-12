import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'custom_spacer.dart';

Widget  noDataFound({double height=158,double svgHeight =160,double svgWidth=160}){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customSpacerHeight(height: height),
        Align(
          alignment: Alignment.center,
          child: svgIcon(
            height: AppLayout.getHeight(svgHeight),
            width: AppLayout.getWidth(svgWidth),
            url: "",
          ),
        ),
      ],
    ),
  );
}