import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:payrun_mobile/common/controller/user_info_controller.dart';
import 'package:payrun_mobile/modules/dashboard/data/remote/dashboard_remote_data_source.dart';
import 'package:payrun_mobile/modules/leave/data/remote/leave_remote_data_source.dart';
import 'package:payrun_mobile/modules/notification/data/remote/notification_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as get_storage;
import 'package:payrun_mobile/network/network_client.dart';
import 'app/admin_app/employee/data/employee_remote_data_source.dart';
import 'app/admin_app/employee/domain/employee_info.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> initApp() async {
  initializeHive();

  await get_storage.GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  NetworkClient client = Get.put(NetworkClient());

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

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  Get.put(UserInfoController(), permanent: true);

  Get.put(DashboardRemoteDataSource(client), permanent: true);

  Get.put(NotificationRemoteDataSource(client), permanent: true);

  Get.put(LeaveRemoteDataSource(client), permanent: true);

  Get.put(EmployeeRemoteDataSource(client), permanent: true);
}

Future<void> initializeHive() async {
  await Hive.initFlutter();
  registerAdapters();
  await openBoxes();
}

void registerAdapters() {
  Hive.registerAdapter(DataAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(EmploymentStatusAdapter());
  Hive.registerAdapter(UserAdapter());
}

Future<void> openBoxes() async {
  Box<String> settingsBox = await Hive.openBox<String>('settingsBox');
  await checkAppVersion(settingsBox);
  await Hive.openBox<Data>('dataBox');
}

Future<void> checkAppVersion(Box<String> box) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String currentVersion = packageInfo.version;

  String? storedVersion = box.get('appVersion');

  if (storedVersion == null || storedVersion != currentVersion) {
    // Clear the data box if the version has changed
    Box<Data> dataBox = await Hive.openBox<Data>('dataBox');
    await dataBox.clear();
    // Store the new version
    await box.put('appVersion', currentVersion);
  }
}
