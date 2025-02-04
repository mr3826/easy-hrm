

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


static  String formatSecondsToHoursSolid(String secondsStr) {
    if (secondsStr.isEmpty || secondsStr == "null") {
      return "0m";
    }
    double seconds;
    try {
      double cleanSecond = double.parse(secondsStr.replaceAll("-", ""));
      // Ensure only two decimal places
      String formattedValue = cleanSecond.toStringAsFixed(2);
      seconds = double.parse(formattedValue);
    } catch (e) {
      return "0m"; // Return "0m" if parsing fails
    }

    int totalMinutes = (seconds / 60).floor();
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    if (hours == 0) return "${secondsStr.startsWith("-") ? "-" : ""}${minutes}m";
    if (minutes == 0) return "${secondsStr.startsWith("-") ? "-" : ""}${hours}h";

    return "${secondsStr.startsWith("-") ? "-" : ""}$hours.${minutes}h";
  }


 static String timeDifference(String? startTimeString, String? endTimeString) {
    if (startTimeString == null || endTimeString == null) return "";

    try {
      DateTime startTime = DateTime.parse(startTimeString);
      DateTime endTime = (endTimeString.isEmpty || endTimeString == "null")
          ? DateTime.now()
          : DateTime.parse(endTimeString);

      Duration duration = endTime.difference(startTime);

      if (duration.inMinutes % 60 == 0) return "${duration.inHours}h";
      if (duration.inHours % 60 == 0) return "${duration.inMinutes % 60}m";

      return "${duration.inHours} h : ${duration.inMinutes % 60} m";
    } catch (e) {
      return "";
    }
  }

}
