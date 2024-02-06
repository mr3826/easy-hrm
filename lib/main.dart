import 'package:calendar_view/calendar_view.dart';
import 'package:payrun_mobile/init_%20app.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
        locale: GetStorage().read("languageCode") != null
            ? Locale(GetStorage().read("languageCode"),
                GetStorage().read("countryCode"))
            : const Locale("en", "US"),
        fallbackLocale: const Locale("en", "US"),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}

