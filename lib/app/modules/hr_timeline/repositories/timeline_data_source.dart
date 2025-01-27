import 'dart:developer';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../../modules/timeline/model/start_or_end_timer_response.dart';
import '../models/timeline_summary_by_date.dart';
import '../models/calendar_timeline.dart';
import '../models/time_sheet_model.dart';
import '../services/timeline_api_service.dart';

abstract class TimelineDataSource {
  Future<TimelineSummaryByDate?> getTimelineSummaryByDate({required String startDate, required String endDate,String?orgUserId});
  Future<TimeSheetModel?>  getTimesheetByDate({required String startDate, required String endDate,required String orgId});
  Future<CalendarTimeline?> getTimelineCalender({required String startDate, required String endDate,String ?orgUserId});
  Future<StartOrEndTimerResponse?> startOrEndTimer({required  String timerTyp});
}



class TimelineDataImpl implements TimelineDataSource {
 final TimelineApiService _timelineApiService;
 TimelineDataImpl(this._timelineApiService);

  @override
  Future<TimelineSummaryByDate?> getTimelineSummaryByDate({required String startDate, required String endDate,String ?orgUserId}) async {
    QueryResult<Object?> response = await _timelineApiService.getTimelineSummary(startDate, endDate,orgUserId: orgUserId);
    print("getTimelineSummaryByDate :: $response");
    if (response.data != null) {
      return TimelineSummaryByDate.fromJson(response.data!);
    }
    return null;
  }




 @override
  Future<CalendarTimeline?> getTimelineCalender({required String startDate, required String endDate,String ?orgUserId}) async {

    QueryResult<Object?> response = await _timelineApiService.getTimelineCalender(startDate, endDate,orgUserId: orgUserId);

    print("getTimelineCalender :: $response");

    if (response.data != null) {
      return CalendarTimeline.fromJson(response.data!);
    }
    return null;
  }



   @override
   Future<TimeSheetModel?>  getTimesheetByDate({required String startDate, required String endDate,required String orgId}) async {
    QueryResult<Object?> response = await _timelineApiService.getTimeSheets(startDate, endDate,orgId);
    if (response.data != null) {
      return TimeSheetModel.fromJson(response.data!);
    }
    return null;
  }





 @override
 Future<StartOrEndTimerResponse?> startOrEndTimer({required  String timerTyp}) async {
  try{
    Map<String, dynamic>? response = await  _timelineApiService.startOrEndTimer(timerTyp);
    if (response != null) {
      return StartOrEndTimerResponse.fromJson(response);
    }
    return null;
  }catch(x){
    log("startOrEndTimer $x");
  }


  }
}



