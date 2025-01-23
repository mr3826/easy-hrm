import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget floatingTimmerButton(
    {required Color bgBtnColor,
      required String btnText,
      required Function onAction,
      IconData? icon}) {
  return Expanded(
    child: InkWell(
      onTap: () => onAction(),
      child: Container(
        decoration: BoxDecoration(
            color: bgBtnColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
        height: AppLayout.getHeight(46),
        width: double.infinity,
        child: GetStorage().read("languageCode") != null &&
            (GetStorage().read("languageCode")) == "no"
            ? _languageNotNullLayout(icon, btnText)
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.add,
              color: AppColor.cardColor,
              size: 17,
            ),
            customSpacerWidth(width: 4),
            Text(
              btnText,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.cardColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimensions.radiusMid - 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    ),
  );
}

_languageNotNullLayout(icon, btnText) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Center(
          child: Icon(
            icon ?? Icons.add,
            color: AppColor.cardColor,
            size: 17,
          ),
        ),
        customSpacerWidth(width: 4),
        Expanded(
            flex: 5,
            child: Text(
              btnText,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.cardColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimensions.radiusMid - 1,
                  overflow: TextOverflow.ellipsis),
            )),
        const Spacer(),
      ],
    ),
  );
}

Widget startTimerOpenBtn(
    {required Color bgBtnColor,
      required String btnText,
      required Function onAction,
      IconData? icon}) {
  return Expanded(
    child: InkWell(
      onTap: () => onAction(),
      child: Container(
        decoration: BoxDecoration(
            color: bgBtnColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
        height: AppLayout.getHeight(46),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_box_outline_blank,
              color: AppColor.cardColor.withOpacity(0.9),
              size: 20,
            ),
            customSpacerWidth(width: 4),
            Center(
                child: Text(
                  btnText,
                  style: AppStyle.normal_text_grey.copyWith(
                      color: AppColor.cardColor,
                      fontSize: Dimensions.fontSizeDefault + 1),
                )),
          ],
        ),
      ),
    ),
  );
}
