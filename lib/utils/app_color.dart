import 'package:flutter/material.dart';

class AppColor {
  AppColor._internal();

  static final AppColor _instance = AppColor._internal();

  factory AppColor() => _instance;

  // Brand: Easy HRM - Teal primary, Amber accent
  static const Color primaryColor = Color(0xFF00796B); // Teal 700
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color secondaryColor = Color(0xFFFFA000); // Amber 700
  static const Color alertDgIconBgColor = Color(0xFFfed8b1);
  static const Color successColor = Color(0xFF0CAA1B);
  static const Color noColor = Color(0x0fffff00);
  static const Color pendingColor = Color(0xFFFFA500);
  static const Color takenColor = Color(0xFF5A49B4);
  static const Color hintColor = Color(0xFF8F99AD);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFFF0000);
  static const Color errorColorLight = Color(0xFFFE475B);
  static const Color disableColor = Color(0xFFDFDFDF);
  static const Color normalTextColor = Color(0xFF24235F);
  static const Color bgColor = Color(0xFFFFFFFF);
  static const Color solidGray = Color(0xFF8F99AD);
  static const Color alertBgColor = Color(0xfffdfbed);
  static const Color pureOrange = Color(0xffFFAB00);
  static const Color bgColorWithPrimary = Color(0xffEDECFE);
  static const Color bgColorWithTimeline = Color(0xffFBFAFF);
  static const Color leaveRecordCardColor = Color(0xffFBFAFF);
  static const Color iconBoxColor = Color(0xffFF6347);
  static const Color primaryGreen = Color(0xFF3EAC55);
  static const Color primaryOrange = Color(0xFFEF780A);
  static const Color primaryYellow = Color(0xFFF3C568);
  static const Color primaryRed = Color(0xFFFF6347);
  static const Color lightGrey = Color(0xFFDFDFDF);
  static const Color greyDark = Color(0xFF9397A0);


  static const Color interViewCandidatesColor = Color(0XFF2F79A3);
  static const Color timeLogRequestColor = Color(0XFF5A49B4);




}
