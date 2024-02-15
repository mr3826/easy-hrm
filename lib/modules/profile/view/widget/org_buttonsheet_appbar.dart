import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';

Widget orgButtonSheetAppbar({required orgLength}) {
  return Container(
    color: AppColor.primaryColor.withOpacity(0.05),
    height: 100,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          AppString.text_organization.tr,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor, fontWeight: FontWeight.w700),
        )),
        customSpacerHeight(height: 5),
        Center(
            child: Text(
          "${AppString.text_you_have.tr} $orgLength ${AppString.text_org_linked_with_your.tr}",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor, fontSize: Dimensions.fontSizeDefault),
        )),
        Center(
            child: Text(
          AppString.text_account.tr,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor, fontSize: Dimensions.fontSizeDefault),
        )),
      ],
    ),
  );
}
