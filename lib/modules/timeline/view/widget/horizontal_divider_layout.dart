import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../app/global/view/widget/app_margin.dart';
import '../../../../utils/app_color.dart';
import 'horizontal_dotted_style.dart';

Widget weekTextLayout({required String date}) {
  return Padding(
    padding: marginLayout.copyWith(top: 12, bottom: 12,left: 25,right: 25),
    child: Row(
      children: [
        _divider(),
        Padding(
          padding: marginLayout.copyWith(top: 6, bottom: 6),
          child: Text(
            date,
            style: AppStyle.normal_text_black.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault),
          ),
        ),
        _divider(),
      ],
    ),
  );
}

_divider() {
  return horizontalDottedLayout();
}
