import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget projectViewBtnSheetAppbar({required  DateTime date, required String duration, required Color bgColor}) {
  print("date1 :: $date");
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Container(
      height: AppLayout.getHeight(130),
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                Dimensions.radiusMid,
              ),
              topRight: Radius.circular(
                Dimensions.radiusMid,
              ))),
      child: Column(
        children: [
          customSpacerHeight(height: 12),
          _divider(),
          customSpacerHeight(height: 15),
          Center(
              child: Text(_getDate(date),
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.cardColor.withOpacity(0.9),
                fontSize: Dimensions.fontSizeDefault),
          )),
          customSpacerHeight(height: 12),
          Center(
              child: Text(
           AppString.text_duration.tr,
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.cardColor.withOpacity(0.9),
                fontSize: Dimensions.fontSizeDefault),
          )),
          Center(
              child: Text(
            duration,
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.cardColor.withOpacity(0.9),
                fontWeight: FontWeight.w700,
                fontSize: Dimensions.fontSizeMid + 2),
          )),
        ],
      ),
    ),
  );
}

String _getDate(date) {
  if(date==null)return "";
  return DateFormat('E, d MMMM - y', 'en_US').format(date);
}

_divider() {
  return Container(
    width: AppLayout.getWidth(130),
    height: AppLayout.getHeight(3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
      color: AppColor.cardColor.withOpacity(0.3),
    ),
  );
}
