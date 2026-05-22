import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/widget/custom_dialog.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';

Future<bool> get appExitChecker => _onWillPop();

Future<bool> _onWillPop() async {
  return showCustomAlertDialog(
    context: Get.context!,
    onConfirm: () {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    },
    iconData: Icons.logout,
    titleText: AppString.text_are_you_sure.tr,
    descriptionText: "${AppString.text_are_you_sure_want_to_exit_from_app.tr}.",
    iconBackgroundColor: AppColor.secondaryColor,
    confirmButtonColor: AppColor.secondaryColor,
    confirmButtonText: AppString.text_yes.tr,
    extraInfoText: "",
    descriptionFontSize: Dimensions.fontSizeDefault,
  );
}
