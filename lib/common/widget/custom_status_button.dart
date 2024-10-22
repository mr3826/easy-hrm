import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class CustomStatusButton extends StatelessWidget {
  final Color bgColor; // Background color
  final String text; // Button text
  final Color textColor; // Text color
  final IconData? statusIcon; // Optional status icon
  final double textSize; // Text size
  final double paddingTop; // Padding top

  const CustomStatusButton({
    Key? key,
    this.bgColor = Colors.grey, // Default background color
    this.text = "", // Default to empty string
    this.textColor = Colors.black, // Default text color
    this.statusIcon, // Optional icon
    this.paddingTop = 8.0, // Default top padding
    this.textSize = 14, // Default text size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppLayout.getWidth(12),
          vertical: AppLayout.getHeight(3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (statusIcon != null) // Display icon if provided
              Icon(
                statusIcon,
                size: AppLayout.getHeight(18),
                color: textColor,
              ),
            if (statusIcon != null) SizedBox(width: AppLayout.getWidth(4)), // Space between icon and text
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.normal_text_black.copyWith(
                fontWeight: FontWeight.w500,
                color: textColor,
                fontSize: textSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
