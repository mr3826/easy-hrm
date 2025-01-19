import 'dart:developer';
import '../models/candidate_activities_logs.dart';
import '../models/candidate_details.dart';
import '../models/candidate_review.dart';
import '../models/employee_overview.dart';
import '../models/file_sign_url.dart';
import '../models/job_application_preview.dart';
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
  Future<FileSignedUrl?> getFileSignUrl({required String fileKey});
  Future<CandidateDetails?> getCandidateDetails({required String jobApplicationId});
  Future<CandidateReviewModel?> getCandidateReview({required String jobApplicationId});
  Future<bool?> createCandidateReview({required String jobId,required String jobApplicationId, required int rate});
  Future<bool?> createCandidateNoteReview({required String jobId,required String jobApplicationId, required String note});
  Future<bool?> deleteCandidateNoteReview({required String entityId});
  Future<bool?> updateCandidateNoteReview({required String noteId,required String note});
  Future<JobApplicationPreviewModel?> getJobApplicationPreview({required String jobId,required String candidateId});
  Future<bool?> updateJob({required String entityId});
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
  Future<bool?> updateJob({required String entityId}) async {
    try {
      final response = await _dashBoardApiService.updateJob(entityId);
      if (response != null) {
        return true;
      }
      return null;
    } catch (e) {
      log('Error updating job : $e');
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
  Future<bool?> createCandidateReview({required String jobId,required String jobApplicationId, required int rate}) async {
    try {
      final response = await _dashBoardApiService.createCandidateReview(jobId, jobApplicationId,rate);
      if (response != null) {
        return true;
      }
      return null;
    } catch (e) {
      log('Error createCandidateReview : $e');
      return null;
    }
  }

  @override
  Future<bool?> createCandidateNoteReview({required String jobId,required String jobApplicationId, required String note}) async {
    try {
      final response = await _dashBoardApiService.createCandidateNoteReview(jobId, jobApplicationId,note);
      if (response != null) {
        return true;
      }
      return null;
    } catch (e) {
      log('Error createCandidateNoteReview : $e');
      return null;
    }
  }

  @override
  Future<bool?> deleteCandidateNoteReview({required String entityId}) async {
    try {
      final response = await _dashBoardApiService.deleteCandidateNoteReview(entityId);
      if (response != null) {
        return true;
      }
      return null;
    } catch (e) {
      log('Error deleteCandidateNoteReview : $e');
      return null;
    }
  }
  @override
  Future<bool?> updateCandidateNoteReview({required String noteId,required String note}) async {
    try {
      final response = await _dashBoardApiService.updateCandidateNoteReview(noteId,note);
      if (response != null) {
        return true;
      }
      return null;
    } catch (e) {
      log('Error updateCandidateNoteReview : $e');
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


  @override
  Future<JobApplicationPreviewModel?> getJobApplicationPreview({required String jobId,required String candidateId })async {

    try{
      final response= await _dashBoardApiService.getJobApplicationPreview(jobId,candidateId);

      print("getJobApplicationPreview respo:: $response");
      if(response !=null){
        return JobApplicationPreviewModel.fromJson(response);
      }
    }catch(ex){
      log("getJobApplicationPreviewremo_ex : $ex");
    }

    return null;
  }





  @override
  Future<FileSignedUrl?> getFileSignUrl({required String fileKey})async {
    try {
      final response= await _dashBoardApiService.getFileSignUrl(fileKey);
      if(response !=null){
        return FileSignedUrl.fromJson(response);
      }
      return null;

    }catch(ex){
      log("getFileSignUrl : $ex");
    }
    return null;
  }

  @override
  Future<CandidateDetails?> getCandidateDetails({required String jobApplicationId})async {
    try{
      final response= await _dashBoardApiService.getCandidateDetails(jobApplicationId);
      if(response !=null){
        return CandidateDetails.fromJson(response);
      }
      return null;

    }catch(ex){
      log("candidateDetails : $ex");
    }
    return null;

  }

  @override
  Future<CandidateReviewModel?> getCandidateReview({required String jobApplicationId})async {
    try{
      final response= await _dashBoardApiService.getCandidateReview(jobApplicationId);
      if(response !=null){
        return CandidateReviewModel.fromJson(response);
      }
      return null;

    }catch(ex){
      log("getTeamNotQuery : $ex");
    }
    return null;

  }
}
