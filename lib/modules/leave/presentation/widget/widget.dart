import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

 Widget leaveLayout() {
  return SizedBox(
    height: AppLayout.getHeight(124),
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.only(left: AppLayout.getHeight(12)),
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder.copyWith(
            borderRadius: BorderRadius.circular(8)),
        color: AppColor.cardColor.withOpacity(0.2),
        child: Padding(
          padding: marginLayout.copyWith(top: 12, bottom: 12),
          child: Row(
            children: [

              Column(
                children: [
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_total_leave.tr),

                  const Spacer(),

                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_token.tr),
                ],
              ),
              const Spacer(),
              _dividerLayout(),
              const Spacer(),


              Column(
                children: [
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_paid_leave.tr),
                  const Spacer(),
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_balance.tr),
                ],
              ),

              const Spacer(),
              _dividerLayout(),
              const Spacer(),

              Column(
                children: [
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_unpaid_leave.tr),
                  const Spacer(),
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_pendding.tr),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


 Widget leaveRecordBtnLayout() {
  return GestureDetector(
    onTap: ()=>Get.toNamed(Routes.LEAVE_RECORD_SCREEN),
    child: Container(
      height: AppLayout.getHeight(36),
      width: AppLayout.getWidth(200),
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
      ),
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.text_leave_records.tr,
                style:
                AppStyle.normal_text_black.copyWith(color: AppColor.cardColor),
              ),
              customSpacerWidth(width: 6),
              const Icon(
                Icons.arrow_forward,
                color: AppColor.cardColor,
                size: 17,
              )
            ],
          )),
    ),
  );
}

AppBar get appBar {
  return AppBar(
    elevation: 0,
    title: Text(
      AppString.text_leave,
      style: AppStyle.mid_large_text.copyWith(fontSize: 20),
    ),
    actions: const [
      Icon(
        Icons.menu,
        color: AppColor.cardColor,
      )
    ],
  );
}

_countLayout({required dynamicText, required staticText}) {
  return Column(
    children: [
      Text(
        "$dynamicText",
        style: AppStyle.normal_text_black
            .copyWith(color: AppColor.cardColor, fontWeight: FontWeight.bold),
      ),
      Text(
        "$staticText",
        style: AppStyle.normal_text_black.copyWith(
            color: AppColor.cardColor.withOpacity(0.9),
            fontSize: Dimensions.fontSizeDefault - 2),
      ),
    ],
  );
}

_dividerLayout() {
  return   Column(
    children: [
      _divider(),
      const Spacer(),
      _divider(),
    ],
  );
}
_divider() {
  return Container(
    width: 0.8,
    height: AppLayout.getHeight(25),
    color: AppColor.cardColor,
  );
}
