import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/common/domain/error_model.dart';
import 'package:intl/intl.dart';

//global items here
TextEditingController _searchController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _editMailPasswordController = TextEditingController();
TextEditingController _userNameController = TextEditingController();
TextEditingController _restPasswordController = TextEditingController();
TextEditingController _addCountyController = TextEditingController();
TextEditingController _phoneController = TextEditingController();
TextEditingController _addressController = TextEditingController();
TextEditingController _aboutMeController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();
TextEditingController _orgNameController = TextEditingController();
TextEditingController _leaveNoteController = TextEditingController();

TextEditingController _editFirstNameController = TextEditingController();
TextEditingController _editLastNameController = TextEditingController();
TextEditingController _editEmailController = TextEditingController();
TextEditingController _editAddressController = TextEditingController();
TextEditingController _editPhoneController = TextEditingController();
TextEditingController _editEmergencyPhoneController = TextEditingController();
TextEditingController _editBioController = TextEditingController();
TextEditingController _currentPassController = TextEditingController();
TextEditingController _taskController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
TextEditingController _timelineLogDetailsDrcController =
    TextEditingController();

TextEditingController _changeEmailController = TextEditingController();

//global getter
TextEditingController get searchController => _searchController;

TextEditingController get taskSearchController => _taskController;

TextEditingController get editMailPasswordController =>
    _editMailPasswordController;

TextEditingController get emailController => _emailController;

TextEditingController get changeEmailController => _changeEmailController;

TextEditingController get passwordController => _passwordController;

TextEditingController get userNameController => _userNameController;

TextEditingController get restPasswordController => _restPasswordController;

TextEditingController get descriptionController => _descriptionController;

TextEditingController get timelineLogDetailsDrcController =>
    _timelineLogDetailsDrcController;

TextEditingController get addCountyController => _addCountyController;

TextEditingController get phoneController => _phoneController;

TextEditingController get addressController => _addressController;

TextEditingController get aboutMeController => _aboutMeController;

TextEditingController get newPasswordController => _newPasswordController;

TextEditingController get confirmPasswordController =>
    _confirmPasswordController;

TextEditingController get orgNameController => _orgNameController;

TextEditingController get leaveNoteController => _leaveNoteController;

TextEditingController get editFirstNameController => _editFirstNameController;

TextEditingController get editLastNameController => _editLastNameController;

TextEditingController get editEmailController => _editEmailController;

TextEditingController get editAddressController => _editAddressController;

TextEditingController get editPhoneController => _editPhoneController;

TextEditingController get editEmergencyPhoneController =>
    _editEmergencyPhoneController;

TextEditingController get editBioController => _editBioController;

TextEditingController get currentPasswordController => _currentPassController;

List get selectedDayIndex => _selectedDay;

List get selectedDayIconIndex => _selectedDayIcon;

List get notificationTabBarIndex => _notificationTabBarIndex;

List get selectedBeforeDayAndAfterDay => _selectedBeforeDayAndAfterDay;

String dateMonthFormatFromDatetime(String dateString) {
  if (dateString.isEmpty) return "";
  // Parse the string to DateTime
  DateTime dateTime = DateTime.parse(dateString);
  // Format the DateTime to "dd, MMM"
  String formattedDate = DateFormat('dd, MMM').format(dateTime);
  return formattedDate;
}

String dateMonthYearFormatFromDatetime(String dateString) {
  if (dateString.isEmpty) return "";
  // Parse the string to DateTime
  print(dateString);
  DateTime dateTime = DateTime.parse(dateString);
  // Format the DateTime to "dd, MMM"
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
  return formattedDate;
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

  // Format the DateTime object into AM/PM format
  String formattedTime = DateFormat("h:mm a").format(time);

  return formattedTime;
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
    "image": Images.time_log_on,
    "title": AppString.text_track_your_time.tr,
    "description": AppString.text_with_the_help_etc.tr,
  },
  {
    "image": Images.leave_on,
    "title": AppString.text_manage_your_leave.tr,
    "description": AppString.text_leave_management_etc.tr,
  },
  {
    "image": Images.employee_on,
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

List _selectedDay = [
  AppString.text_full_day.tr,
  AppString.text_first_half.tr,
  AppString.text_last_half.tr,
];

List _selectedDayIcon = [
  Images.full_day_lav,
  Images.half_day_lav,
  Images.last_half_day_lav
];

List _selectedBeforeDayAndAfterDay = [
  AppString.text_yesterday.tr,
  AppString.text_today.tr,
  AppString.text_tomorrow.tr,
];

List _notificationTabBarIndex = [AppString.text_new.tr, AppString.text_seen.tr];
