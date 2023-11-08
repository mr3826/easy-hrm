import 'package:payrun_mobile/modules/starting/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


Future<void> initApp() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  Get.put(SplashController(), permanent: true);

}
