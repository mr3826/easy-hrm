import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';

ThemeData get appTheme => _themeData;

ThemeData _themeData = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    backgroundColor: Colors.white, // Always white
    elevation: 0, // No shadow/elevation
    iconTheme: IconThemeData(color: Colors.black),
    foregroundColor: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // Icons for light background
    ),
  ),
  brightness: Brightness.light, // Can be light or dark
  scaffoldBackgroundColor: AppColor.backgroundColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColor.primaryColor),



);
