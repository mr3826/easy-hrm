import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'app/home/view/screen/main_screen.dart';
import 'app/modules/employee/data/employee_remote_data_source.dart';
import 'app/modules/employee/domain/employee_info.dart';
import 'app/modules/leave_hr/data/apply_and_update_leave_date_source.dart';
import 'app/modules/leave_hr/data/leave_remote_data_source.dart';
import 'modules/dashboard/data/remote/dashboard_remote_data_source.dart';
import 'modules/leave/data/remote/leave_remote_data_source.dart';
import 'modules/notification/data/remote/notification_remote_data_source.dart';
import 'modules/profile/controller/log_out_controller.dart';
import 'network/network_client.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  initNotification();

  initializeHive();

  NetworkClient client = Get.put(NetworkClient());


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));


  Get.put(DashboardRemoteDataSource(client), permanent: true);

  Get.put(NotificationRemoteDataSource(client), permanent: true);

  Get.put(LeaveRemoteDataSource(client), permanent: true);
  Get.put(EmployeeRemoteDataSource(client), permanent: true);

  Get.put(HrLeaveRemoteDataSource(client), permanent: true);
  Get.put(ApplyAndUpdateLeaveDateSource(client), permanent: true);
  Get.lazyPut(()=>LogoutController());

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
  await Hive.openBox('dataBox');
}

Future<void> checkAppVersion(Box<String> box) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String currentVersion = packageInfo.version;

  String? storedVersion = box.get('appVersion');

  if (storedVersion == null || storedVersion != currentVersion) {
    // Clear the data box if the version has changed
    final dataBox = await Hive.openBox('dataBox');
    await dataBox.clear();
    // Store the new version
    await box.put('appVersion', currentVersion);
  }
}

void initNotification() {
  if(Platform.isIOS){
    ForegroundPushNotificationService.initialize();
    PushNotificationServiceForIOS.listenForNotifications();
  }else{
    Pushy.setNotificationIcon(Images.appLogo);
    Pushy.listen();
    Pushy.toggleInAppBanner(true);
    Pushy.setNotificationListener(backgroundNotificationListener);
    Pushy.setNotificationClickListener((data) {});
  }
}

class PushNotificationServiceForIOS {
  static const MethodChannel _channel =
  MethodChannel('com.gainhq.mobile.payrun/foregroundNotification');

  // Method to handle foreground notifications
  static void listenForNotifications() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onForegroundNotification') {
        // Handle foreground notification
        print('Foreground Notification: ${call.arguments}');
      } else if (call.method == 'onNotificationClick') {
        // Handle notification click
        print('Notification Clicked: ${call.arguments}');
        _handleNotificationClick(Map<String, dynamic>.from(call.arguments));
      }
    });
  }

  // Method to clear badge count
  static Future<void> clearBadge() async {
    try {
      await _channel.invokeMethod('clearBadge');
    } on PlatformException catch (e) {
      print("Failed to clear badge: ${e.message}");
    }
  }

  static void _handleNotificationClick(Map<String, dynamic> payload) {
    print("Handling notification click with data: $payload");
    // Example: Navigate to a screen or update UI
    Get.to(() => const MainScreen(routeIndex: 3,));
  }
}

class ForegroundPushNotificationService {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
    InitializationSettings(
      iOS: DarwinInitializationSettings(),
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(
      Map<String, dynamic> notificationData) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      notificationData['title'], // Title of the notification
      notificationData['body'], // Body of the notification
      notificationDetails,
      payload: notificationData.toString(),
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
  String notificationText = data['message'] ?? 'Hello World!';

  // Android: Displays a system notification
  // iOS: Displays an alert dialog
  Pushy.notify(notificationTitle, notificationText, data);

  // Clear iOS app badge number
  Pushy.clearBadge();
}
emailValidExp() {
  const pattern =
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
  return pattern;
}
