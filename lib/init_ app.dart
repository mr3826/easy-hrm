import 'package:payrun_mobile/modules/profile/controller/password_controller.dart';
import 'package:payrun_mobile/modules/starting/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'common/controller/date_time_helper_controller.dart';
import 'modules/auth/presentation/controller/forgot_password_controller.dart';
import 'modules/auth/presentation/controller/signin_controller.dart';
import 'modules/leave/presentation/controller/calendar_date_controller.dart';
import 'modules/leave/presentation/controller/file_upload_controller.dart';
import 'modules/leave/presentation/controller/picked_file_form_storage.dart';
import 'modules/profile/controller/profile_image_selected_controller.dart';


Future<void> initApp() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  Get.put(SplashController());
  Get.put(SignInController());
  Get.put(ForgotPasswordController());
  Get.put(DateTimeController());
  Get.put(FileUploadController());
  Get.put(PickedFileFormStorage());
  Get.put(DateController());
  Get.put(PikedProfileImgController());
  Get.put(PasswordController());

}
