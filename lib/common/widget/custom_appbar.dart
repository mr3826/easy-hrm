import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';

import '../../utils/dimensions.dart';

AppBar customAppbar({required title, Function? onAction}) {
  return AppBar(
    elevation: 0,
    backgroundColor: AppColor.backgroundColor,
    leading: IconButton(
      onPressed: () => onAction ?? Get.back(),
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColor.hintColor,
        size: Dimensions.fontSizeMid + 4,
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      style:
          AppStyle.normal_text_black.copyWith(fontSize: Dimensions.fontSizeMid),
    ),
  );
}
