import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';

Future customButtonSheet(
    {context,
    double? height = 0.9,
    child,
    int duration = 500,
    int reverseDuration = 400}) {
  final AnimationController controller = AnimationController(
    duration: Duration(milliseconds: duration),
    reverseDuration: Duration(milliseconds: reverseDuration),
    vsync: Navigator.of(context),
  );

  return showModalBottomSheet(
    context: context,
    transitionAnimationController: controller,
    isScrollControlled: true,
    backgroundColor: AppColor.cardColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              Dimensions.radiusMid,
            ),
            topLeft: Radius.circular(Dimensions.fontSizeMid))),
    builder: (
      context,
    ) {
      return FractionallySizedBox(
        heightFactor: AppLayout.getHeight(height!),
        child: child,
      );
    },
  );
}

Widget customButtonSheetAppbar({required text, subtext}) {
  return Container(
    color: AppColor.primaryColor.withOpacity(0.05),
    height: 100,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          text ?? "",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor, fontWeight: FontWeight.w700),
        )),
        customSpacerHeight(height: 5),
        Center(
            child: Text(
          subtext ?? "",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor,
              fontSize: Dimensions.fontSizeDefault + 2),
        )),
      ],
    ),
  );
}
