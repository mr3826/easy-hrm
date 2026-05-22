import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  final bool hasOutline;
  final Color borderColor;
  final Widget buttonText;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final double borderRadius;
  final bool isButtonExpanded;
  final IconData? iconsData;
  final double? btnTextSize;

  const CustomAppButton({
    super.key,
    this.hasOutline = false,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    this.textColor = Colors.white,
    this.borderColor = Colors.grey,
    this.isButtonExpanded = true,
    this.iconsData,
    this.borderRadius = 12.0, // Default border radius
    this.btnTextSize,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = AppLayout.getHeight(46);

    return SizedBox(
      width: isButtonExpanded ? double.infinity : null,
      height: buttonHeight,
      child: TextButton.icon(
        icon: iconsData == null
            ? const SizedBox.shrink()
            : Icon(
          iconsData,
          size: 20,
          color: textColor,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: hasOutline ? Colors.transparent : buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: hasOutline
              ? BorderSide(width: 1, color: borderColor)
              : BorderSide.none,
        ),
        onPressed: onPressed,
        label: buttonText,
      ),
    );
  }
}
