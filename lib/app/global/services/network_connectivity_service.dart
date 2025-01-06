import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class NetworkDebouncer {
  final Connectivity _connectivity = Connectivity();
  final _debounceDuration = const Duration(seconds: 2);
  late StreamSubscription _subscription;
  Timer? _debounceTimer;

  void listenForConnectivityChanges(Function(List<ConnectivityResult>) onChange) {
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
  bool _hasNetwork = true;

  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged;
    _listenToConnectivityChanges();
  }

  void _listenToConnectivityChanges() {
    _connectivityStream.listen((result) {
      if (result.contains(ConnectivityResult.none) ) {
        // No network connection
        setState(() {
          _hasNetwork = false;
        });
        Get.to(() => (onRetry: _restartApp));
      } else if (!_hasNetwork) {
        // Regained network connection
        setState(() {
          _hasNetwork = true;
        });
        _restartApp();
      }
    });
  }

  void _restartApp() {
    Get.offAll(() => const MyApp());
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
