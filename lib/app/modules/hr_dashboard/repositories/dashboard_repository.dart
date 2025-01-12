import 'dart:developer';

import '../models/employee_overview.dart';
import '../models/job_opening.dart';
import '../models/leave_timline_summary.dart';
import '../services/dashboard_api_services.dart';



abstract class DasBoardDataSource {
  Future<EmployeeOverview?> getEmployeeOverview();
  Future<JobOpening?> getJobOpening();
  Future<LeaveTimeLogSummary?> getLeaveAndTimeLogSummary();
}


class DasBoardDataSourceImpl implements DasBoardDataSource {
 final DashBoardApiService _dashBoardApiService;
  DasBoardDataSourceImpl(this._dashBoardApiService);

  @override
  getEmployeeOverview() async {
    final response = await _dashBoardApiService.getEmployeeOverView();
    if (response != null) {
      return EmployeeOverview.fromJson(response);
    }
    return null;
  }


   @override
  getJobOpening() async {
    final response = await _dashBoardApiService.getJobOpening();
    if (response!= null) {
      return JobOpening.fromJson(response);
    }
    return null;
  }




  @override
  getLeaveAndTimeLogSummary()async {
    try{
      final response = await _dashBoardApiService.getLeaveAndTimeLogSummary();
      if (response!= null) {
        return LeaveTimeLogSummary.fromJson(response);
      }
      return null;
    }catch(ex){
      log("getLeaveAndTimeLogSummary : $ex");
    }
    return null;
  }

}
