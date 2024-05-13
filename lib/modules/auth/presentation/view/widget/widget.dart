import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';

Widget backToLoginLayout() {
  return GestureDetector(
      onTap: () => Get.toNamed(Routes.SIGN_IN_SCREEN),
      child: Center(
          child: Text(
            AppString.text_back_to_login.tr,
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeDefault-2),
          )));
}