import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../common/widget/custom_dialog.dart';
import '../../../common/widget/custom_spacer.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_style.dart';
import '../../../utils/dimensions.dart';
import '../../profile/controller/log_out_controller.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: marginLayout,
        child: Column(
          children: [
            _infoContactLayout()
          ],
        ),
      ),
    );
  }

  _infoContactLayout() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Images.subscription,
          ),
          customSpacerHeight(height: 24),

          Text(
            "Subscription expired",
            style: AppStyle.normal_text_grey.copyWith(
                color: AppColor.normalTextColor,
                fontSize: Dimensions.fontSizeMid - 1),
          ),
          customSpacerHeight(height: 4),
          _descriptionLayout(),

          ///Logout button
          _logoutBtnLayout(),
          customSpacerHeight(height: 100),
        ],
      ),
    );
  }

  _logoutBtnLayout() {
    return GestureDetector(
      onTap: () {
        _logoutAlert();
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 0.0, bottom: 8, left: 24, right: 24),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Card(
              elevation: 0,
              color: AppColor.cardColor,
              shape: roundedRectangleBorder.copyWith(
                  side: const BorderSide(width: 1.2, color: AppColor.hintColor),
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                  child: Text(
                AppString.text_log_out.tr,
                style: AppStyle.small_text_black.copyWith(
                    color: AppColor.normalTextColor.withOpacity(0.6),
                    fontSize: Dimensions.fontSizeMid - 4),
              ))),
        ),
      ),
    );
  }

  _logoutTextLayout() {
    return Get.find<LogoutController>().isLogoutLoading.value
        ? const CupertinoActivityIndicator(
            color: AppColor.cardColor,
          )
        : Text(
            AppString.text_log_out.tr,
            style: AppStyle.normal_text_grey.copyWith(
                fontSize: Dimensions.fontSizeDefault + 1,
                color: AppColor.cardColor),
          );
  }

  _descriptionLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Your access to the app has been restricted due to the expiration of your subscription. Please contact the administrator for assistance.",
        textAlign: TextAlign.center,
        style: AppStyle.normal_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.5),
            fontSize: Dimensions.fontSizeDefault - 1),
      ),
    );
  }

  _logoutAlert() {
    return showCustomAlertDialog(
        context: Get.context!,
        onConfirm: () {
          Get.find<LogoutController>().logout();
        },
        iconData: Icons.logout,
        titleText: AppString.text_are_you_sure.tr,
        descriptionText: AppString.text_if_you_do_this_etc.tr,
        iconBackgroundColor: AppColor.errorColorLight,
        confirmButtonColor: AppColor.errorColorLight,
        confirmButtonText: AppString.text_log_out.tr,
        extraInfoText: "",
        descriptionFontSize: Dimensions.fontSizeDefault,
        confirmButtonChild: Obx(() => _logoutTextLayout()));
  }
}
