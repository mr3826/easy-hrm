import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomStatusButton extends StatelessWidget {
  final Color? bgColor; // Background color
  final String? text; // Button text
  final Color? textColor; // Text color
  final IconData? statusIcon; // Optional status icon
  final double? textSize; // Optional text size

  const CustomStatusButton({
    super.key,
    this.bgColor, // Optional
    this.text, // Optional
    this.textColor, // Optional
    this.statusIcon, // Optional
    this.textSize, // Optional
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: AppLayout.getHeight(28),
        decoration: BoxDecoration(
          color: bgColor ?? Colors.grey, // Default background color
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.radiusExtraLarge),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          AppLayout.getWidth(12),
          AppLayout.getHeight(0),
          AppLayout.getWidth(12),
          AppLayout.getHeight(0),
        ),
        child: Center(
          child: Text(
            text ?? "", // Default to an empty string
            maxLines: 1,
            style: AppStyle.normal_text_black.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor ?? Colors.black, // Default to black if null
              fontSize: textSize ?? Dimensions.fontSizeDefault, // Use the optional textSize
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

