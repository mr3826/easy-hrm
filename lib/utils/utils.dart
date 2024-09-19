import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as di;
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/common/domain/error_model.dart';
import 'package:intl/intl.dart';

import '../common/widget/error_message.dart';

//global items here
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _editMailPasswordController = TextEditingController();
TextEditingController _restPasswordController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();
TextEditingController _leaveNoteController = TextEditingController();
TextEditingController _editFirstNameController = TextEditingController();
TextEditingController _editLastNameController = TextEditingController();
TextEditingController _editAddressController = TextEditingController();
TextEditingController _editPhoneController = TextEditingController();
TextEditingController _editEmergencyPhoneController = TextEditingController();
TextEditingController _editBioController = TextEditingController();
TextEditingController _currentPassController = TextEditingController();
TextEditingController _taskController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();


TextEditingController _changeEmailController = TextEditingController();

//global getter

TextEditingController get taskSearchController => _taskController;

TextEditingController get editMailPasswordController => _editMailPasswordController;

TextEditingController get emailController => _emailController;

TextEditingController get changeEmailController => _changeEmailController;

TextEditingController get passwordController => _passwordController;


TextEditingController get restPasswordController => _restPasswordController;

TextEditingController get descriptionController => _descriptionController;


TextEditingController get newPasswordController => _newPasswordController;

TextEditingController get confirmPasswordController =>
    _confirmPasswordController;


TextEditingController get leaveNoteController => _leaveNoteController;

TextEditingController get editFirstNameController => _editFirstNameController;

TextEditingController get editLastNameController => _editLastNameController;


TextEditingController get editAddressController => _editAddressController;

TextEditingController get editPhoneController => _editPhoneController;

TextEditingController get editEmergencyPhoneController =>
    _editEmergencyPhoneController;

TextEditingController get editBioController => _editBioController;

TextEditingController get currentPasswordController => _currentPassController;



List get notificationTabBarIndex => _notificationTabBarIndex;

List get selectedBeforeDayAndAfterDay => _selectedBeforeDayAndAfterDay;

String dateMonthFormatFromDatetime(String dateString) {
  if (dateString.isEmpty) return "";
  // Parse the string to DateTime
  DateTime dateTime = DateTime.parse(dateString);
  // Format the DateTime to "dd, MMM"
  String formattedDate = DateFormat('dd MMM').format(dateTime);
  return formattedDate;
}

String dateMonthYearFormatFromDatetime(String dateString) {
  if (dateString.isEmpty) return "";
  // Parse the string to DateTime
  DateTime dateTime = DateTime.parse(dateString);
  // Format the DateTime to "dd, MMM"
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
  return formattedDate;
}


String dateMonthFormatFromDatetimeForLeaveDetails(String dateString) {
  if (dateString.isEmpty) return "";
  // Parse the string to DateTime
  DateTime dateTime = DateTime.parse(dateString);
  // Format the DateTime to "dd, MMM"
  String formattedDate = DateFormat('dd MMM').format(dateTime);
  String weekDays=findWeekdayFormDateString(dateString);

  return "${abbreviateDayOfWeek(weekDays)}, $formattedDate";
}

String findWeekdayFormDateString(String dateString) {
  if (dateString.isEmpty) return "";
  DateTime dateTime = DateTime.parse(dateString);

  String weekday = _getWeekday(dateTime.weekday);

  return weekday;
}

String amPmFormatTimeFromString(String dateString) {
  if (dateString.isEmpty) return "";

  // Parse the time string into a DateTime object
  DateTime time = DateFormat("HH:mm:ss").parse(dateString);

  // Format the DateTime object into AM/PM format with lowercase "am" and "pm"
  String formattedTime = DateFormat("h:mm a").format(time).toLowerCase();

  return formattedTime;
}


bool isSameDate({required String startDate ,required String endDate}) {
  if (startDate.isEmpty||endDate.isEmpty) return false;

 return startDate.substring(0, 10)==endDate.substring(0, 10);

}


String getConvertSecondsToHours(String secondsStr) {
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

String formatToTwoDecimalPlaces(String? data) {
  if (data == null || data.isEmpty) {
    return '0.00';
  }
  double? number = double.tryParse(data);
  if (number == null) {
    return '0.00';
  }
  String formatted = number.toStringAsFixed(2);
  if (formatted.endsWith('.00')) {
    return formatted.split('.')[0];
  }
  return formatted;
}

String getDayName(String date) {
  if (date.isEmpty) return "";
  DateTime parsedDate = DateTime.parse(date);
  return DateFormat('EE').format(parsedDate);
}

List<Map<String, dynamic>> onboardInfoList = [
  {
    "image": Images.timeLogOn,
    "title": AppString.text_track_your_time.tr,
    "description": AppString.text_with_the_help_etc.tr,
  },
  {
    "image": Images.leaveOn,
    "title": AppString.text_manage_your_leave.tr,
    "description": AppString.text_leave_management_etc.tr,
  },
  {
    "image": Images.employeeOn,
    "title": AppString.text_stitch_org.tr,
    "description": AppString.text_there_is_not_etc.tr,
  },
];

String getTimeDifference(String startTimeString, String endTimeString) {
  if (startTimeString.isEmpty || endTimeString.isEmpty) return "";
  // Parse the time strings into DateTime objects
  DateTime startTime = DateTime.parse("2023-01-01 $startTimeString");
  DateTime endTime = DateTime.parse("2023-01-01 $endTimeString");

  // Calculate the duration between the two times
  Duration duration = endTime.difference(startTime);
  "${duration.inHours} h : ${duration.inMinutes % 60} m";

  if (duration.inMinutes % 60 == 0) return "${duration.inHours}h";
  if (duration.inHours % 60 == 0) return "${duration.inMinutes % 60}m";

  return "${duration.inHours} h : ${duration.inMinutes % 60} m";
}

String workingTimeSinceFormString(String dateString) {
  if (dateString.isEmpty) return "";
  // Parse the input date string into a DateTime object
  DateTime specifiedDate = DateTime.parse(dateString);

  // Get the current date and time
  DateTime currentDate = DateTime.now();

  // Calculate the duration between the specified date and the current date
  Duration duration = currentDate.difference(specifiedDate);

  // Calculate the difference in years and months
  int years = (duration.inDays / 365).floor();
  int months = ((duration.inDays % 365) / 30).floor();
  int days = duration.inDays % 30;

  if (years == 0 && months == 0) {
    return "$days days";
  } else if (years == 0) {
    return "$months months $days days";
  } else {
    return "$years years $months months $days days";
  }
}

String getFirstTwoLetterFromWord(String input) {
  if (input.isEmpty) {
    return "";
  }

  // Split the input into words
  List<String> words = input.split(" ");

  // Extract the first letter of the first word
  String firstLetter = words.isNotEmpty ? words.first[0] : '';

  // Extract the first letter of the last word
  String lastLetter = words.length > 1 ? words.last[0] : '';

  // Concatenate the results
  return '$firstLetter$lastLetter';
}


String formatLeaveDate(String inputDate) {
  // Check for empty input
  if (inputDate.isEmpty) return "";

  // Define the input format
  DateFormat inputFormat = DateFormat('d MMM yyyy');

  // Initialize the output date string
  String outputDate = "";

  try {
    // Parse the input date string
    DateTime dateTime = inputFormat.parse(inputDate);

    // Define the output format
    DateFormat outputFormat = DateFormat('d MMMM - yyyy');

    // Format the parsed date to the desired output format
    outputDate = outputFormat.format(dateTime);
  } catch (e) {
    // Handle parsing error if input date format is incorrect
    print('Error parsing date: $e');
  }

  return outputDate;
}


String abbreviateDayOfWeek(String fullDayName) {
  // Mapping of full day names to their abbreviations
  Map<String, String> dayAbbreviations = {
    'Monday': 'Mon',
    'Tuesday': 'Tue',
    'Wednesday': 'Wed',
    'Thursday': 'Thu',
    'Friday': 'Fri',
    'Saturday': 'Sat',
    'Sunday': 'Sun'
  };

  // Return the abbreviation if it exists in the map, otherwise return the input
  return dayAbbreviations[fullDayName] ?? fullDayName;
}

String getDayAbbreviation(String day) {
  return dayAbbreviations[day] ?? day;
}

Map<String, String> dayAbbreviations = {
  'sunday': 'Sun',
  'monday': 'Mon',
  'tuesday': 'Tue',
  'wednesday': 'Wed',
  'thursday': 'Thu',
  'friday': 'Fri',
  'saturday': 'Sat',
};
List _selectedBeforeDayAndAfterDay = [
  AppString.text_yesterday.tr,
  AppString.text_today.tr,
  AppString.text_tomorrow.tr,
];

List _notificationTabBarIndex = [AppString.text_new.tr, AppString.text_seen.tr];




String convertMiniToHour(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes % 60;

  if (hours > 0 && minutes > 0) {
    return '$hours h $minutes m';
  } else if (hours > 0) {
    return '$hours h';
  } else {
    return '$minutes m';
  }
}

String getLeaveDuration(String? leaveDurationSecond, String? numberOfDays) {
  // Handle null or empty inputs
  if (leaveDurationSecond == null || leaveDurationSecond.isEmpty ||
      numberOfDays == null || numberOfDays.isEmpty) return "0s";

  // Parse the leaveDuration and totalDuration, default to 0 if parsing fails
  int leaveSecond = int.tryParse(leaveDurationSecond) ?? 0;
  double total = double.tryParse(numberOfDays) ?? 0;

  // Handle cases where total duration is less than 1 day
  if (total < 1) {
    // Calculate hours, minutes, and seconds from leaveHours
    int hours = leaveSecond ~/ 3600;
    int minutes = (leaveSecond % 3600) ~/ 60;
    int remainingSeconds = leaveSecond % 60;

    // Construct the result string
    if (hours > 0) {
      return '${hours}h${minutes > 0 ? ' ${minutes}m' : ''}${remainingSeconds > 0 ? ' ${remainingSeconds}s' : ''}';
    } else {
      return '${minutes}m${remainingSeconds > 0 ? ' ${remainingSeconds}s' : ''}';
    }
  }

  // Handle cases where total duration is exactly 1 day
  if (total == 1) {
    return "Full day";
  }
  // Handle cases where total duration is greater than or equal to 1 day
  return "${total.floor()} days";
}


String _getWeekday(int weekday) {
  switch (weekday) {
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    case 7:
      return "Sunday";
    default:
      return "Invalid weekday";
  }
}

void logErrorMessage({required String logName, Response? response}) =>
    log("${response?.statusCode} :  ${response?.request?.url.toString()}",
        name: logName, error: ErrorModel.fromJson(response?.body).message);

void logSuccessMessage(
        {required String logName, Response? response, String? message}) =>
    log("${response?.statusCode} :  ${response?.request?.url.toString()}",
        name: logName, error: message);




handleUnknownError(di.Response response) {
  if (response.data == null) {
    return showErrorMessage(message: "Something went wrong. Please try again.");
  }
}
