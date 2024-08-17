import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../starting/view/splash_screen.dart';

Widget dateLayoutField({required onAction,required date}) {
  DateTime originalDate = DateTime.parse(date);
  String formattedDate = DateFormat("yyyy-MM-dd").format(originalDate);
  return  InkWell(
    onTap: ()=>onAction(),
    child: Container(
      width: double.infinity,
      decoration: decorationStyle.copyWith(border: Border.all(width: 1,color: AppColor.hintColor.withOpacity(0.9)),borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      padding: marginLayout.copyWith(
          top: 14, bottom: 14, left: 14, right: 14),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formattedDate,
              style: AppStyle.normal_text_grey,
            ),
            const Icon(
              Icons.calendar_today_outlined,
              color: AppColor.hintColor,
            )
          ]),
    ),
  );
}