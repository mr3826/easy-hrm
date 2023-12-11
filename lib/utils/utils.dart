import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/notification/presentation/view/notification.dart';
import 'package:payrun_mobile/modules/profile/view/screen/profile.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/common/domain/error_model.dart';
import '../modules/home/view/screen/home.dart';
import '../modules/timeline/view/screen/timeline.dart';
import 'package:intl/intl.dart';
import '../modules/leave/view/screen/leave_screen.dart';




//global items here
TextEditingController _searchController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
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
TextEditingController  _editAddressController = TextEditingController();
TextEditingController _editPhoneController = TextEditingController();
TextEditingController _editEmergencyPhoneController = TextEditingController();
TextEditingController _editBioController = TextEditingController();
TextEditingController _currentPassController = TextEditingController();
TextEditingController _taskController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();



//global getter
TextEditingController get searchController => _searchController;
TextEditingController get taskSearchController => _taskController;

TextEditingController get emailController => _emailController;

TextEditingController get passwordController => _passwordController;

TextEditingController get userNameController => _userNameController;

TextEditingController get restPasswordController => _restPasswordController;
TextEditingController get descriptionController => _descriptionController;

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
TextEditingController get editEmergencyPhoneController => _editEmergencyPhoneController;
TextEditingController get editBioController => _editBioController;
TextEditingController get currentPassword => _currentPassController;


List<Widget> Function() get buildScreens => _buildScreens;


List get selectedDayIndex => _selectedDay;

List get selectedDayIconIndex => _selectedDayIcon;




List   get notificationTabBarIndex=>_notificationTabBarIndex;
List get selectedBeforeDayAndAfterDay => _selectedBeforeDayAndAfterDay;


String dateMonthFormatFromDatetime(String dateString) {
  // Parse the string to DateTime
  DateTime dateTime = DateTime.parse(dateString);
  // Format the DateTime to "dd, MMM"
  String formattedDate = DateFormat('dd, MMM').format(dateTime);
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

String findWeekdayFormDateString(String dateString) {
  if (dateString.isEmpty) return "";
  DateTime dateTime = DateTime.parse(dateString);

  String weekday = _getWeekday(dateTime.weekday);

  return weekday;
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

List<Widget> _buildScreens() {
  return [
    const TimelineScreen(),
    const LeaveScreen(),
     HomeScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
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
List _selectedBeforeDayAndAfterDay=[
  AppString.text_yesterday.tr,
  AppString.text_today.tr,
  AppString.text_tomorrow.tr,

  ];


List _notificationTabBarIndex=[AppString.text_new.tr,AppString.text_seen.tr];




