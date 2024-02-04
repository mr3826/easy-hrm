import 'dart:async';
import 'package:get/get.dart';
import 'package:payrun_mobile/network/network_client.dart';
import '../../../network/exception_helper.dart';
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
  late Timer _aniTimer;
  int _seconds = 0;
  final isLoading = false.obs;
  RxBool isContainerGrowing = true.obs;
  RxDouble containerSize = 20.0.obs;

  Timer get timer => _timer;
  Timer get animationTimer => _aniTimer;

  void start() {
    isRunning.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
    startAnimation();
  }

  void startAnimation() {
    _aniTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (isContainerGrowing.value) {
        containerSize.value = 230.0;
      } else {
        containerSize.value = 86.0;
      }
      isContainerGrowing.value = !isContainerGrowing.value;
    });
  }

  void stop() {
    isRunning.value = false;
    isTotalCount(false);
    _timer.cancel();
    _aniTimer.cancel();
  }

  void reset() {
    isRunning.value = false;
    _timer.cancel();
    _aniTimer.cancel();
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
    _timeViewAccordingToTime(hours, minutes, seconds);
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
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      TimerResponse timerResponse = TimerResponse.fromJson(response.data!);
      if (timerResponse.checkStartOrStopTimeline != null) {
        DateTime timestamp =
            DateTime.parse(timerResponse.checkStartOrStopTimeline!.startDate!);
        Duration duration = DateTime.now().difference(timestamp);
        _seconds = duration.inSeconds;
        start();
      }
    }
    isLoading(false);
  }

  void _timeViewAccordingToTime(hours, minutes, seconds) {
    if (_twoDigits(hours) == "00" && _twoDigits(minutes) == "00") {
      elapsedTime.value = '${_twoDigits(seconds)}s';
    } else if (_twoDigits(hours) == "00" && _twoDigits(minutes).isNotEmpty) {
      elapsedTime.value = '${_twoDigits(minutes)}m : ${_twoDigits(seconds)}s';
    } else if (_twoDigits(hours).isNotEmpty &&
        _twoDigits(seconds).isNotEmpty &&
        _twoDigits(hours).isNotEmpty) {
      elapsedTime.value = '${_twoDigits(hours)}h : ${_twoDigits(minutes)}m';
    }
  }
}
