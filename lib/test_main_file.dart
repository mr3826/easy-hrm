import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init(); // Initialize GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Timer App',
      home: TimerPage(),
    );
  }
}

class TimerController extends SuperController {
  RxInt elapsedSeconds = 0.obs; // Timer seconds
  RxInt finalCount = 0.obs; // Variable to store the count when the timer stops
  RxBool isRunning = false.obs; // Timer state
  Timer? _timer; // Timer instance
  final _storage = GetStorage(); // GetStorage instance

  // Key for storing the start timestamp
  final String savedStartTimeKey = 'start_time';

  @override
  void onInit() {
    super.onInit();
  }

  // Start the timer
  void startTimer() {
    if (isRunning.value) return; // Prevent starting if already running
    isRunning.value = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedSeconds.value++;
    });
  }

  // Stop the timer and clear the saved data
  void stopTimer() {
    if (!isRunning.value) return;
    isRunning.value = false;

    // Store the final elapsed seconds count in `finalCount`
    finalCount.value = elapsedSeconds.value;

    elapsedSeconds.value = 0;
    _timer?.cancel();

    // Clear the saved timer data when the timer stops
    clearStoredTime();
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
      elapsedSeconds.value +=
          timeDiff.inSeconds; // Add the time difference to the timer
      startTimer(); // Restart the timer with the restored time
    }
  }

  // Clear the stored timer data
  void clearStoredTime() {
    _storage.remove(savedStartTimeKey); // Remove the saved start time
  }

  // Format the timer display as HH:mm:ss
  String formatElapsedTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(remainingSeconds)}';
  }

  // Add leading zero for single digit numbers
  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void onPaused() {
    // Save the current time when the app goes to background
    saveElapsedTime();
  }

  @override
  void onResumed() {
    // Restore the time when the app comes back to the foreground
    restoreElapsedTime();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onHidden() {}
}


class TimerPage extends StatelessWidget {
  final TimerController _timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Obx(() {
            return Text(
              'Final Count: ${_timerController.finalCount.value}',
              style: const TextStyle(fontSize: 20),
            );
          }),

          // Start/Timer button
          Obx(() {
            final String timeDisplay = _timerController
                .formatElapsedTime(_timerController.elapsedSeconds.value);
            return ElevatedButton(
              onPressed: () {
                if (_timerController.isRunning.value) {
                  _timerController.stopTimer(); // Stop timer
                } else {
                  _timerController.startTimer(); // Start timer
                }
              },
              child: Text(
                  _timerController.isRunning.value ? timeDisplay : 'Start'),
            );
          }),

          const SizedBox(height: 40),

          // Stop button
          Obx(() {
            return _timerController.isRunning.value
                ? ElevatedButton(
                    onPressed: () {
                      _timerController
                          .stopTimer(); // Stop the timer when clicked
                    },
                    child: const Text('Stop'),
                  )
                : Container(); // Hide Stop button when the timer is not running
          }),
        ],
      ),
    );
  }
}


