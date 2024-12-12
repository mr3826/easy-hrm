import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Register for push notifications
    registerForPushNotifications(application: application)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func registerForPushNotifications(application: UIApplication) {
    UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      guard granted else { return }
      DispatchQueue.main.async {
        application.registerForRemoteNotifications()
      }
    }
  }

  // Called when APNs assigns the device a unique token
  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenParts = deviceToken.map { String(format: "%02.2hhx", $0) }
    let token = tokenParts.joined()

    // Send the token to Flutter via method channel
    if let controller = self.window?.rootViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(name: "com.gainhq.payrun/deviceToken", binaryMessenger: controller.binaryMessenger)
      // Invoke the method with the device token as an argument
      channel.invokeMethod("deviceToken", arguments: token)
    }
  }

  // Handle failure to register for remote notifications
  override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register for remote notifications: \(error.localizedDescription)")
  }
}
