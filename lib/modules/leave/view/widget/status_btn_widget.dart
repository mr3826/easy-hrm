import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget approvedStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.successColor,
    bgColor: AppColor.successColor.withOpacity(0.1),
    text: AppString.text_approved.tr,
  );
}

Widget rejectedStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.errorColorLight,
    bgColor: AppColor.errorColor.withOpacity(0.1),
    text: AppString.text_rejected.tr,
  );
}

Widget pendingStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.pendingColor,
    bgColor: AppColor.pendingColor.withOpacity(0.2),
    text: AppString.text_pendding.tr,
  );
}

Widget tokenStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.primaryColor,
    bgColor: AppColor.primaryColor.withOpacity(0.1),
    text: AppString.text_token.tr,
  );
}

Widget canceledStatusBtn() {
  return CustomStatusButton(
    textColor: AppColor.bgColor,
    bgColor: AppColor.errorColor.withOpacity(0.6),
    text: AppString.text_canceled.tr,
  );
}

statusBtn({required status}) {
  if (status == "rejected") {
    return rejectedStatusBtn();
  } else if (status == "pending") {
    return pendingStatusBtn();
  } else if (status == "taken") {
    return tokenStatusBtn();
  } else {
    return approvedStatusBtn();
  }
}

buttonLayout({required context, required status}) {
  if (status == "rejected") {
    return _rejectedBtn(context);
  } else if (status == "pending") {
    return _pendingLayout(context);
  } else if (status == "taken") {
    return Container();
  } else {
    return _approvedLayout(context);
  }
}

_rejectedBtn(context) {
  return Padding(
    padding: marginLayout,
    child: CustomDoubleAppButton(
        cancelAction: () {
          customDialog(
              context: context,
              saveBtnAction: () => Get.back(),
              icon: Icons.delete_outline_outlined,
              titleText: AppString.text_remove_time_log.tr,
              subText: AppString.text_sure_you_want_to_deleted_this_log.tr,
              drcText: AppString.text_if_you_deleted_this_time_log_etc.tr,
              iconBgColor: AppColor.errorColorLight,
              btnBgColor: AppColor.errorColorLight,
              btnText: AppString.text_remove.tr);
        },
        buttonText: AppString.text_details.tr,
        cancelText: AppString.text_remove.tr,
        onAction: () {},
        btnColor: AppColor.primaryColor),
  );
}

_pendingLayout(context) {
  return Padding(
    padding: marginLayout,
    child: CustomDoubleAppButton(
        cancelAction: () {
          customDialog(
              context: context,
              saveBtnAction: () => Get.back(),
              icon: Icons.delete_outline_outlined,
              titleText: AppString.text_remove_time_log.tr,
              subText: AppString.text_sure_you_want_to_deleted_this_log.tr,
              drcText: AppString.text_if_you_deleted_this_time_log_etc.tr,
              iconBgColor: AppColor.errorColorLight,
              btnBgColor: AppColor.errorColorLight,
              btnText: AppString.text_remove.tr);
        },
        buttonText: AppString.text_details.tr,
        cancelText: AppString.text_remove.tr,
        onAction: () {},
        btnColor: AppColor.primaryColor),
  );
}

_approvedLayout(context) {
  return Padding(
    padding: marginLayout,
    child: CustomAppButton(
      buttonText: Text(
        AppString.text_details.tr,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.cardColor,
            fontSize: Dimensions.fontSizeDefault + 2),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      buttonColor: AppColor.primaryColor,
      isButtonExpanded: false,
    ),
  );
}
