import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/network/network_client.dart';
import '../../../modules/timeline/model/timer_status_response.dart';
import '../../../network/exception_helper.dart';
import '../../../utils/api_endpoints.dart';

class TimeCounterController extends SuperController {
  @override
  void onInit() {
    timerStatus();
    super.onInit();
  }

  var elapsedTime = 'Start'.obs;
  var starTimeDashboard = '00:00:00'.obs;
  var totalTime = ''.obs;
  var isRunning = false.obs;
  var isRunningHorizontalLine = false.obs;
  var isTotalCount = true.obs;
  Timer _timer = Timer(Duration.zero, () {});
  Timer _aniTimer = Timer(Duration.zero, () {});
  int _seconds = 0;
  final isLoading = false.obs;
  RxBool isContainerGrowing = true.obs;
  RxDouble containerSize = 20.0.obs;

  // Key for storing the start timestamp
  final String savedStartTimeKey = 'start_time';

  final _storage = GetStorage(); //

  Timer get timer => _timer;

  Timer get animationTimer => _aniTimer;

  void start() {
    if (_timer.isActive) return;
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
    _clearStoredTime();
    _aniTimer.cancel();
  }

  void reset() {
    isRunning.value = false;
    if (_timer.isActive) {
      _timer.cancel();
      _clearStoredTime();
    }
    if (_aniTimer.isActive) {
      _aniTimer.cancel();
    }
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
        await NetworkClient().graphRequest(queryString: timerStatusQuery);

    if (response.hasException) {
      ExceptionHelper.errorHandler(
          exception: response.exception!, methodName: "timerStatus");
    } else {
      TimerResponse timerResponse = TimerResponse.fromJson(response.data!);
      if (timerResponse.checkStartOrStopTimeline != null) {
        DateTime timestamp =
            DateTime.parse(timerResponse.checkStartOrStopTimeline!.startDate!);
        Duration duration = DateTime.now().difference(timestamp);
        _seconds = duration.inSeconds;
        start();
        Get.find<TimeCounterController>().isRunningHorizontalLine(true);
      } else {
        reset();
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

  // Save the current time when the app goes to background
  void saveElapsedTime() {
    if (isRunning.value) {
      _storage.write(savedStartTimeKey, DateTime.now().toIso8601String());
    }
  }

  // Restore the saved time when the app resumes
  void restoreElapsedTime() {
    String? savedTimeString = _storage.read(savedStartTimeKey);
    if (savedTimeString != null) {
      DateTime savedTime = DateTime.parse(savedTimeString);
      Duration timeDiff = DateTime.now().difference(savedTime);

      // Add the time difference to the timer
      _seconds += timeDiff.inSeconds;
    }
  }

  // Clear the stored timer data
  void _clearStoredTime() {
    _storage.remove(savedStartTimeKey); // Remove the saved start time
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    print("onPaused called");
    // Save the current time when the app goes to background
    saveElapsedTime();
  }

  @override
  void onResumed() {
    print("onResumed called");
    // Restore the time when the app comes back to the foreground
    restoreElapsedTime();
  }
}
