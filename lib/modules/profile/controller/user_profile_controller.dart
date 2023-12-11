import 'dart:developer';

import 'package:get/get.dart';
import 'package:payrun_mobile/modules/profile/model/employee_work_history.dart';
import 'package:payrun_mobile/modules/profile/model/user_log_history.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';

import '../model/user_profile.dart';

class UserProfileController extends GetxController with StateMixin {
  @override
  void onInit() {
    getUserProfile();
    getEmploymentInfo();
    getUserLogHistory();
    super.onInit();
  }

  UserDetails? userDetails;
  EmployeeWorkHistory? employeeWorkHistory;
  UserLogHistory? userLogHistory;

  void getUserProfile() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient().getGraphQuery(
        queryString: getUserProfileQuery,
        variables: {"orgUserId": "4ce59a0e-4180-4a51-b654-8dd9e5b3d64c"});

    if (response.hasException) {
      log(response.exception.toString());
    } else {
      userDetails = UserDetails.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  void getEmploymentInfo() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient().getGraphQuery(
        queryString: getEmploymentInfoQuery,
        variables: {"orgUserId": "4ce59a0e-4180-4a51-b654-8dd9e5b3d64c"});

    if (response.hasException) {
      log(response.exception.toString());
    } else {
      employeeWorkHistory = EmployeeWorkHistory.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  void getUserLogHistory() async {
    change(null, status: RxStatus.loading());
    final response =
        await NetworkClient().getGraphQuery(queryString: userLogHistoryQuery);
    if (response.hasException) {
      log(response.exception.toString());
    } else {
      userLogHistory = UserLogHistory.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }
}
