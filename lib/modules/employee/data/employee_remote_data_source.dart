import 'dart:developer';

import 'package:payrun_mobile/modules/employee/domain/employee_info.dart';

import '../../../network/exception_helper.dart';
import '../../../network/network_client.dart';
import '../../../utils/api_endpoints.dart';

class EmployeeRemoteDataSource {
  final NetworkClient networkClient;

  EmployeeRemoteDataSource(this.networkClient);

  Future<EmployeeInfo?> getEmployees([String? searchQuery]) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: getEmployeeList, variables: {
        "queryData": {
          "role": ["org_employee"],
          "search_text": searchQuery ?? ""
        }
      });
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
}
