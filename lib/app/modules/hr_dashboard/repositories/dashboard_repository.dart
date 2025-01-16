import 'dart:developer';
import '../models/candidate_activities_logs.dart';
import '../models/employee_overview.dart';
import '../models/job_applocation_board.dart';
import '../models/job_opening.dart';
import '../models/leave_timline_summary.dart';
import '../services/dashboard_api_services.dart';


abstract class DashBoardDataSource {
  Future<EmployeeOverview?> getEmployeeOverview();
  Future<JobOpening?> getJobOpening();
  Future<LeaveTimeLogSummary?> getLeaveAndTimeLogSummary();
  Future<JobApplicationBoard?> getJobApplicationBoard({required String entityId});
  Future<bool?> updateJobApplication({required String hiringStageId,required String jobApplicationId});
  Future<bool?> removeJobApplication({required String jobId,required String candidateId});
  Future<CandidateActivitiesLogs?> getCandidateActivitiesLogs({required String jobApplicationId});

}


class DasBoardDataSourceImpl implements DashBoardDataSource {
  final DashBoardApiService _dashBoardApiService;

  DasBoardDataSourceImpl(this._dashBoardApiService);

  @override
  Future<EmployeeOverview?>  getEmployeeOverview() async {
    try {
      final response = await _dashBoardApiService.getEmployeeOverView();
      if (response != null) {
        return EmployeeOverview.fromJson(response);
      }
    } catch (ex) {
      log("getEmployeeOverview : $ex");
    }
    return null;
  }


  @override
  Future<JobOpening?> getJobOpening() async {
    try {
      final response = await _dashBoardApiService.getJobOpening();
      if (response != null) {
        return JobOpening.fromJson(response);
      }
    } catch (ex) {
      log("getJobOpening : $ex");
    }
    return null;
  }


  @override
  Future<LeaveTimeLogSummary?> getLeaveAndTimeLogSummary() async {
    try {
      final response = await _dashBoardApiService.getLeaveAndTimeLogSummary();
      if (response != null) {
        return LeaveTimeLogSummary.fromJson(response);
      }
    } catch (ex) {
      log("getLeaveAndTimeLogSummary : $ex");
    }
    return null;
  }


  @override
 Future<JobApplicationBoard?> getJobApplicationBoard({required String entityId}) async {
    try {
      final response = await _dashBoardApiService.getJobApplicationBoard(
          entityId);
      if (response != null) {
        return JobApplicationBoard.fromJson(response);
      }
    } catch (ex) {
      log("getJobApplicationBoard : $ex");
    }
    return null;
  }



  @override
  Future<bool?> updateJobApplication({required String hiringStageId, required String jobApplicationId}) async {
    try {
      final response = await _dashBoardApiService.updateJobApplication(hiringStageId, jobApplicationId);
      if (response != null) {
        return true;
      }
      return null;
    } catch (e) {
      log('Error updating job application: $e');
      return null;
    }
  }


  @override
  Future<bool?> removeJobApplication({required String jobId,required String candidateId}) async {
    try {
      final response = await _dashBoardApiService.removeJobApplication(jobId, candidateId);
      if (response != null) {
        return true;
      }
      return null;
    } catch (e) {
      log('Error remove job application : $e');
      return null;
    }
  }


  @override
  Future<CandidateActivitiesLogs?> getCandidateActivitiesLogs({required String jobApplicationId})async {
    try{
      final response= await _dashBoardApiService.getCandidateActivitiesLogs(jobApplicationId);

      if(response !=null){
        return CandidateActivitiesLogs.fromJson(response);
      }
      return null;

    }catch(ex){
      log("getCandidateActivitiesLogs : $ex");
    }
    return null;
  }

}
