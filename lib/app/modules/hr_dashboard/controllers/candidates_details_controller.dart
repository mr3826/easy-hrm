import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/utils.dart';
import '../models/candidate_activities_logs.dart';
import '../models/candidate_details.dart';
import '../models/candidate_review.dart';
import '../models/file_sign_url.dart';
import '../models/job_application_preview.dart';
import '../repositories/dashboard_repository.dart';

class CandidateDetailsController extends GetxController with StateMixin {
  final DashBoardDataSource _dasBoardDataSource;
  CandidateDetailsController(this._dasBoardDataSource);

  RxBool isFileSignUrlLoading = false.obs;
  RxBool isCreateReviewLoading = false.obs;
  RxBool isDeletedTeamNoteLoading = false.obs;
  RxBool isUpdateTeamNoteLoading = false.obs;
  RxBool isReviewLoading = false.obs;
  RxBool isEditNote = false.obs;
  int activeStarIndex = -1;
  int initialTabIndex = 0;
  RxString reviewerInputValue = "".obs;
  RxString selectedNoteId = "".obs;
  TextEditingController createReviewMessage = TextEditingController();

  CandidateActivitiesLogs? candidateActivitiesLogs;
  CandidateDetails? candidateDetails;
  JobApplicationPreviewModel? jobApplicationPreview;
  CandidateReviewModel? candidateReviewModel;
  FileSignedUrl? fileSignedUrl;


  Future getCandidateActivitiesLogs(String jobApplicationId) async {
    isReviewLoading(true);
    candidateActivitiesLogs = await _dasBoardDataSource
        .getCandidateActivitiesLogs(jobApplicationId: jobApplicationId);
    isReviewLoading(false);
  }

  Future getCandidateDetails(String jobApplicationId) async {
    change(null, status: RxStatus.loading());
    candidateDetails = await _dasBoardDataSource.getCandidateDetails(
        jobApplicationId: jobApplicationId);
    change(null, status: RxStatus.success());
  }

  Future getJobApplicationPreview(String jobId,String candidateId ) async {
    isReviewLoading(true);
    jobApplicationPreview = await _dasBoardDataSource.getJobApplicationPreview(jobId: jobId,candidateId: candidateId);
    isReviewLoading(false);

  }

  Future getCandidateReview(String jobApplicationId) async {
    isReviewLoading(true);

    candidateReviewModel = await _dasBoardDataSource.getCandidateReview(
        jobApplicationId: jobApplicationId);
    isReviewLoading(false);

  }

  Future getFileSignUrl(String fileKey) async {
    isFileSignUrlLoading(true);
    final urlPath =
        '${"files"}/${GetStorage().read(AppString.ORGANIZATION_ID)}/$fileKey';
    fileSignedUrl = await _dasBoardDataSource.getFileSignUrl(fileKey: urlPath);
    isFileSignUrlLoading(false);
    openUrlInBrowser(fileSignedUrl?.getFileSignedUrl ?? "");
  }

  Future createCandidateReview({required String jobApplicationId, required String jobId, required int rate}) async {
    isCreateReviewLoading(true);
    bool? response = await _dasBoardDataSource.createCandidateReview(jobApplicationId: jobApplicationId, jobId: jobId, rate: rate);
    if (response == true) {
      showSuccessMessage(message: "Review create has been successfully");
    }
    isCreateReviewLoading(false);
  }

  Future createCandidateNoteReview({required String jobApplicationId, required String jobId, required String note}) async {
    isCreateReviewLoading(true);
    bool? response = await _dasBoardDataSource.createCandidateNoteReview(jobApplicationId: jobApplicationId, jobId: jobId, note: note);
    if (response == true) {
      showSuccessMessage(message: "Review create has been successfully");
    }
    isCreateReviewLoading(false);
  }

  Future deleteCandidateNoteReview({required String entityId}) async {
    isDeletedTeamNoteLoading(true);

    bool? response = await _dasBoardDataSource.deleteCandidateNoteReview(entityId: entityId);

    if (response == true) {
      showSuccessMessage(message: "Team note delete successfully");
    }
    isDeletedTeamNoteLoading(false);
  }

  Future updateCandidateNoteReview({required String noteId, required String note}) async {
    isUpdateTeamNoteLoading(true);
    bool? response = await _dasBoardDataSource.updateCandidateNoteReview(noteId: noteId, note: note);
    if (response == true) {
      showSuccessMessage(message: "Team note update successfully");
    }
    isUpdateTeamNoteLoading(false);
  }

  @override
  void dispose() {
    createReviewMessage.dispose();
    super.dispose();
  }
}
