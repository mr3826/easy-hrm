import 'dart:core';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/language/english.dart';
import 'norwegian.dart';


class Internationalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': eng,
        'no_NO': nn,
      };
}
