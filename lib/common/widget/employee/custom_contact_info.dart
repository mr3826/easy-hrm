import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class CustomContactInfoWidget extends StatelessWidget {
  final String staticText;                     // Label (e.g., "Email", "Mobile Number")
  final String? dynamicText;                   // Dynamic content (e.g., user's email or mobile number)
  final bool isActionVisible;                   // Show action button
  final VoidCallback? onAction;                 // Callback for action button
  final String actionText;                      // Text for the action button
  final TextStyle? staticTextStyle;            // Custom style for static text
  final TextStyle? dynamicTextStyle;           // Custom style for dynamic text
  final TextStyle? actionTextStyle;            // Custom style for action text

  const CustomContactInfoWidget({
    Key? key,
    required this.staticText,
    this.dynamicText,
    this.isActionVisible = false,
    this.onAction,
    this.actionText = "Change",  // Default action text
    this.staticTextStyle,
    this.dynamicTextStyle,
    this.actionTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          staticText,
          style: staticTextStyle ?? AppStyle.normal_text_grey.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
        ),
        customSpacerHeight(height: 2), // Custom spacer for vertical spacing
        Text(
          dynamicText?.isNotEmpty == true ? dynamicText! : "Not added yet",
          style: dynamicTextStyle ?? AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault - 1,
          ),
        ),
        customSpacerHeight(height: 8), // Custom spacer for vertical spacing
        if (isActionVisible)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionText.tr, // Localized action text
              style: actionTextStyle ?? AppStyle.normal_text_grey.copyWith(
                color: AppColor.secondaryColor,
                fontSize: Dimensions.fontSizeDefault - 2,
              ),
            ),
          ),
      ],
    );
  }
}
