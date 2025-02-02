import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/app/modules/employee/model/terminate_org_user.dart';
import '../../../../utils/api_endpoints.dart';

class TimelineApiService {
  final ApiService _apiService;
  TimelineApiService(this._apiService);

  Future<QueryResult<Object?>> getTimeSheets(String startDate, String endDate, String orgId) async {
    Map<String, dynamic> variable = {
      "queryData": {
        "start_date": startDate,
        "end_date": endDate,
        "org_user_ids": [orgId]
      },
      "optionData": {
        "order": [
          ["sh.name", "asc"]
        ]
      }
    };
    return await _apiService.gqlCall(
        queryString: getTimeSheetByDateQuery, variables: variable);
  }

  Future<QueryResult<Object?>> getTimelineSummary( ///get_timeline summary by month
      String startDate, String endDate,
      {String? orgUserId}) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "start_date": startDate,
        "end_date": endDate,
      }
    };
    if (orgUserId != null) {
      variables["queryData"]?["org_user_ids"] = orgUserId;
    }
    return await _apiService.gqlCall(
        queryString: getTimelineSummaryByDateQuery, variables: variables);
  }

  Future<QueryResult<Object?>> getTimelineCalender(
      String startDate, String endDate,
      {String? orgUserId}) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {"start_date": startDate, "end_date": endDate},
      "optionData": {
        "order": [
          ["user"]
        ]
      }
    };
    if (orgUserId != null) {
      variables["queryData"]?["org_user_ids"] = orgUserId;
    }
    return await _apiService.gqlCall(
        queryString: getCalendarTimelineQuery, variables: variables);
  }

  Future<Map<String, dynamic>?>? startOrEndTimer(String timerType) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {"timer_type": timerType}
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: startOrEndTimerQueryData, variables: variables);
    return response.data;
  }




  Future<QueryResult<Object?>> getProjectList(String searchText) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "searchText": searchText,
      }
    };
    return await _apiService.gqlCall(
        queryString: getProjectDropdownQuery, variables: variables);
  }






  Future<QueryResult<Object?>> getTimeEntryDetails(String timelineId,String orgId) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "timeline_id": timelineId,
        "org_user_id": orgId
      }
    };
    print('''
    timeline_id $timelineId
    org_user_id $orgId
    
    ''');
    return await _apiService.gqlCall(
        queryString: getTimeEntryDetailsQuery, variables: variables);
  }





    Future<QueryResult<Object?>> getTimelogDetailsByMonth(String startDate,String endDate,[String ?orgId]) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "start_date": startDate,
        "end_date": endDate,
        "leave_statuses": ["approved", "pending"],
      },
      "optionData": {
        "offset": 0,
        "order": [
          ["ta.entry_day", "desc"]
        ]
      }
    };
    if (orgId != null && orgId.isNotEmpty) {
      variables["queryData"]?["org_user_id"] = orgId;
    }
    return await _apiService.gqlCall(queryString: getTimelogDetailsByMonthQuery, variables: variables);
  }


  Future<QueryResult<Object?>> updateTimeLogEntryById(String status,String timelineId) async {
    Map<String, Map<String, dynamic>> variables = {
        "inputData": {
          "status": status,
          "timeline_id": timelineId
        }
    };
    return await _apiService.gqlCall(queryString: updateTimeLogEntry, variables: variables);
  }



    Future<QueryResult<Object?>> getTimeLogEntries(String startDate,String endDate,[String ?orgId]) async {

    print('''
    startDate $startDate
    endDate $endDate
    
    ''');
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "start_date": startDate,
        "end_date": endDate
      },
    };
    if (orgId != null && orgId.isNotEmpty) {
      variables["queryData"]?["org_user_id"] = orgId;
    }
    return await _apiService.gqlCall(queryString: getTimeLogEntriesQuery, variables: variables);
  }





  Future<Map<String, dynamic>?>? saveTimelineEntry(String des, String startDate,
      String endDate, String projectId, String timelineId,
      [String? taskId, String? status]) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "description": des,
        "start_date": startDate,
        "end_date": endDate,
        "status": "pending",
        "project_id": projectId,
        "timeline_id": timelineId
      }
    };

    if (taskId != null && taskId.isNotEmpty) {
      variables["inputData"]?["task_id"] = taskId;
    }

    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: saveTimerQueryData, variables: variables);
    return response.data;
  }




  Future<Map<String, dynamic>?>? removeTimelineEntry(String timeLogId,[String ?orgId]) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "timeline_id": timeLogId,
      }
    };
    if (orgId != null && orgId.isNotEmpty) {
      variables["inputData"]?["org_user_id"] = orgId;
    }
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: removeTimerQueryData, variables: variables);
    return response.data;
  }




  Future<Map<String, dynamic>?>? createManualEntry(
      String startDate, String endDate, String des, String projectId,
      [String? taskId, String? orgId, String ?status]) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "start_date": startDate,
        "end_date": endDate,
        "description": des,
        "status": status?.isNotEmpty == true ? status : "pending",
        "project_id": projectId,
      }
    };

    if (taskId != null && taskId.isNotEmpty) {
      variables["inputData"]?["task_id"] = taskId;
    }
    if (orgId != null && orgId.isNotEmpty) {
      variables["inputData"]?["org_user_id"] = orgId;
    }
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: createNewEntryQuery, variables: variables);
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

  Future<Map<String, dynamic>?>? updateTimelineLogDetails(String startDate, String endDate, String des, String projectId, String timelineId, [String? status, String? taskId]) async {

    print('''
    
    "start_date": $startDate,
        "end_date":$endDate,
        "description": $des,
        "status": $status ?? "pending",
        "project_id": $projectId,
        "timeline_id": $timelineId
        "timeline_id": $taskId
    ''');
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "start_date": startDate,
        "end_date": endDate,
        "description": des,
        "project_id": projectId,
        "timeline_id":timelineId
      }
    };

    if (taskId != null || taskId!.isNotEmpty) {
      variables["inputData"]?["task_id"] = taskId;
    }
  if (status != null && status.isNotEmpty) {
      variables["inputData"]?["status"] = status;
    }



    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: updateTimelineLogDetailsQueryData, variables: variables);
    print('response_updated: ${response.data}');
    return response.data;
  }
}

//
// "start_date": "2025-02-19 14:35:00",
// "end_date": "2025-02-19 21:35:00",
// "description": des,
// "status":"pending",
// "project_id": "039a0d2f-f0f1-484b-b76e-e61a367fc23d",
// "timeline_id": "1cb9bc05-43fd-4d38-af82-e4648aabb402"