import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

Widget horizontalDottedLayout({double dottedSpace=6,double dottedLength=3}){
  return Expanded(
    child: Container(
      height: 0,
      decoration:  BoxDecoration(
        border: RDottedLineBorder.symmetric(
            horizontal: const BorderSide(width: 0,color: AppColor.hintColor),
            dottedSpace: dottedSpace,
            dottedLength: dottedLength,
        ),
      ),
    ),
  );
}
