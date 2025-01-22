import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/app/modules/employee/model/terminate_org_user.dart';

import '../../../../utils/api_endpoints.dart';

class EmployeeApiService {
  final ApiService _apiService;

  EmployeeApiService(this._apiService);

  Future<Map<String, dynamic>?>? getEmployees(
      {Map<String, Map<String, Object>>? queryVariable}) async {
    queryVariable?.forEach((key, value) => print('key: $key value: $value'));

    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: getEmployeeList, variables: queryVariable);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getEmploymentsStatus() async {
    QueryResult<Object?> response =
        await _apiService.gqlCall(queryString: getEmploymentStatusInfo);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getDepartments() async {
    QueryResult<Object?> response =
        await _apiService.gqlCall(queryString: getDepartmentInfo);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getDesignations() async {
    QueryResult<Object?> response =
        await _apiService.gqlCall(queryString: getEmploymentDesignationInfo);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getUpdateAbleOrgUserInfo(
      {required String orgUserId}) async {
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: updateAbleOrgUserInfo,
        variables: {"orgUserId": orgUserId});
    return response.data;
  }

  Future<Map<String, dynamic>?>? terminateAUser(
      TerminateUserModel terminateUserModel) async {
    QueryResult<Object?> response =
        await _apiService.gqlCall(queryString: terminateAOrgUser, variables: {
      "inputData": {
        "org_user_id": terminateUserModel.orgUserId,
        "status_type": terminateUserModel.terminationTypeEnum,
        "termination_or_resignation_date":
            terminateUserModel.terminationOrResignationDate,
        "termination_or_resignation_reason":
            terminateUserModel.terminationOrResignationReason
      }
    });
    return response.data;
  }

  Future<Map<String, dynamic>?>? updateOrgUserInfo({required Map<String, dynamic> input}) async {
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: updateOrgUserInfoQuery, variables: input);
    return response.data;
  }
}
