import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';


Future customButtonSheet({context,double? height=0.9, child}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColor.backgroundColor,
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
