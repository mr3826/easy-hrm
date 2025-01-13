import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';

import '../../../../utils/api_endpoints.dart';

class EmployeeApiService {
  final ApiService _apiService;

  EmployeeApiService(this._apiService);

  Future<Map<String, dynamic>?>? getEmployees(
      {Map<String, Map<String, Object>>? queryVariable}) async {
    QueryResult<Object?> response = await _apiService.query(
        queryString: getEmployeeList, variables: queryVariable);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getEmploymentsStatus() async {
    QueryResult<Object?> response = await _apiService.query(
        queryString: getEmploymentStatusInfo);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getDepartments() async {
    QueryResult<Object?> response =
        await _apiService.query(queryString: getDepartmentInfo);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getDesignations() async {
    QueryResult<Object?> response =
        await _apiService.query(queryString: getEmploymentDesignationInfo);
    return response.data;
  }
}
