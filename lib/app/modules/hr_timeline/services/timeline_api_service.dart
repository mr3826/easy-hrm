import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/app/modules/employee/model/terminate_org_user.dart';

import '../../../../utils/api_endpoints.dart';

class TimelineApiService {
  final ApiService _apiService;
  TimelineApiService(this._apiService);




  Future<QueryResult<Object?>> getTimeSheets(String startDate,String endDate,String orgId) async {
      Map<String, dynamic> variable ={
          "queryData": {
            "start_date": startDate,
            "end_date": endDate,
            "org_user_ids":[
              orgId
            ]
          },
          "optionData": {
            "order": [
              [
                "sh.name",
                "asc"
              ]
            ]
          }
      };
    return await _apiService.gqlCall(
        queryString: getTimeSheetByDateQuery, variables: variable);
  }

  Future<QueryResult<Object?>> getTimelineSummary(String startDate, String endDate, {String? orgUserId}) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "start_date": startDate,
        "end_date": endDate,
      }
    };
    if (orgUserId != null) {
      variables["queryData"]?["org_user_ids"] = orgUserId;
    }
    return await _apiService.gqlCall(queryString: getTimelineSummaryByDateQuery, variables: variables);
  }


  Future<QueryResult<Object?>> getTimelineCalender(String startDate, String endDate, {String? orgUserId}) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "start_time": startDate,
        "end_time": endDate,
      }
    };
    if (orgUserId != null) {
      variables["queryData"]?["org_user_id"] = orgUserId;
    }
    return await _apiService.gqlCall(queryString: getCalendarTimelineQuery, variables: variables);
  }






  Future<Map<String, dynamic>?>? startOrEndTimer(String timerType) async {
    Map<String, Map<String, dynamic>> variables = {
      "inputData": {"timer_type": timerType}
    };
    QueryResult<Object?> response = await _apiService.gqlCall(
        queryString: startOrEndTimerQueryData, variables: variables);
    return response.data;
  }




}
