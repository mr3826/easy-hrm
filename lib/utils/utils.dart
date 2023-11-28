import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/domain/error_model.dart';
import '../modules/leave/presentation/view/leave_screen.dart';
import 'app_string.dart';
import 'images.dart';

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

//global getter
TextEditingController get searchController => _searchController;

TextEditingController get emailController => _emailController;

TextEditingController get passwordController => _passwordController;

TextEditingController get userNameController => _userNameController;

TextEditingController get restPasswordController => _restPasswordController;

TextEditingController get addCountyController => _addCountyController;

TextEditingController get phoneController => _phoneController;

TextEditingController get addressController => _addressController;

TextEditingController get aboutMeController => _aboutMeController;

TextEditingController get newPasswordController => _newPasswordController;

TextEditingController get confirmPasswordController =>
    _confirmPasswordController;

TextEditingController get orgNameController => _orgNameController;
TextEditingController get leaveNoteController => _leaveNoteController;



List<Widget> Function()  get buildScreens=>_buildScreens;

List   get selectedDayIndex=>_selectedDay;
List   get selectedDayIconIndex=>_selectedDayIcon;


List<Widget> _buildScreens() {
  return [
    const LeaveScreen(),
    const LeaveScreen(),
    const LeaveScreen(),
    const LeaveScreen(),
    const LeaveScreen(),
  ];
}

void logErrorMessage({required String logName, Response? response}) =>
    log("${response?.statusCode} :  ${response?.request?.url.toString()}",
        name: logName, error: ErrorModel.fromJson(response?.body).message);

void logSuccessMessage(
        {required String logName, Response? response, String? message}) =>
    log("${response?.statusCode} :  ${response?.request?.url.toString()}",
        name: logName, error: message);


List _selectedDay=[
    AppString.text_full_day.tr,
    AppString.text_first_half.tr,
    AppString.text_last_half.tr,



  ];

List _selectedDayIcon=[
  Images.full_day_lav,
  Images.half_day_lav,
  Images.last_half_day_lav
  ];


