import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController{

  void changeLanguage(String languageCode, String countryCode){
    var locale=Locale(languageCode,countryCode);
    GetStorage().write("languageCode", languageCode);
    GetStorage().write("countryCode", countryCode);
    Get.updateLocale(locale);
  }
}