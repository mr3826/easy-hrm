import 'dart:developer';

class TimeFormatHelper {
  static String formatSecondsToHours(String secondsStr) {
    // Try to parse the input string as a number
    num? seconds = num.tryParse(secondsStr);

    // If parsing fails, return an error message
    if (seconds == null) return "";

    bool isNegative = seconds < 0;
    int totalMinutes = seconds.abs().toInt() ~/ 60;
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    String result = minutes > 0 ? "${hours}h+" : "${hours}h";
    return isNegative ? "-$result" : result;
  }
}
