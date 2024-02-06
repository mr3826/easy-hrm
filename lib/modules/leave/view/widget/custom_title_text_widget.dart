import 'package:flutter/cupertino.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget customTitleText({required text,bool isRequired=false}) {
  return Row(
    children: [
      Text(
        text,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeDefault + 2),
      ),
      customSpacerWidth(width: 4),
      isRequired !=false?
      Text("*",style: AppStyle.mid_large_text.copyWith(
          color: AppColor.errorColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeDefault + 1)):Container()

    ],
  );
}

Widget customTitleTextRedText({required text}) {
  return Text(
    text,
    style: AppStyle.mid_large_text.copyWith(
        color: AppColor.errorColor,
        fontWeight: FontWeight.w600,
        fontSize: Dimensions.fontSizeDefault + 1),
  );
}
