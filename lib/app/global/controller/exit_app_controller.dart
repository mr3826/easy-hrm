import 'dart:io';

import 'package:flutter/services.dart';

class ExitAppController {
  Future<bool> willPop() async {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
    return false;
  }

  Future<bool> willPopForTimeLog() async {
    return false;
  }
}