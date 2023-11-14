import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';

Widget dottedBorderLayoutView({required double height}){
  return  DottedBorder(
    borderType: BorderType.Rect, // Set the border type to horizontal
    customPath: (p0) => Path()..lineTo(height, 0),
    color: AppColor.hintColor.withOpacity(0.6),
    dashPattern: const [6, 7],
    strokeWidth: 1.5,
    child: Divider(
      height: AppLayout.getHeight(26),
      color: AppColor.noColor,

    ),
  );
}
