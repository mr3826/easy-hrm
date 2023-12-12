import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';

AppBar customInsideAppbar({required title, Function? onPressAction}) {
  return AppBar(
    backgroundColor: AppColor.backgroundColor,
    elevation: 0,
    centerTitle: true,
    title: Text(
      "$title",
      style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),
    ),
    leading: IconButton(
        onPressed: () {
          if (onPressAction != null) {
            onPressAction();
          } else {
            Get.back();
          }
        },
        icon: const Icon(Icons.arrow_back_ios)),
  );
}
