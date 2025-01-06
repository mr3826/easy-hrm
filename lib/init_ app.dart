import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:payrun_mobile/app/global/controller/user_info_controller.dart';
import 'package:payrun_mobile/modules/dashboard/data/remote/dashboard_remote_data_source.dart';
import 'package:payrun_mobile/modules/leave/data/remote/leave_remote_data_source.dart';
import 'package:payrun_mobile/modules/notification/data/remote/notification_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'firebase_options.dart';

Future<void> initApp() async {

  // Ensure Flutter widgets are properly initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage
  await GetStorage.init();

  NetworkClient client = Get.put(NetworkClient());


  if (!kDebugMode) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  Get.put(UserInfoController(), permanent: true);

  Get.put(DashboardRemoteDataSource(client), permanent: true);
  Get.put(NotificationRemoteDataSource(client), permanent: true);

  Get.put(LeaveRemoteDataSource(client), permanent: true);

}
