import 'dart:developer';

import 'package:intl/intl.dart';

class TimeFormatHelper {
  static String formatSecondsToHours(String secondsStr) {
    // Try to parse the input string as a number
    num? seconds = num.tryParse(secondsStr);

    // If parsing fails, return an error message
    if (seconds == null) return "Invalid input";

    bool isNegative = seconds < 0;
    int totalMinutes = seconds.abs().toInt() ~/ 60;
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    String result = minutes > 0 ? "${hours}h+" : "${hours}h";
    return isNegative ? "-$result" : result;
  }

  static String stringToDateTimeFormat(
      {required String dateString, String? formatPattern}) {
    if (dateString.isEmpty) return "";

    try {
      DateTime dateTime = DateTime.parse(dateString);
      // Format the DateTime to "dd, MMM"
      return formatPattern != null
          ? DateFormat(formatPattern).format(dateTime)
          : DateFormat('dd MMM, yyyy').format(dateTime);
    } catch (e) {
      log('stringToDateTimeFormat: $e');
    }
    return '';
  }
}
