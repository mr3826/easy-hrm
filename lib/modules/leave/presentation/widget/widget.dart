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
    height: AppLayout.getHeight(115),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_total.tr),
                  const Spacer(),
                  _divider(),
                  const Spacer(),
                  _countLayout(
                      dynamicText: "12d 06h",
                      staticText: AppString.text_token.tr),
                  const Spacer(),
                  _divider(),
                  const Spacer(),
                  _countLayout(
                      dynamicText: "12d 03h",
                      staticText: AppString.text_avaiable.tr),

                ],
              ),
              const Spacer(),
              _tabToViewLeaveRecord()
            ],
          ),
        ),
      ),
    ),
  );
}

_tabToViewLeaveRecord() {
   return GestureDetector(
     onTap: ()=>Get.toNamed(Routes.LEAVE_RECORD_SCREEN),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Text(AppString.text_tab_to_view_leave_record.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.cardColor, decoration: TextDecoration.underline,
           fontSize: Dimensions.fontSizeDefault,
         ),),
         customSpacerWidth(width: 10),
         const Icon(Icons.arrow_forward,color: AppColor.cardColor,size: 18,)
       ],
     ),
   );
}



AppBar get appBar {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      AppString.text_leave,
      style: AppStyle.mid_large_text.copyWith(fontSize: 20),
    ),
  );
}

_countLayout({required dynamicText, required staticText}) {
  return Column(
    children: [
      Text(
        "$dynamicText",
        style: AppStyle.normal_text_black
            .copyWith(color: AppColor.cardColor, fontWeight: FontWeight.bold,fontSize: Dimensions.fontSizeMid-2),
      ),
      Text(
        "$staticText",
        style: AppStyle.normal_text_black.copyWith(
            color: AppColor.cardColor.withOpacity(0.9),
            fontSize: Dimensions.fontSizeDefault-1),
      ),
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
