import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../utils/dimensions.dart';



AppBar customAppbar({
  String? title,               // Required title
  Function? onAction,          // Optional action, default to back if null
  Widget? leadingIcon,         // Optional leading icon
  double? leadingWidth,        // Optional width for leading icon
  List<Widget>? actions,       // Optional list of action widgets
  Color? backgroundColor,      // Optional background color
  bool centerTitle = true,     // Optional flag to center title (default true)
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: backgroundColor ?? AppColor.backgroundColor,  // Dynamic background
    leadingWidth: leadingWidth,  // Set the leading width if provided
    leading: IconButton(
      onPressed: () => onAction != null ? onAction() : Get.back(), // Use onAction if provided, else default to back
      icon: leadingIcon ?? Icon(  // Use leadingIcon if provided, else default back icon
        Icons.arrow_back_ios,
        color: AppColor.hintColor,
        size: Dimensions.fontSizeMid + 4,
      ),
    ),
    centerTitle: centerTitle,
    title: Text(
      title ?? "",
      style: AppStyle.normal_text_black.copyWith(
        fontSize: Dimensions.fontSizeMid,
      ),
    ),
    actions: actions,  // Optional actions, if provided
  );
}
