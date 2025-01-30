import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import '../../../../utils/api_endpoints.dart';

class ProfileApiService {
  final ApiService _apiService;

  ProfileApiService(this._apiService);

  Future<Map<String, dynamic>?>? getProfileInfo(String ordId) async {
    print("orgUserID: $ordId");
    Map<String, dynamic> variable = {"orgUserId": ordId};
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: getUserProfileQuery, variables: variable);
    print("res: ${response.data}");
    return response.data;
  }

  Future<Map<String, dynamic>?>? getUserLogHistory() async {
    QueryResult<Object?> response =
        await _apiService.gqlCall(queryString: userLogHistoryQuery);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getEmploymentInfo(String ordId) async {
    Map<String, dynamic> variable = {"orgUserId": ordId};
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: getEmploymentInfoQuery, variables: variable);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getOrganizationInfo() async {
    QueryResult<Object?> response =
        await _apiService.gqlCall(queryString: organizationInfoQuery);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getPasswordVerification() async {
    QueryResult<Object?> response =
        await _apiService.gqlCall(queryString: organizationInfoQuery);
    return response.data;
  }
}
