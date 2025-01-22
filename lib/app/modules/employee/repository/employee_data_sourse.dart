import 'dart:developer';

import 'package:payrun_mobile/app/modules/employee/model/terminate_org_user.dart';
import 'package:payrun_mobile/app/modules/employee/services/employee_api_service.dart';
import '../model/employee_info.dart';
import '../model/org_user_info.dart';
import '../model/user_work_info_dropdown.dart';

abstract class EmployeeDataSource {
  Future<EmployeeInfo?> getEmployees(
      {required Map<String, Map<String, Object>> queryVariable});

  Future<EmploymentStatusList?>? getEmploymentsStatus();

  Future<DepartmentList?> getDepartments();

  Future<DesignationList?> getDesignations();

  Future<String?> terminateAUser(TerminateUserModel terminateUserModel);

  Future<GetOrganizationUserDetails> getUpdateAbleUserInfo(
      {required String orgUserId});

  Future<bool> updateOrgUserInfo({required Map<String, dynamic> input});
}

class EmployeeDataSourceImpl implements EmployeeDataSource {
  final EmployeeApiService _employeeApiService;

  EmployeeDataSourceImpl(this._employeeApiService);

  @override
  Future<DepartmentList?> getDepartments() async {
    try {
      final response = await _employeeApiService.getDepartments();
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
      final response = await _employeeApiService.getDesignations();
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
      final response = await _employeeApiService.getEmploymentsStatus();
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
      Map<String, dynamic>? response =
          await _employeeApiService.getEmployees(queryVariable: queryVariable);
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
          await _employeeApiService.terminateAUser(terminateUserModel);
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

  @override
  Future<GetOrganizationUserDetails> getUpdateAbleUserInfo(
      {required String orgUserId}) async {
    try {
      Map<String, dynamic>? response = await _employeeApiService
          .getUpdateAbleOrgUserInfo(orgUserId: orgUserId);

      if (response != null && response["getOrganizationUserDetails"] != null) {
        return GetOrganizationUserDetails.fromJson(
            response["getOrganizationUserDetails"]);
      }
    } catch (e) {
      log('Error in getUpdateAbleUserInfo: $e');
    }
    return GetOrganizationUserDetails();
  }

  @override
  Future<bool> updateOrgUserInfo({required Map<String, dynamic> input}) async {
    try {
      Map<String, dynamic>? response =
          await _employeeApiService.updateOrgUserInfo(input: input);

      if (response != null &&
          response["updateOrganizationUser"]['id'] != null) {
        return true;
      }
    } catch (e) {
      log('Error in updateOrgUserInfo: $e');
    }
    return false;
  }
}
