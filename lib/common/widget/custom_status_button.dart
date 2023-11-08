import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';


class CustomStatusButton extends StatelessWidget {
  final Color bgColor;
  final String? text;
  final Color textColor;

  const CustomStatusButton(
      {super.key, required this.bgColor, this.text,required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.radiusMid),
          )),
      padding: EdgeInsets.symmetric(
          horizontal: AppLayout.getHeight(Dimensions.paddingLarge),
          vertical: AppLayout.getWidth(6),

      ),
      child: Text(text??"", style: AppStyle.small_text.copyWith(color: textColor)),
    );
  }
}
