import 'dart:async';
import 'package:get/get.dart';
import 'package:payrun_mobile/network/network_client.dart';

import '../../../utils/api_endpoints.dart';
import '../model/timer_status_response.dart';

class TimeCounterController extends GetxController {
  @override
  void onInit() {
    timerStatus();
    super.onInit();
  }

  var elapsedTime = 'Start'.obs;
  var starTimeDashboard = '00:00:00'.obs;
  var totalTime = ''.obs;
  var isRunning = false.obs;
  var isTotalCount = true.obs;
  late Timer _timer;
  int _seconds = 0;
  final isLoading = false.obs;

  Timer get timer => _timer;

  void start() {
    isRunning.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void stop() {
    isRunning.value = false;
    isTotalCount(false);
    print("total time => $totalTime");
    _timer.cancel();
  }

  void reset() {
    isRunning.value = false;
    _seconds = 0;
    _updateTimer(Timer(Duration.zero, () {
      elapsedTime.value = 'Start';
    }));
  }

  void _updateTimer(Timer timer) {
    _seconds++;
    int hours = _seconds ~/ 3600;
    final minutes = (_seconds % 3600) ~/ 60;
    final seconds = _seconds % 60;

    elapsedTime.value = '${_twoDigits(hours)}h : ${_twoDigits(minutes)}m';
    starTimeDashboard.value =
        '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
    totalTime = elapsedTime;
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  timerStatus() async {
    isLoading(true);
    final response =
        await NetworkClient().getGraphQuery(queryString: timerStatusQuery);

    if (response.hasException) {
      print(response.exception.toString());
    } else {
      TimerResponse timerResponse = TimerResponse.fromJson(response.data!);
      if (timerResponse.checkStartOrStopTimeline?.startDate != null) {
        DateTime timestamp =
            DateTime.parse(timerResponse.checkStartOrStopTimeline!.startDate!);
        Duration duration = DateTime.now().difference(timestamp);
        _seconds = duration.inSeconds;
        start();
      }
    }
    isLoading(false);
  }
}
