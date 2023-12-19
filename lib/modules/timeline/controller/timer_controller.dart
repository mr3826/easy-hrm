import 'dart:async';
import 'package:get/get.dart';

class TimeCounterController extends GetxController {
  var elapsedTime = '09:08'.obs;
  var isRunning = false.obs;
  late Timer _timer;
  int _seconds = 0;

  void start() {
    isRunning.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void stop() {
    isRunning.value = false;
    _timer.cancel();
  }

  void reset() {
    isRunning.value = false;
    _seconds = 0;
    _updateTimer(Timer(Duration.zero, () {}));
  }

  void _updateTimer(Timer timer) {
    _seconds++;
    final hours = _seconds ~/ 3600;
    final minutes = (_seconds % 3600) ~/ 60;
    final seconds = _seconds % 60;
    elapsedTime.value =
        '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
