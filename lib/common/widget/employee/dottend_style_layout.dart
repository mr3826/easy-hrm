import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../utils/app_layout.dart';

class DottedStyleLayout extends StatelessWidget {
  final double height;
  final double width; // Added width parameter for horizontal orientation
  final EdgeInsetsGeometry padding;
  final Color dottedBorderColor;
  final List<double> dashPattern;
  final double strokeWidth;
  final Color dividerColor;
  final bool isVertical; // New parameter for orientation

  const DottedStyleLayout({
    Key? key,
    required this.height,
    this.width = double.infinity, // Default to full width for horizontal
    this.padding = const EdgeInsets.only(left: 28.0),
    this.dottedBorderColor = Colors.grey,
    this.dashPattern = const [4, 4],
    this.strokeWidth = 1.2,
    this.dividerColor = Colors.transparent,
    this.isVertical = false, // Default to horizontal
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DottedBorder(
        customPath: (p0) {
          if (isVertical) {
            return Path()..lineTo(0, AppLayout.getHeight(height)); // Vertical line
          } else {
            return Path()..lineTo(AppLayout.getWidth(width), 0); // Horizontal line
          }
        },
        color: dottedBorderColor.withOpacity(0.6),
        dashPattern: dashPattern,
        strokeWidth: strokeWidth,
        child: isVertical
            ? Column(
          children: [
            Divider(
              height: AppLayout.getHeight(height),
              color: dividerColor,
            ),
          ],
        )
            : Row(
          children: [
            Divider(
              height: AppLayout.getHeight(height),
              color: dividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
