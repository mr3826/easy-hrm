import 'dart:io';

import 'package:calendar_view/calendar_view.dart';
import 'package:payrun_mobile/init_%20app.dart';
import 'package:payrun_mobile/modules/starting/controller/splash_controller.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/language/internationalization.dart';
import 'package:payrun_mobile/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'common/controller/connectivity_controller.dart';
import 'common/controller/date_time_controller.dart';
import 'common/controller/language_controller.dart';
import 'modules/auth/presentation/controller/signin_controller.dart';
import 'modules/auth/presentation/controller/forgot_password_controller.dart';
import 'modules/auth/presentation/controller/otp_controller.dart';
import 'modules/leave/presentation/controller/calendar_date_controller.dart';
import 'modules/leave/presentation/controller/file_upload_controller.dart';
import 'modules/leave/presentation/controller/picked_file_form_storage.dart';
import 'modules/profile/controller/log_out_controller.dart';
import 'modules/profile/controller/profile_image_selected_controller.dart';
import 'modules/profile/controller/update_profile_controller.dart';
import 'modules/timeline/controller/selected_task_controller.dart';

void main() async {
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        translations: Internationalization(),
        locale: GetStorage().read("languageCode") != null
            ? Locale(GetStorage().read("languageCode"),
                GetStorage().read("countryCode"))
            : const Locale("en", "US"),
        fallbackLocale: const Locale("en", "US"),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        onInit: () {
          if (Platform.isAndroid) {
            Pushy.setNotificationIcon(Images.appLogo);
            Pushy.listen();
            Pushy.toggleInAppBanner(true);
            Pushy.setNotificationListener(backgroundNotificationListener);
            Pushy.setNotificationClickListener((data) {});
          }

          Get.put(SplashController());

          Get.lazyPut(() => SignInController(), fenix: true);

          Get.lazyPut(() => ConnectivityController(), fenix: true);

          Get.lazyPut(() => LanguageController(), fenix: true);

          Get.lazyPut(() => ForgotPasswordController(), fenix: true);

          Get.lazyPut(() => OtpController(), fenix: true);

          Get.put(FileUploadController());

          Get.put(PickedFileFormStorage());

          Get.put(DateController());

          Get.put(PikedProfileImgController());

          Get.lazyPut(() => LogoutController(), fenix: true);

          Get.put(SelectedTaskController());

          Get.put(DateTimeController());

          Get.lazyPut(() => UpdateProfileController(), fenix: true);
        },
      ),
    );
  }
}

@pragma('vm:entry-point')
void backgroundNotificationListener(Map<String, dynamic> data) {
  // Print notification payload data
  print('Received notification: $data');

  // Notification title
  String notificationTitle = 'Payrun';

  // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
  String notificationText = data['message'] ?? 'A new notification has come';

  // Android: Displays a system notification
  // iOS: Displays an alert dialog
  Pushy.notify(notificationTitle, notificationText, data);

  // Clear iOS app badge number
  Pushy.clearBadge();
}
