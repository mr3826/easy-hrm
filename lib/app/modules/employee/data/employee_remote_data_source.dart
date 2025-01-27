import 'dart:developer';

import '../../profile/models/employee_work_history.dart';
import '../../profile/models/user_log_history.dart';
import '../../profile/models/user_profile.dart';
import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';



class EmployeeRemoteDataSource {
  final NetworkClient networkClient;

  EmployeeRemoteDataSource(this.networkClient);

  Future<UserDetails?> getEmployeeProfile({required String orgUserId}) async {
    try {
      final response = await networkClient.graphRequest(
          queryString: getUserProfileQuery,
          variables: {"orgUserId": orgUserId});
      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getEmployeeProfile");
        return null;
      }
      return UserDetails.fromJson(response.data!);
    } catch (e) {
      log('Error in getEmployeeProfile: $e');
      return null;
    }
  }

  Future<EmployeeWorkHistory?> getEmployeesEmploymentInfo(
      {required String orgUserId}) async {
    try {
      final response = await networkClient.graphRequest(
          queryString: getEmploymentInfoQuery,
          variables: {"orgUserId": orgUserId});
      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!,
            methodName: "getEmployeesEmploymentInfo");
        return null;
      }
      return EmployeeWorkHistory.fromJson(response.data!);
    } catch (e) {
      log('Error in getEmployeesEmploymentInfo: $e');
      return null;
    }
  }

  Future<UserLogHistory?> getUserLogHistory({required String orgUserId}) async {
    try {
      final response = await networkClient.graphRequest(
          queryString: userLogHistoryQuery,
          variables: {"orgUserId": orgUserId});
      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getUserLogHistory");
        return null;
      }
      return UserLogHistory.fromJson(response.data!);
    } catch (e) {
      log('Error in getUserLogHistory: $e');
      return null;
    }
  }











}
