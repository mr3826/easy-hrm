import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import '../../../../utils/app_color.dart';

Widget horizontalDottedLayout({required double height}){
  return  DottedBorder(
    customPath: (p0) => Path()..lineTo(AppLayout.getHeight(height), 0),
    color: AppColor.hintColor.withOpacity(0.6),
    dashPattern: const [4, 4],
    strokeWidth: 1.2,
    child:Container(),
  );
}
