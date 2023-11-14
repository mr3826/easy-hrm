import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_spacer.dart';


Future exitDialog({context, yesAction}) {
  return showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: AlertDialog(
          title: _titleText(titleText: AppString.text_are_you_sure),
          shape: roundedRectangleBorder,
          icon: _iconBox(
              iconColor: AppColor.pendingTextColor,
              icon: Icons.logout,
              iconBgColor: Colors.orange.shade50),
          content: _contentText(
              contentText: AppString.text_are_you_sure_want_to_exit_from_app),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
              child: Row(
                children: [
                  Flexible(
                      child: _cancelBtn(
                          child: TextButton(
                              onPressed: () => Get.back(),
                              style: elevatedBtmStyle,
                              child: _noText),
                          context: context)),
                  customSpacerWidth(width: 12),
                  Flexible(
                      child: _saveBtn(
                    child: ElevatedButton(
                        onPressed: () => yesAction(),
                        style: saveBtnStyle(buttonColor: Colors.orange),
                        child: _saveText(yesText: AppString.text_yes)),
                  ))
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _iconBox({required iconBgColor, required icon, required iconColor}) {
  return Center(
    child: Container(
        width: AppLayout.getWidth(50),
        height: AppLayout.getHeight(50),
        decoration: boxDecoration(iconBgColor: iconBgColor),
        child: Icon(
          icon,
          color: iconColor,
          size: Dimensions.fontSizeDoubleLarge + 2,
        )),
  );
}

BoxDecoration boxDecoration({iconBgColor}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
    color: iconBgColor,
  );
}

Widget _contentText({required contentText}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Text(contentText!,
            textAlign: TextAlign.center,
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault - 1)),
      ),
    ],
  );
}

Widget _cancelBtn({required context, required child}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: AppLayout.getHeight(40),
    child: child,
  );
}

Widget _saveText({required yesText}) {
  return Text(
    yesText!,
    style: AppStyle.mid_large_text.copyWith(
        color: AppColor.cardColor,
        fontSize: Dimensions.fontSizeMid - 3,
        fontWeight: FontWeight.w600),
  );
}

ButtonStyle get elevatedBtmStyle {
  return ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: AppColor.backgroundColor,
    elevation: 0,
    side: borderSide,
  );
}

BorderSide get borderSide {
  return const BorderSide(width: 1, color: AppColor.normalTextColor);
}

Text get _noText {
  return Text(
    AppString.text_no,
    style: AppStyle.mid_large_text.copyWith(
        color: AppColor.normalTextColor, fontSize: Dimensions.fontSizeMid - 2),
  );
}

Widget _saveBtn({required child}) {
  return SizedBox(
    width: double.infinity,
    height: AppLayout.getHeight(40),
    child: child,
  );
}

Widget _titleText({required titleText}) {
  return Text(
    titleText!,
    style: titleTextStyle,
  );
}

TextStyle get titleTextStyle {
  return AppStyle.large_text.copyWith(
      fontSize: Dimensions.fontSizeLarge - 1,
      color: AppColor.normalTextColor,
      fontWeight: FontWeight.w600);
}

RoundedRectangleBorder get roundedRectangleBorder {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
  );
}

ButtonStyle saveBtnStyle({required buttonColor}) {
  return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: buttonColor,
      elevation: 0);
}
