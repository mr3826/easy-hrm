import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/dimensions.dart';

Widget dottedCircleStyle({required child, bool? isErrorOccurred}) {
  return DottedBorder(
    radius: Radius.circular(Dimensions.radiusMid),
    color:
        isErrorOccurred == true ? AppColor.errorColorLight : AppColor.disableColor,
    strokeCap: StrokeCap.square,
    dashPattern: const [8, 6],
    strokeWidth: AppLayout.getWidth(2),
    child: SizedBox(
      height: AppLayout.getHeight(140),
      child: child,
    ),
  );
}
