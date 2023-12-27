import 'dart:async';
import 'package:get/get.dart';

class TimeCounterController extends GetxController {

  var elapsedTime = 'Start'.obs;
  var starTimeDashboard = '00:00:00'.obs;

  var totalTime = ''.obs;
  var isRunning = false.obs;
  var isTotalCount = true.obs;
  var isClicked = false.obs;
  late Timer _timer;
  int _seconds = 0;

  void start() {
    isRunning.value = true;
    isClicked(true);
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void stop() {
    isRunning.value = false;
    isTotalCount(false);
    isClicked(false);
    print("total time => $totalTime");
    _timer.cancel();
  }

  void reset() {
    isRunning.value = false;
    print(" reset value ==> $elapsedTime");
    elapsedTime.value="Start";
    _seconds = 0;

    _updateTimer(Timer(Duration.zero, () {
      elapsedTime.value="Start";

    }));
  }

  void _updateTimer(Timer timer) {
    _seconds++;
    final hours = _seconds ~/ 3600;
    final minutes = (_seconds % 3600) ~/ 60;
    final seconds = _seconds % 60;
    starTimeDashboard.value =
    '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
    elapsedTime.value = '${_twoDigits(hours)}:${_twoDigits(minutes)}';
    totalTime = elapsedTime;

  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
