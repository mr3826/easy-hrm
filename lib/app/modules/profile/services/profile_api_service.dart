import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import '../../../../utils/api_endpoints.dart';

class ProfileApiService {
  final ApiService _apiService;

  ProfileApiService(this._apiService);

  Future<Map<String, dynamic>?>? getProfileInfo(String ordId) async {
    Map<String, dynamic> variable = {"orgUserId": ordId};
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: getUserProfileQuery, variables: variable);
    return response.data;
  }

  Future<Map<String, dynamic>?>? getUserLogHistory(String? orgUserId) async {
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: userLogHistoryQuery, variables: {"orgUserId": orgUserId});
    return response.data;
  }


  Future<Map<String, dynamic>?>? getOrgUserDeptHistory(String ordId) async {
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: getOrgUserDeptHistoryQuery, variables: {"orgUserId": ordId});
    print("getOrgUserDeptHistory: $response");
    return response.data;
  }

  Future<Map<String, dynamic>?>? getOrgUserDesignationHistory(String ordId) async {
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: getOrgUserDesignationHistoryQuery,
        variables: {"orgUserId": ordId});
    return response.data;
  }

  Future<Map<String, dynamic>?>? getOrgUserEmploymentStatusHistory(
      String ordId) async {
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: getOrgUserEmploymentHistoryQuery,
        variables: {"orgUserId": ordId});
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

  Future<Map<String, dynamic>?>? updateOrgLeaveAvailability(String leaveStatusId,[int?availableNumOfApplication,int?maximumConsecutiveDays,int ?availableNumberOfDays]) async {

    print('''
    api_servorwe
    leaveStatusId $leaveStatusId
    availableNumOfApplication $availableNumOfApplication
    maximumConsecutiveDays $maximumConsecutiveDays
    availableNumberOfDays $availableNumberOfDays
    
    
    
    ''');

    Map<String, dynamic> variables = {
      "inputData": {
        "leave_status_id": leaveStatusId,
      }
    };

  if (availableNumOfApplication != null && availableNumOfApplication > 0) {
    variables["inputData"]["available_number_of_applications"] = availableNumOfApplication.toString();
  }
  if (maximumConsecutiveDays != null && maximumConsecutiveDays > 0) {
    variables["inputData"]["maximum_consecutive_days"] = maximumConsecutiveDays.toString();
  }
  if (availableNumberOfDays != null && availableNumberOfDays > 0) {
    variables["inputData"]["available_number_of_days"] = availableNumberOfDays.toString();
  }

  QueryResult<Object?> response =
        await _apiService.gqlCall(queryString: updateOrgUserLeaveAvailabilityQuery,variables:variables );
    return response.data;
  }
}





