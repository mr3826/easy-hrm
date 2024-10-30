import 'dart:developer';

import 'package:payrun_mobile/admin_app/modules/employee/domain/department_info.dart';

import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../domain/employee_info.dart';
import '../domain/employement_status.dart';

class EmployeeRemoteDataSource {
  final NetworkClient networkClient;

  EmployeeRemoteDataSource(this.networkClient);

  Future<EmployeeInfo?> getEmployees(
      {required Map<String, Map<String, Object>> queryVariable}) async {
    print("queryVariable:: $queryVariable");

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

  Future<EmploymentsStatus?> getEmploymentsStatus() async {
    try {
      final response =
          await networkClient.graphRequest(queryString: getEmploymentStatus);
      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getEmploymentsStatus");
        return null;
      }

      return EmploymentsStatus.fromJson(response.data!);
    } catch (e) {
      log('Error in getEmploymentsStatus: $e');
      return null;
    }
  }

  Future<DepartmentsInfo?> getDepartments() async {
    try {
      final response =
          await networkClient.graphRequest(queryString: getDepartment);
      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getDepartments");
        return null;
      }

      return DepartmentsInfo.fromJson(response.data!);
    } catch (e) {
      log('Error in getDepartments: $e');
      return null;
    }
  }
}
