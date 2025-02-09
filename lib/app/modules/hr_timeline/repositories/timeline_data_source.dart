import 'dart:developer';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../../modules/timeline/model/timelog_details_by_month.dart';
import '../models/project_dropdown_response.dart';
import '../../../../modules/timeline/model/start_or_end_timer_response.dart';
import '../models/time_entry_details.dart';
import '../models/timeline_summary_by_date.dart';
import '../models/calendar_timeline.dart';
import '../models/time_sheet_model.dart';
import '../models/timelog_entries_details.dart';
import '../models/update_timelog_entry.dart';
import '../services/timeline_api_service.dart';

abstract class TimelineDataSource {
  Future<TimelineSummaryByDate?> getTimelineSummaryByDate({required String startDate, required String endDate,String?orgUserId});
  Future<TimeSheetModel?>  getTimesheetByDate({required String startDate, required String endDate,required String orgId});
  Future<CalendarTimeline?> getTimelineCalender({required String startDate, required String endDate,String ?orgUserId});
  Future<StartOrEndTimerResponse?> startOrEndTimer({required String timerTyp});
  Future<ProjectDropDownResponse?>  getProjectList({required String searchText});
  Future<bool> removeTimelineEntry({required String timeLogId,String ?orgId});
  Future<TimeEntryDetails?>  getTimeEntryDetails({required  String timelineId,required String orgId});
  Future<TimeLogsEntriesDetails?> getTimeLogEntries({required String startDate, required String endDate,String ?orgUserId});
  Future<UpdateTimelogEntry?> updateTimeLogEntryById({required String status,required String timelineId});
  Future<bool> updateTimelineLogDetails({required String startDate,required String endDate,required String status,required String des,required String projectId,required String timelineId,String ?taskId});
  Future<bool> createManualEntry({required String startDate,required String endDate,required String des,required String projectId,String ?taskId,String?orgId,String?status});
  Future<TimelogDetailsByMonth?> getTimelogDetailsByMonth({required String startDate, required String endDate,String ?orgUserId});
  Future<bool?> saveTimelineEntry({required String des,required String startDate,required String endDate,required String taskId,required String projectId,required String timelineId});}


class TimelineDataImpl implements TimelineDataSource {
 final TimelineApiService _timelineApiService;
 TimelineDataImpl(this._timelineApiService);

  @override
  Future<TimelineSummaryByDate?> getTimelineSummaryByDate({required String startDate, required String endDate,String ?orgUserId}) async {
    QueryResult<Object?> response = await _timelineApiService.getTimelineSummary(startDate, endDate,orgUserId: orgUserId);
    print('''
    getTimelineSummaryByDate ${response.data}
    startDate : $startDate
    endDate : $endDate
    orgUserId : $orgUserId
    
    getTimelineSummaryByDate : $response
    
    
    ''');
    if (response.data != null) {
      return TimelineSummaryByDate.fromJson(response.data!);
    }
    return null;
  }

  @override
  Future<TimelogDetailsByMonth?> getTimelogDetailsByMonth({required String startDate, required String endDate,String ?orgUserId}) async {
    QueryResult<Object?> response = await _timelineApiService.getTimelogDetailsByMonth(startDate, endDate,orgUserId);
    print('''
    getTimelogDetailsByMonth ${response.data}
    startDate : $startDate
    endDate : $endDate
        orgUserId : $orgUserId
    
    ''');
    if (response.data != null) {
      return TimelogDetailsByMonth.fromJson(response.data!);
    }
    return null;
  }

  @override
  Future<UpdateTimelogEntry?> updateTimeLogEntryById({required String status,required String timelineId}) async {
    QueryResult<Object?> response = await _timelineApiService.updateTimeLogEntryById( status, timelineId);
    print("updateTimeLogEntryById :: $response");
    if (response.data != null) {
      return UpdateTimelogEntry.fromJson(response.data!);
    }
    return null;
  }


  @override
  Future<TimeLogsEntriesDetails?> getTimeLogEntries({required String startDate, required String endDate,String ?orgUserId}) async {
    QueryResult<Object?> response = await _timelineApiService.getTimeLogEntries(startDate, endDate,orgUserId);


    print("getTimeLogEntries : ${response.data}");
    if (response.data != null) {
      return TimeLogsEntriesDetails.fromJson(response.data!);
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
   Future<TimeSheetModel?>  getTimesheetByDate({required String startDate, required String endDate, String ?orgId}) async {
    QueryResult<Object?> response = await _timelineApiService.getTimeSheets(startDate, endDate,orgId);
    print("getTimesheetByDate : ${response.data}");
    if (response.data != null) {
      return TimeSheetModel.fromJson(response.data!);
    }
    return null;
  }




   @override
   Future<ProjectDropDownResponse?>  getProjectList({required String searchText}) async {

    try{
      QueryResult<Object?> response = await _timelineApiService.getProjectList(searchText);
      if (response.data != null) {
        return ProjectDropDownResponse.fromJson(response.data!);
      }
      return null;
    }catch(e){
      log("getProjectList ex : $e");
    }
    return null;

  }

  @override
   Future<TimeEntryDetails?>  getTimeEntryDetails({required  String timelineId,required String orgId}) async {

    print("getTimeEntryDetails: timelineId: $timelineId orgId $orgId");

    try{
      QueryResult<Object?> response = await _timelineApiService.getTimeEntryDetails(timelineId,orgId);
      print("getTimeEntryDetails_response : ${response.data}");
      if (response.data != null) {
        return TimeEntryDetails.fromJson(response.data!);
      }
      return null;
    }catch(e){
      log("getTimeEntryDetails ex : $e");
    }
    return null;

  }





 @override
 Future<StartOrEndTimerResponse?> startOrEndTimer({required  String timerTyp}) async {
  try{
    Map<String, dynamic>? response = await  _timelineApiService.startOrEndTimer(timerTyp);
    print('''startOrEndTimer $response''');
    if (response != null) {
      return StartOrEndTimerResponse.fromJson(response);
    }
    return null;
  }catch(x){
    log("startOrEndTimer_ex $x");
  }
  return null;


  }


 @override
 Future<bool> removeTimelineEntry({required String timeLogId,String ?orgId}) async {


    print("removeTimelineEntry : timeLogId::: $timeLogId  orgId :: $orgId");
   try {
     Map<String, dynamic>? response =
     await  _timelineApiService.removeTimelineEntry(timeLogId,orgId);
     if (response != null) {
       return true;
     }
   } catch (e) {
     log('Error in removeTimelineEntry: $e');
   }
   return false;
 }


 @override
 Future<bool> createManualEntry({required String startDate,required String endDate,required String des,required String projectId,String ?taskId,String?orgId,String?status}) async {


    print(''''
    createManualEntry: 
    startDate $startDate
    endDate $endDate
    ''');
    try {
     Map<String, dynamic>? response = await  _timelineApiService.createManualEntry( startDate, endDate, des, projectId,taskId,orgId,status);
     if (response != null) {
       return true;
     }
   } catch (e) {
     log('Error in createManualEntry: $e');
   }
   return false;
 }






 @override
 Future<bool> updateTimelineLogDetails({required String startDate,required String endDate,required String status,required String des,required String projectId,required String timelineId,String ?taskId}) async {
   try {
     Map<String, dynamic>? response =
     await  _timelineApiService.updateTimelineLogDetails( startDate, endDate, des, projectId, timelineId,status,taskId);
     if (response != null) {
       return true;
     }
   } catch (e) {
     log('Error in updateTimelineLogDetails: $e');
   }
   return false;
 }



 @override
 Future<bool?> saveTimelineEntry({required String des,required String startDate,required String endDate,required String taskId,required String projectId,required String timelineId}) async {
   try {
     Map<String, dynamic>? response =
     await  _timelineApiService.saveTimelineEntry( des,  startDate,  endDate,  projectId,  timelineId, taskId);
     if (response != null && response["updateTimelineEntry"] !=null) {
       return true;
     }
   } catch (e) {
     log('Error in saveTimelineEntry: $e');
   }
   return null;

 }

}



