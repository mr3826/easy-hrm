import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLayout {
  static getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static _getScreenHeight() => Get.height;

  static _getScreenWidth() => Get.width;

  static double getHeight(double pixel) {
    double x = _getScreenHeight() / pixel;
    return _getScreenHeight() / x;
  }

  static double getWidth(double pixel) {
    double x = _getScreenWidth() / pixel;
    return _getScreenWidth() / x;
  }
}
