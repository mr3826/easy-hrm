import 'package:flutter/services.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Future customAlertDialog({context, yesAction}) {
  return showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: AlertDialog(
          title: _titleText(titleText: AppString.text_are_you_sure),
          shape: roundedRectangleBorder.copyWith(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
          icon: _iconBox(iconColor: AppColor.secondaryColor, icon: Icons.logout,iconBgColor: AppColor.secondaryColor.withOpacity(0.1)),
          content: _contentText(
              contentText: AppString.text_are_you_sure_want_to_exit_from_app),
          actionsAlignment: MainAxisAlignment.center,
          actions: [

            Padding(
              padding: marginLayout.copyWith(left: 6,right: 6,bottom: 6),
              child: CustomDoubleAppButton(buttonText: AppString.text_yes.tr, onAction: (){
                SystemNavigator.pop();
              }, cancelAction: (){
                Navigator.pop(context);
              }),
            )
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
