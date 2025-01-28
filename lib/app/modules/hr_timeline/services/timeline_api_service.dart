import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/app/modules/employee/model/terminate_org_user.dart';

import '../../../../utils/api_endpoints.dart';

class TimelineApiService {
  final ApiService _apiService;
  TimelineApiService(this._apiService);

  Future<QueryResult<Object?>> getTimeSheets(
      String startDate, String endDate, String orgId) async {
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

  Future<QueryResult<Object?>> getTimelineSummary(
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
      "queryData": {
        "start_time": startDate,
        "end_time": endDate,
      }
    };
    if (orgUserId != null) {
      variables["queryData"]?["org_user_id"] = orgUserId;
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

  Future<Map<String, dynamic>?>? saveTimelineEntry(String des, String startDate,
      String endDate, String projectId, String timelineId,
      [String? taskId]) async {
    print('''
 
    Api_services: => 
    
    des $des
    startDate $startDate
    endDate $endDate
    projectId $projectId
    timelineId $timelineId
    taskId $taskId
    
   
    ''');

    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "description": des,
        "start_date": startDate,
        "end_date": endDate,
        "status": "pending",
        "task_id": taskId,
        "project_id": projectId,
        "timeline_id": timelineId
      }
    };

    if (taskId != null) {
      variables["inputData"]?["task_id"] = taskId;
    }
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: saveTimerQueryData, variables: variables);
    return response.data;
  }

  Future<Map<String, dynamic>?>? removeTimelineEntry(String timeLogId) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "timeline_id": timeLogId,
      }
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: removeTimerQueryData, variables: variables);
    return response.data;
  }


  Future<Map<String, dynamic>?>? createManualEntry(String startDate,String endDate,String des,String projectId,[String ?taskId]) async {

    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "start_date":startDate,
        "end_date":endDate,
        "description": des,
        "status": "pending",
        "project_id": projectId,
      }
    };
    if (taskId != null) {
      variables["inputData"]?["task_id"] = taskId;
    }
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: createNewEntryQuery, variables: variables);
    print("createManualEntry: ${response.data}");
    return response.data;
  }


  Future<Map<String, dynamic>?>? updateTimelineLogDetails(String startDate,String endDate,String des,String projectId,String timelineId,[String ?taskId]) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {
        "start_date":startDate,
        "end_date":endDate,
        "description": des,
        "status": "pending",
        "project_id": projectId,
        "timeline_id":timelineId
      }
    };
    if (taskId != null) {
      variables["inputData"]?["task_id"] = taskId;
    }
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: updateTimelineLogDetailsQueryData, variables: variables);


    return response.data;
  }
}
