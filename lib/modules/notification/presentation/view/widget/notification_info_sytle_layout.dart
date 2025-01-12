import 'package:flutter/cupertino.dart';
import 'package:payrun_mobile/common/widget/custom_icon_shape_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

import '../../../../../app/global/view/widget/app_margin.dart';

Widget notificationInfoLayout(
    {required context,
    required titleText,
    required subtext,
    required min,
    required Color iconColor,
    required iconUrl,
    required dateText,
    unselectedColor = AppColor.backgroundColor,
    required onAction}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: AppLayout.getHeight(160),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      color: unselectedColor.withOpacity(0.06),
    ),
    child: GestureDetector(
      onTap: onAction,
      child: Padding(
        padding: marginLayout.copyWith(top: 14, left: 14, right: 0, bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customIconShapeStyle(image: iconUrl, color: iconColor),
            customSpacerWidth(width: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$titleText",
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.secondaryColor,
                        fontSize: Dimensions.fontSizeMid - 3,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "$subtext",
                    maxLines: 3,
                    style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.normalTextColor,
                      fontSize: Dimensions.fontSizeDefault,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "$dateText",
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.normalTextColor,
                        fontSize: Dimensions.fontSizeMid - 4,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "$min",
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 1),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
