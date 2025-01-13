import 'dart:developer';

import 'package:payrun_mobile/app/modules/employee/model/terminate_org_user.dart';
import 'package:payrun_mobile/app/modules/employee/services/employee_api_service.dart';

import '../model/employee_info.dart';
import '../model/user_work_info_dropdown.dart';

abstract class EmployeeDataSource {
  Future<EmployeeInfo?> getEmployees(
      {required Map<String, Map<String, Object>> queryVariable});

  Future<EmploymentStatusList?>? getEmploymentsStatus();

  Future<DepartmentList?> getDepartments();

  Future<DesignationList?> getDesignations();

  Future<String?> terminateAUser(TerminateUserModel terminateUserModel);
}

class EmployeeDataSourceImpl implements EmployeeDataSource {
  final EmployeeApiService _employeeRemoteService;

  EmployeeDataSourceImpl(this._employeeRemoteService);

  @override
  Future<DepartmentList?> getDepartments() async {
    try {
      final response = await _employeeRemoteService.getDepartments();
      if (response != null) {
        return DepartmentList.fromJson(response);
      }
      return null;
    } catch (e) {
      log('Error in getDepartments: $e');
      return null;
    }
  }

  @override
  Future<DesignationList?> getDesignations() async {
    try {
      final response = await _employeeRemoteService.getDesignations();
      if (response != null) {
        return DesignationList.fromJson(response);
      }
      return null;
    } catch (e) {
      log('Error in getDesignations: $e');
      return null;
    }
  }

  @override
  Future<EmploymentStatusList?>? getEmploymentsStatus() async {
    try {
      final response = await _employeeRemoteService.getEmploymentsStatus();
      if (response != null) {
        return EmploymentStatusList.fromJson(response);
      }
      return null;
    } catch (e) {
      log('Error in getEmploymentsStatus: $e');
      return null;
    }
  }

  @override
  Future<EmployeeInfo?> getEmployees(
      {required Map<String, Map<String, Object>> queryVariable}) async {
    try {
      Map<String, dynamic>? response = await _employeeRemoteService
          .getEmployees(queryVariable: queryVariable);
      if (response != null) {
        return EmployeeInfo.fromJson(response);
      }
      return null;
    } catch (e) {
      log('Error in getEmployees: $e');
      return null;
    }
  }

  @override
  Future<String?> terminateAUser(TerminateUserModel terminateUserModel) async {
    try {
      final Map<String, dynamic>? response =
          await _employeeRemoteService.terminateAUser(terminateUserModel);
      if (response != null) {
        String status = response["getOrganizationUsers"]["status"] ?? "";
        return status;
      }
      return null;
    } catch (e) {
      log('Error in terminateAUser: $e');
      return null;
    }
  }
}
