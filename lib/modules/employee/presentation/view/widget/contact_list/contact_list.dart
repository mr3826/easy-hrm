import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../common/widget/custom_status_button.dart';
import '../../../../../../utils/dimensions.dart';

buildContactListInfo({
  required String imgUrlKey,
  required String name,
  required String departmentName,
  required String statusText,
  Color? statusColor,
}) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Row(
      children: [
        CustomNetworkImage(
          imgUrlKey: imgUrlKey,
          errorText: 'ER',
          height: 34,
        ),
        customSpacerWidth(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width / 2,
              child: RichText(
                text: TextSpan(
                  text: name,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.secondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.fontSizeDefault + 2,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width / 2,
              child: RichText(
                text: TextSpan(
                  text: departmentName,
                  style: subTextFieldTitleStyle.copyWith(
                    color: AppColor.hintColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppLayout.getHeight(34),
              child: CustomStatusButton(
                textColor: statusColor ?? AppColor.primaryColor,
                bgColor: statusColor?.withOpacity(0.2) ??
                    AppColor.primaryColor.withOpacity(0.2),
                text: statusText,
                textSize: 13,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_horiz,
            color: AppColor.hintColor,
            size: 26,
          ),
        ),
      ],
    ),
  );
}
