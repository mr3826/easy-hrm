import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

ThemeData get appTheme => _themeData;

ThemeData _themeData = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
     foregroundColor: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle(
    //statusBarColor: Colors.black12,
    ),),

  // scaffoldBG, applicable for aLL PAGES
  scaffoldBackgroundColor: AppColor.backgroundColor,
  //primary color for the application
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColor.primaryColor,
  ),



);
