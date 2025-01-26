import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';

Widget dottedBorderLayoutView({required double height}){
  return  DottedBorder(
    borderType: BorderType.Rect, // Set the border type to horizontal
    customPath: (p0) => Path()..lineTo(height, 0),
    color: AppColor.hintColor.withOpacity(0.6),
    dashPattern: const [6, 7],
    strokeWidth: 1.5,
    child: Divider(
      height: AppLayout.getHeight(26),
      color: AppColor.noColor,

    ),
  );
}


Widget horizontalDashLayout(){
  return Expanded(
    child: CustomPaint(
      painter: DashedLinePainter(),
    ),
  );
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColor.hintColor.withOpacity(0.8)
      ..strokeWidth = .7;
    double dashWidth = 4;
    double dashSpace = 4;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
