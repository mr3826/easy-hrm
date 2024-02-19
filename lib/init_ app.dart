import 'package:payrun_mobile/common/controller/connectivity_controller.dart';
import 'package:payrun_mobile/modules/profile/controller/password_controller.dart';
import 'package:payrun_mobile/modules/profile/controller/update_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/modules/timeline/controller/selected_task_controller.dart';
import 'common/controller/date_time_controller.dart';
import 'common/controller/language_controller.dart';
import 'modules/auth/presentation/controller/forgot_password_controller.dart';
import 'modules/profile/controller/log_out_controller.dart';
import 'modules/profile/controller/profile_image_selected_controller.dart';
import 'modules/leave/controller/calendar_date_controller.dart';
import 'modules/leave/controller/file_upload_controller.dart';
import 'modules/leave/controller/picked_file_form_storage.dart';
import 'modules/starting/controller/splash_controller.dart';

Future<void> initApp() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  Get.put(LanguageController());
  Get.put(ForgotPasswordController());
  Get.put(ConnectivityController());
  Get.put(FileUploadController());
  Get.put(PickedFileFormStorage());
  Get.put(DateController());
  Get.put(PikedProfileImgController());
  Get.put(PasswordController());
  Get.put(LogoutController());
  Get.put(SelectedTaskController());
  Get.put(UpdateProfileController());
  Get.put(DateTimeController());
  Get.put(SplashController());
}
