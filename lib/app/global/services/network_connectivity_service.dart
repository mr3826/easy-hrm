import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/view/screens/newtwork_error_screen.dart';
import '../../home/view/screen/main_screen.dart';

class NetworkDebouncer {
  final Connectivity _connectivity = Connectivity();
  final _debounceDuration = const Duration(seconds: 2);
  late StreamSubscription _subscription;
  Timer? _debounceTimer;

  void listenForConnectivityChanges(
      Function(List<ConnectivityResult>) onChange) {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(_debounceDuration, () {
        onChange(result); // Trigger callback only after debounce duration
      });
    });
  }

  void cancel() {
    _subscription.cancel();
    _debounceTimer?.cancel();
  }
}

class NetworkListener extends StatefulWidget {
  final Widget child;

  const NetworkListener({Key? key, required this.child}) : super(key: key);

  @override
  _NetworkListenerState createState() => _NetworkListenerState();
}

class _NetworkListenerState extends State<NetworkListener> {
  late Stream<List<ConnectivityResult>> _connectivityStream;

  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged;
    _listenToConnectivityChanges();
  }

  void _listenToConnectivityChanges() {
    _connectivityStream.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        Get.offAll(() => NetworkErrorPage(onRetry: () {}));
      } else {
        _restartApp();
      }
    });
  }

  void _restartApp() {
    Get.to(() => const MainScreen());
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
