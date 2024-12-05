import 'dart:developer';

import '../../../../modules/profile/model/employee_work_history.dart';
import '../../../../modules/profile/model/user_log_history.dart';
import '../../../../modules/profile/model/user_profile.dart';
import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../domain/employee_info.dart';
import '../domain/user_work_info_dropdown.dart';

class EmployeeRemoteDataSource {
  final NetworkClient networkClient;

  EmployeeRemoteDataSource(this.networkClient);

  Future<EmployeeInfo?> getEmployees(
      {required Map<String, Map<String, Object>> queryVariable}) async {
    try {
      final response = await networkClient.graphRequest(
          queryString: getEmployeeList, variables: queryVariable);
      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getEmployees");
        return null;
      }

      return EmployeeInfo.fromJson(response.data!);
    } catch (e) {
      log('Error in getEmployees: $e');
      return null;
    }
  }

  Future<EmploymentStatusList?>? getEmploymentsStatus() async {
    try {
      final response = await networkClient.graphRequest(
          queryString: getEmploymentStatusInfo);

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getEmploymentsStatus");
        return null;
      }
      return EmploymentStatusList.fromJson(response.data!);
    } catch (e) {
      log('Error in getEmploymentsStatus: $e');
      return null;
    }
  }

  Future<DepartmentList?> getDepartments() async {
    try {
      final response =
          await networkClient.graphRequest(queryString: getDepartmentInfo);
      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getDepartments");
        return null;
      }

      return DepartmentList.fromJson(response.data!);
    } catch (e) {
      log('Error in getDepartments: $e');
      return null;
    }
  }

  Future<DesignationList?> getDesignations() async {
    try {
      final response =
          await networkClient.graphRequest(queryString: getEmploymentDesignationInfo);
      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getDesignations");
        return null;
      }

      return DesignationList.fromJson(response.data!);
    } catch (e) {
      log('Error in getDesignations: $e');
      return null;
    }
  }

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
