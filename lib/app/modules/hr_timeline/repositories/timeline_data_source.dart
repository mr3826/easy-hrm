import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import '../../../../modules/timeline/model/timeline_summary_by_date.dart';
import '../../../../utils/api_endpoints.dart';
import '../models/time_sheet_model.dart';
import '../services/timeline_api_service.dart';

abstract class TimelineDataSource {
  Future<TimelineSummaryByDate?> getTimelineSummaryByDate({required String startDate, required String endDate});
  Future<TimeSheetModel?>  getTimesheetByDate({required String startDate, required String endDate,required String orgId});
}



class TimelineDataImpl implements TimelineDataSource {
 final TimelineApiService _timelineApiService;
 TimelineDataImpl(this._timelineApiService);

  @override
  Future<TimelineSummaryByDate?> getTimelineSummaryByDate({required String startDate, required String endDate}) async {
    QueryResult<Object?> response = await _timelineApiService.getTimelineSummary(startDate, endDate);
    if (response.data != null) {
      return TimelineSummaryByDate.fromJson(response.data!);
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



}



