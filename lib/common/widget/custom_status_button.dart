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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: AppLayout.getHeight(28),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.radiusExtraLarge),
            )),
        padding: EdgeInsets.fromLTRB(
            AppLayout.getWidth(17),
            AppLayout.getHeight(0),
            AppLayout.getWidth(17),
            AppLayout.getHeight(0)),
        child: Center(
          child: Text(text ?? "",
              maxLines: 1,
              style: AppStyle.normal_text_black.copyWith(
                fontWeight: FontWeight.w500,
                  color: textColor, fontSize: Dimensions.fontSizeDefault,overflow: TextOverflow.ellipsis)),
        ),
      ),
    );
  }
}
