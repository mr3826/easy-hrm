import UIKit
import Flutter
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate{

    private let notificationChannel = "com.gainhq.mobile.payrun/foregroundNotification"

    // MARK: - Application Launch
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        registerForPushNotifications(application: application)
        setupMethodChannel()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // MARK: - Push Notification Registration
    private func registerForPushNotifications(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
    }

    // MARK: - Handling Push Notification Registration (Device Token)
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { String(format: "%02.2hhx", $0) }
        let token = tokenParts.joined()

        if let controller = self.window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(name: "com.gainhq.mobile.payrun/deviceToken", binaryMessenger: controller.binaryMessenger)
            channel.invokeMethod("deviceToken", arguments: token)
        }
    }

    // MARK: - Push Notification Failure Registration
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }

    // MARK: - Handling Foreground Push Notifications
    // This method will be called when the app is in the foreground and a notification is received
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Always show the notification in the foreground
        completionHandler([.alert, .badge, .sound])

        // Send the notification data to Flutter using MethodChannel
        if let userInfo = notification.request.content.userInfo as? [String: Any] {
            if let controller = self.window?.rootViewController as? FlutterViewController {
                let channel = FlutterMethodChannel(name: notificationChannel, binaryMessenger: controller.binaryMessenger)
                channel.invokeMethod("onForegroundNotification", arguments: userInfo)
            }
        }
    }


     // MARK: - Handling Notification Clicks
        // This method will be called when the user taps on a notification
        override func userNotificationCenter(
            _ center: UNUserNotificationCenter,
            didReceive response: UNNotificationResponse,
            withCompletionHandler completionHandler: @escaping () -> Void
        ) {
            // Get the notification payload
            let userInfo = response.notification.request.content.userInfo

            // Send the notification data to Flutter using MethodChannel
            if let controller = self.window?.rootViewController as? FlutterViewController {
                let channel = FlutterMethodChannel(name: notificationChannel, binaryMessenger: controller.binaryMessenger)
                channel.invokeMethod("onNotificationClick", arguments: userInfo)
            }

            // Call the completion handler
            completionHandler()
        }

    // MARK: - Flutter Method Channel Setup
    private func setupMethodChannel() {
        if let controller = self.window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(name: notificationChannel, binaryMessenger: controller.binaryMessenger)
            channel.setMethodCallHandler { (call, result) in
                if call.method == "clearBadge" {
                    UIApplication.shared.applicationIconBadgeNumber = 0
                    result(nil)
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
        }
    }
}
