import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomStatusButton extends StatelessWidget {
  final Color bgColor;
  final String? text;
  final Color textColor;
  final IconData? statusIcon;

  const CustomStatusButton(
      {super.key,
      required this.bgColor,
      this.text,
      required this.textColor,
      this.statusIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.radiusMid),
          )),
      padding: EdgeInsets.fromLTRB(
          AppLayout.getWidth(14),
          AppLayout.getHeight(3),
          AppLayout.getWidth(14),
          AppLayout.getHeight(4)),
      child: Row(
        children: [
          statusIcon != null
              ? Icon(
                  statusIcon,
                  color: textColor,
                  size: 16,
                )
              : Container(),
          customSpacerWidth(width: 4),
          Text(text ?? "",
              style: AppStyle.normal_text_grey.copyWith(
                  color: textColor, fontSize: Dimensions.fontSizeDefault)),
        ],
      ),
    );
  }
}
