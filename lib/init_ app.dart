import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:payrun_mobile/common/controller/user_info_controller.dart';
import 'package:payrun_mobile/modules/dashboard/data/remote/dashboard_remote_data_source.dart';
import 'package:payrun_mobile/modules/home/view/screen/main_screen.dart';
import 'package:payrun_mobile/modules/leave/data/remote/leave_remote_data_source.dart';
import 'package:payrun_mobile/modules/notification/data/remote/notification_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'firebase_options.dart';

Future<void> initApp() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  initNotification();
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