import 'package:payrun_mobile/utils/app_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool? hasOutline;
  final Color? borderColor;
  final String buttonText;
  final Function onPressed;
  final Color buttonColor;
  final Color? textColor;
  final bool? isButtonExpanded;
  final IconData? iconsData;

  const AppButton({super.key,
    this.hasOutline = false,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    this.textColor = Colors.white,
    this.borderColor = Colors.grey,
    this.isButtonExpanded = true,
    this.iconsData,

  });

  @override
  Widget build(BuildContext context) {
    return isButtonExpanded == true
        ? Expanded(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton.icon(
                icon: iconsData == null ? Container() : Icon(iconsData,size: 20,color: textColor),
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(width: 1, color: borderColor!)),
                onPressed: () async {
                  onPressed();
                },
                label: Text(
                  buttonText,overflow: TextOverflow.ellipsis,
                  style: textColor != null
                      ? AppStyle.normal_text.copyWith(
                          color: textColor,
                          fontWeight: hasOutline == false
                              ? FontWeight.w600
                              : FontWeight.w400)
                      : AppStyle.normal_text.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                ),
              ),
            ),
          )
        : SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 18,
            child: TextButton.icon(
              icon: iconsData == null ? Container() : Icon(iconsData,color: textColor),
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(width: 1, color: borderColor!)),
              onPressed: () async {
                onPressed();
              },
              label: Text(
                buttonText,
                style: textColor != null
                    ? AppStyle.normal_text.copyWith(
                        color: textColor,
                        fontWeight: hasOutline == false
                            ? FontWeight.w600
                            : FontWeight.w400)
                    : AppStyle.normal_text.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
              ),
            ),
          );
  }
}
