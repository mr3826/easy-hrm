import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widget/custom_text_field.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';

Widget buildRecentSearchSection() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppString.textRecentSearch.tr,
          style: AppStyle.normal_text_black.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeMid-1,
            fontWeight: FontWeight.w600,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            AppString.textClearAll.tr,
            style: AppStyle.normal_text_black.copyWith(
              color: AppColor.secondaryColor,
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildEmployeeDetails(name,department) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$name",
        style: AppStyle.mid_large_text.copyWith(
          color: AppColor.secondaryColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeDefault + 2,
        ),
      ),
      Text(
        "$department",
        style: subTextFieldTitleStyle.copyWith(
          color: AppColor.hintColor,
        ),
      ),
    ],
  );
}