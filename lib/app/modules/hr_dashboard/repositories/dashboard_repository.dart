import 'dart:developer';
import '../models/employee_overview.dart';
import '../models/job_applocation_board.dart';
import '../models/job_opening.dart';
import '../models/leave_timline_summary.dart';
import '../services/dashboard_api_services.dart';



abstract class DasBoardDataSource {
  Future<EmployeeOverview?> getEmployeeOverview();
  Future<JobOpening?> getJobOpening();
  Future<LeaveTimeLogSummary?> getLeaveAndTimeLogSummary();
  Future<JobApplicationBoard?> getJobApplicationBoard({required String entityId});
}


class DasBoardDataSourceImpl implements DasBoardDataSource {
 final DashBoardApiService _dashBoardApiService;
  DasBoardDataSourceImpl(this._dashBoardApiService);

  @override
  getEmployeeOverview() async {
   try{
     final response = await _dashBoardApiService.getEmployeeOverView();
     if (response != null) {
       return EmployeeOverview.fromJson(response);
     }
   }catch(ex){
     log("getEmployeeOverview : $ex");
   }
   return null;
  }


   @override
  getJobOpening() async {
   try{
     final response = await _dashBoardApiService.getJobOpening();
     if (response!= null) {
       return JobOpening.fromJson(response);
     }
   }catch(ex){
     log("getJobOpening : $ex");
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
    }catch(ex){
      log("getLeaveAndTimeLogSummary : $ex");
    }
    return null;
  }


  @override
  getJobApplicationBoard({required String entityId})async {
    try{
      final response = await _dashBoardApiService.getJobApplicationBoard(entityId);
      if (response!= null) {
        return JobApplicationBoard.fromJson(response);
      }
    }catch(ex){
      log("getJobApplicationBoard : $ex");
    }
    return null;
  }




}
