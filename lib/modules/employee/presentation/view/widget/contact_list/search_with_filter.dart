import 'package:flutter/material.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';

class SearchAndFilterButton extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
 final Widget ?widget;
  final VoidCallback? onTap;

   const SearchAndFilterButton({
    Key? key,
     this.icon,
    required this.labelText,
    this.backgroundColor = AppColor.backgroundColor,
    this.borderColor = const Color(0xFFD8E0ED),
    this.iconColor = AppColor.hintColor,
    this.widget,
    this.textColor = AppColor.normalTextColor,
    this.onTap, // Nullable callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap ?? () {}, // Default empty action if onTap is null
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(
            width: 1.2,color: borderColor
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              widget??  Icon(icon, color: iconColor, size: 20),
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
