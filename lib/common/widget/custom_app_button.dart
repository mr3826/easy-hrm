import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class CustomAppButton extends StatelessWidget {
  final bool? hasOutline;
  final Color? borderColor;
  final Widget buttonText;
  final Function onPressed;
  final Color buttonColor;
  final Color? textColor;
  final bool? isButtonExpanded;
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
    this.btnTextSize,
  });

  @override
  Widget build(BuildContext context) {
    return isButtonExpanded == true
        ? Expanded(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton.icon(
                  icon: iconsData == null
                      ? Container()
                      : Icon(iconsData, size: 20, color: textColor),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusMid)),
                      side: BorderSide(width: 1, color: borderColor!)),
                  onPressed: () async {
                    onPressed();
                  },
                  label: buttonText),
            ),
          )
        : SizedBox(
            width: double.infinity,
            height: AppLayout.getHeight(50),
            child: TextButton.icon(
              icon: iconsData == null
                  ? Container()
                  : Icon(iconsData, color: textColor),
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusExtraLarge)),
                  side: const BorderSide(width: 1, color: Colors.transparent)),
              onPressed: () async {
                onPressed();
              },
              label: buttonText,
            ),
          );
  }
}
