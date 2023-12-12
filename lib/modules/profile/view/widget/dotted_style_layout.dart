import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import '../../../../utils/app_color.dart';


Widget dottedStyleLayout({required double height}){
  return  Padding(
    padding: const EdgeInsets.only(left: 28.0),
    child: DottedBorder(
      customPath: (p0) => Path()..lineTo(0, AppLayout.getHeight(height)),
      color: AppColor.hintColor.withOpacity(0.6),
      dashPattern: const [4, 4],
      strokeWidth: 1.2,
      child: Row(
        children: [
          Divider(
            height: AppLayout.getHeight(height),
            color: AppColor.noColor,
          ),
        ],
      ),
    ),
  );
}
