import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../utils/dimensions.dart';




PreferredSizeWidget customAppbar({
   String? title,
  Function? onAction,
  Widget? leadingIcon,
  double? leadingWidth,
  List<Widget>? actions,
  Color? backgroundColor,
  bool centerTitle = true,
}) {
  final Widget defaultLeadingIcon = Icon(
    Icons.arrow_back_ios,
    color: AppColor.hintColor,
    size: Dimensions.fontSizeMid + 4,
  );

  final Color finalBackgroundColor = backgroundColor ?? AppColor.backgroundColor;

  return AppBar(
    elevation: 0,
    backgroundColor: finalBackgroundColor,
    leadingWidth: leadingWidth,
    leading: IconButton(
      onPressed: () => onAction?.call() ?? Get.back(),
      icon: leadingIcon ?? defaultLeadingIcon,
    ),
    centerTitle: centerTitle,
    title: Text(
      title??"",
      style: AppStyle.normal_text_black.copyWith(
        fontSize: Dimensions.fontSizeMid,
      ),
    ),
    actions: actions,
  );
}

