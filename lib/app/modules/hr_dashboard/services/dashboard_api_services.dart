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


 Future<Map<String, dynamic>?>  updateJobApplication(String hiringStageId,String jobApplicationId) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "hiring_stage_id": hiringStageId,
        "job_application_id": jobApplicationId,
      }
    };
    QueryResult<Object?> response= await _apiService.gqlCall(query:updateJobApplicationQuery,variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?>  removeJobApplication(String jobId,String candidateId) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "job_id": jobId,
        "candidate_id": candidateId,
      }
    };
    QueryResult<Object?> response= await _apiService.gqlCall(query:removeJobApplicationQuery,variables: variables);
    return response.data;
  }


  Future<Map<String, dynamic>?>  getCandidate(String jobApplicationId) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "job_application_id": "ed0e25c3-9c30-4d5f-88de-786dd53b3363",
        "request_from": "job_application"
      }
    };

    QueryResult<Object?> response= await _apiService.gqlCall(query:getCandidateLogsQuery,variables: variables);
    return response.data;
  }


}
