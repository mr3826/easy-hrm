import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('com.example.pushnotifications/token');

  @override
  void initState() {
    super.initState();

    // Set up a method call handler to listen for 'receiveToken' method calls from the native side
    platform.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'receiveToken') {
        String deviceToken = call.arguments;
        print("Received device token: $deviceToken");

        // Handle the device token (e.g., send it to your server or save it for later use)
        _handleDeviceToken(deviceToken);
      }
    });
  }

  void _handleDeviceToken(String token) {
    // Here you can store the token or send it to a backend server for push notification registration
    print("Handling device token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Push Notifications Example'),
        ),
        body: Center(
          child: Text('Waiting for device token...'),
        ),
      ),
    );
  }
}