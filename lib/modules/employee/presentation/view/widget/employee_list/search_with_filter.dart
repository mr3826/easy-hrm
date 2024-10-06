import 'package:flutter/material.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';

class CustomButtonWithIconAndLabel extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final Widget? customIconWidget;
  final double borderRadius;
  final double elevation;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment alignment;
  final VoidCallback? onTap;

  const CustomButtonWithIconAndLabel({
    Key? key,
    this.icon,
    required this.labelText,
    this.backgroundColor = AppColor.backgroundColor,
    this.borderColor = const Color(0xFFD8E0ED),
    this.iconColor = AppColor.hintColor,
    this.customIconWidget,
    this.textColor = AppColor.normalTextColor,
    this.borderRadius = 20.0,
    this.elevation = 0.0,
    this.borderWidth = 1.2,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0),
    this.alignment = MainAxisAlignment.center,
    this.onTap, // Nullable callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap ?? () {}, // Default empty action if onTap is null
        child: Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              width: borderWidth,
              color: borderColor,
            ),
          ),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: alignment,
              children: [
                customIconWidget ?? Icon(icon, color: iconColor, size: 20),
                customSpacerWidth(width: 4),
                Text(
                  labelText,
                  style: AppStyle.normal_text_black.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
