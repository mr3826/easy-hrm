import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_layout.dart';


class AppStyle {
  AppStyle._();

  static TextStyle title_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.paddingExtraLarge),
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins");
  static TextStyle timer_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeDoubleLarge),
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins");

  static TextStyle small_text = GoogleFonts.poppins(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeSmall),
      color: AppColor.cardColor,
      fontWeight: FontWeight.w500,
   );

  static TextStyle small_text_grey = GoogleFonts.poppins(
    fontSize: AppLayout.getWidth(12),
    color: Colors.grey,
    fontWeight: FontWeight.w500,
  );
  static TextStyle small_text_black = GoogleFonts.poppins(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeSmall),
      color: AppColor.normalTextColor,
      fontWeight: FontWeight.w500,
      );

  static TextStyle normal_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeDefault),
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins");
  static TextStyle normal_text_black = TextStyle(
      fontSize: Dimensions.fontSizeDefault,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins");
  static TextStyle normal_text_grey = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeDefault),
      color: Colors.grey,
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins");

  static TextStyle large_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeExtraDefault),
      color: AppColor.cardColor,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins");

  static TextStyle large_text_black = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeExtraDefault),
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins");

  static TextStyle mid_large_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeMid),
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins");

  static TextStyle extra_large_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeLarge),
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins");
  static TextStyle extra_large_text_black= TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeLarge),
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins");
  static BoxDecoration ContainerStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(Dimensions.radiusMid,),);

}
