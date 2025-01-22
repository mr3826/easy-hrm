import 'package:graphql/src/core/query_result.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';

class DashBoardApiService {
  final ApiService _apiService;
  DashBoardApiService(this._apiService);

  Future<Map<String, dynamic>?> getEmployeeOverView() async {
    QueryResult<Object?> response =
        await _apiService.gqlCall(query: getEmployeeOverviewQuery);
    return response.data; ///todo [one line]
  }




  Future<Map<String, dynamic>?> getJobOpening() async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "status": ["published"],
      }
    };

    QueryResult<Object?> response =
        await _apiService.gqlCall(query: getJobOpeningQuery, variables:variables);
    return response.data;
  }


  Future<Map<String, dynamic>?> getLeaveAndTimeLogSummary() async {
    QueryResult<Object?> response =
        await _apiService.gqlCall(query: getLeaveAndTimeLogQuery);
    return response.data;
  }

  Future<Map<String, dynamic>?> getJobApplicationBoard(String entityId) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "entity_id": entityId,
      }
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: getJobApplicationBoardQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> updateJobApplication(
      String hiringStageId, String jobApplicationId) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "hiring_stage_id": hiringStageId,
        "job_application_id": jobApplicationId,
      }
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: updateJobApplicationQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> updateJob(String entityId) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {"entity_id": entityId},
      "updatingData": {"status": "unpublished"}
    };
    QueryResult<Object?> response =
        await _apiService.gqlCall(query: updateJobQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> removeJobApplication(
      String jobId, String candidateId) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "job_id": jobId,
        "candidate_id": candidateId,
      }
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: removeJobApplicationQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> createCandidateReview(
      String jobId, String jobApplicationId, int rate) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "job_id": jobId,
        "job_application_id": jobApplicationId,
        "rate": rate
      }
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: createCandidateReviewQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> createCandidateNoteReview(
      String jobId, String jobApplicationId, String note) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "job_id": jobId,
        "job_application_id": jobApplicationId,
        "note": note
      }
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: createTeamNoteQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> deleteCandidateNoteReview(
      String entityId) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "entity_id": entityId,
      }
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: deleteTeamNoteQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> updateCandidateNoteReview(
      String noteId, String note) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {"team_note_id": noteId, "note": note}
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: updateTeamNoteQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> getCandidateActivitiesLogs(
      String jobApplicationId) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "job_application_id": jobApplicationId,
        "request_from": "job_application"
      }
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: getCandidateLogsQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> getJobApplicationPreview(
      String jobId, String candidateId) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {"candidate_id": candidateId, "job_id": jobId}
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: getJobApplicationPreviewQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> getCandidateDetails(
      String jobApplicationId) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "job_application_id": jobApplicationId,
      }
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: getCandidateDetailsQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> getCandidateReview(
      String jobApplicationId) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "job_application_id": jobApplicationId,
      }
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: getTeamNotesQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> getFileSignUrl(String fileKey) async {
    Map<String, dynamic> variables = {"fileKey": fileKey, "isDownload": false};
    QueryResult<Object?> response = await _apiService.gqlCall(
        query: getFileSignUrlQuery, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?> getCandidateList(String searchKey,List<String>  jobIds,List<String> stageIds,List<int>  ratings) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "search_key": searchKey,
        "job_ids": jobIds,
        "stage_ids":stageIds,
        "ratings": ratings
      },
    };
    QueryResult<Object?> response =
    await _apiService.gqlCall(query: getCandidateListQuery, variables:variables);
    return response.data;
  }

 Future<Map<String, dynamic>?> getHiringStages() async {

    QueryResult<Object?> response =
    await _apiService.gqlCall(query: getHiringStagesQuery);
    return response.data;
  }


Future<Map<String, dynamic>?> getJobsDropdown() async {
    QueryResult<Object?> response =
    await _apiService.gqlCall(query: getJobsDropdownQuery);
    return response.data;
  }


Future<Map<String, dynamic>?> updateCandidate(String candidateId,String jobId,String email,String firstName,String lastName) async {
  Map<String, Map<String, dynamic>> variables = {
    "inputData": {
      "candidate_id": candidateId,
      "job_id": jobId,
      "email":email,
      "first_name":firstName,
      "last_name":lastName,
    },
  };
    QueryResult<Object?> response =
    await _apiService.gqlCall(query: updateCandidateQuery,variables: variables);
    return response.data;
  }

Future<Map<String, dynamic>?> removeCandidate(String candidateId,String jobId) async {
  Map<String, Map<String, dynamic>> variables = {
    "inputData": {
      "candidate_id": candidateId,
      "job_id":jobId
    },
  };
    QueryResult<Object?> response =
    await _apiService.gqlCall(query: removeCandidateQuery,variables: variables);
    return response.data;
  }






}
