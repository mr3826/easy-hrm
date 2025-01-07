import 'package:calendar_view/calendar_view.dart';
import 'package:payrun_mobile/app/global/bindings/global_bindings.dart';
import 'package:payrun_mobile/init_%20app.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/language/internationalization.dart';
import 'package:payrun_mobile/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'common/controller/date_time_controller.dart';
import 'common/controller/language_controller.dart';
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
        initialBinding: GlobalBindings(),
        translations: Internationalization(),
        locale: GetStorage().read("languageCode") != null
            ? Locale(GetStorage().read("languageCode"),
                GetStorage().read("countryCode"))
            : const Locale("en", "US"),
        fallbackLocale: const Locale("en", "US"),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        onInit: () {

          Get.lazyPut(() => LanguageController(), fenix: true);


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

