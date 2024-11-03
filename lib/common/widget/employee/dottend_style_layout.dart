import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../utils/app_color.dart';


class CustomDottedStyle extends StatelessWidget {
  final Widget? child;
  final bool isErrorOccurred;
  final double height;
  final double width;
  final StrokeCap? strokeCap;
  final EdgeInsetsGeometry padding;
  final Color dottedBorderColor;
  final List<double> dashPattern;
  final double strokeWidth;
  final bool isVertical;
  final bool isSquare;

  const CustomDottedStyle({
    Key? key,
    this.child,
    this.strokeCap,
    this.isErrorOccurred = false,
    this.height = 140.0,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(0),
    this.dottedBorderColor = Colors.grey,
    this.dashPattern = const [7, 6],
    this.strokeWidth = 1.0,
    this.isVertical = false,
    this.isSquare = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DottedBorder(
        strokeCap: strokeCap ?? StrokeCap.butt,
        customPath: (size) {
          if (isSquare) {
            return Path()
              ..addRect(Rect.fromLTWH(0, 0, width, height));
          } else if (isVertical) {
            return Path()
              ..moveTo(size.width / 2, 0)
              ..lineTo(size.width / 2, height);
          } else {
            return Path()
              ..moveTo(0, size.height / 2)
              ..lineTo(width, size.height / 2);
          }
        },
        color: isErrorOccurred ? AppColor.errorColorLight : dottedBorderColor.withOpacity(0.6),
        dashPattern: dashPattern,
        strokeWidth: strokeWidth,
        child: SizedBox(
          height: height,
          width: isVertical ? strokeWidth : width,
          child: child ?? Container(),
        ),
      ),
    );
  }
}
