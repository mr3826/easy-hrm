import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/utils/app_color.dart';
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
      {super.key, required this.bgColor, this.text,required this.textColor,this.statusIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.radiusMid),
          )),
      padding: EdgeInsets.symmetric(
          horizontal: AppLayout.getHeight(Dimensions.paddingDefault+3),
          vertical: AppLayout.getWidth(3),

      ),
      child: Row(
        children: [
           Icon(statusIcon,color: textColor,size: 16,),
          customSpacerWidth(width: 4),
          Text(text??"", style: AppStyle.small_text.copyWith(color: textColor)),
        ],
      ),
    );
  }
}
