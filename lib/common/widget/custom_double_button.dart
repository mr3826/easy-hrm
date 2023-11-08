import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';

Widget customDoubleButton(
    {context,
    textButtonAction,
    elevatedButtonAction,
    required String textBtnText,
    required String elevatedBtnText}) {
  return Row(
    children: [
      Flexible(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: AppLayout.getHeight(50),
          child: TextButton(
              onPressed: () => textButtonAction(),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ), backgroundColor: AppColor.backgroundColor,
                  elevation: 0,
                  side: const BorderSide(
                      width: 1, color: AppColor.normalTextColor)),
              child: Text(
                textBtnText,
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeDefault),
              )),
        ),
      ),

      customSpacerWidth(width: 12),
      Flexible(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: AppLayout.getHeight(50),
          child: TextButton(
              onPressed: () => elevatedButtonAction(),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ), backgroundColor: AppColor.primaryColor,
                  elevation: 0,
                  side: const BorderSide(
                      width: 1, color: AppColor.primaryColor)),
              child: Text(
                elevatedBtnText,
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.cardColor,
                    fontSize: Dimensions.fontSizeMid - 3),
              )),
        ),
      ),
    ],
  );
}
