import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/dimensions.dart';


Future customDialogLayout({required controller, required onAction,    IconData? icon=CupertinoIcons.delete,}) {
  return showDialog(
    barrierDismissible: true,
    context: Get.context!,
    builder: (context) {
      return Dialog(

        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        insetPadding: EdgeInsets.zero,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, 3),
                  )
                ]),
            margin: EdgeInsets.symmetric(
                horizontal: AppLayout.getWidth(Dimensions.paddingLarge)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customSpacerHeight(height: 20),
                _iconBox(
                    iconColor: AppColor.iconBoxColor,
                    icon:  Icon(icon, color: AppColor.errorColor.withOpacity(0.5),
                        size: Dimensions.fontSizeDoubleLarge + 5),
                    iconBgColor: AppColor.iconBoxColor.withOpacity(0.2)
                ),
                customSpacerHeight(height: 20),
                _titleText(titleText: AppString.text_are_you_sure),
                customSpacerHeight(height: 15),
                _contentText(),
                customSpacerHeight(height: 36),
                 Obx(() => controller.isLoading.value==true
                     ? loadingIndicatorLayout(height: 50)
                     : _buttonLayout(context: context,onAction: onAction),),

                customSpacerHeight(height: 20)
              ],
            )),
      );
    },
  );
}

_iconBox({required Color iconColor, required Widget icon, required Color iconBgColor}) {
  return Center(
    child: Container(
      width: AppLayout.getWidth(56),
      height: AppLayout.getHeight(56),
      decoration: boxDecoration(iconBgColor: iconBgColor),
      child: icon,

    ),
  );
}

_titleText({required String titleText}) {
  return Text(
    titleText,
    style: _titleTextStyle,
  );
}

_contentText() {
  return  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Text(AppString.text_dialog_dec,
            textAlign: TextAlign.center,
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault)),
      ),
    ],
  );
}



TextStyle get _titleTextStyle {
  return AppStyle.large_text.copyWith(
      fontSize: Dimensions.fontSizeLarge+1,
      color: AppColor.normalTextColor,
      fontWeight: FontWeight.w600);
}

_buttonLayout({ required context,required onAction}) {
  return  Padding(
    padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
    child: Row(
      children: [
        AppButton(
          buttonText: Text(
           AppString.text_no,overflow: TextOverflow.ellipsis,
            style: AppStyle.normal_text.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),



          onPressed: () {
            Get.back();
          },
          buttonColor: Colors.transparent,
          textColor: AppColor.normalTextColor,
          borderColor: AppColor.normalTextColor,

        ),
        customSpacerWidth(width: 10),
        AppButton(
              buttonText: Text(
  AppString.text_yes,overflow: TextOverflow.ellipsis,
  style: AppStyle.normal_text.copyWith(
  fontWeight: FontWeight.w600,
  ),
  ),
            onPressed: ()=>onAction(),
            hasOutline: false,
            borderColor: AppColor.iconBoxColor,
            buttonColor: AppColor.iconBoxColor),
      ],
    ),
  );
}
BoxDecoration boxDecoration({iconBgColor}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
    color: iconBgColor,
  );
}