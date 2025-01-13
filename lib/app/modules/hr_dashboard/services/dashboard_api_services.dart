import 'package:graphql/src/core/query_result.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';

class DashBoardApiService {
 final ApiService _apiService;
  DashBoardApiService(this._apiService);

  Future<Map<String, dynamic>?> getEmployeeOverView() async {
    QueryResult<Object?> response= await _apiService.gqlCall(query: getEmployeeOverviewQuery);
    return response.data;
  }

  Future<Map<String, dynamic>?>  getJobOpening() async {
    QueryResult<Object?> response= await _apiService.gqlCall(query:getJobOpeningQuery);
    return response.data;
  }


  Future<Map<String, dynamic>?>  getLeaveAndTimeLogSummary() async {
    QueryResult<Object?> response= await _apiService.gqlCall(query:getLeaveAndTimeLogQuery);
    return response.data;
  }

  Future<Map<String, dynamic>?>  getJobApplicationBoard(String entityId) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "entity_id": entityId,
      }
    };
    QueryResult<Object?> response= await _apiService.gqlCall(query:getJobApplicationBoardQuery,variables: variables);
    return response.data;
  }


}
