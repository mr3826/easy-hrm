import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import '../models/candidate_list.dart';
import '../models/employee_overview.dart';
import '../models/filter_hiring_stages.dart';
import '../models/filter_jobs_dropdown.dart';
import '../models/job_applocation_board.dart';
import '../models/job_opening.dart';
import '../models/leave_timline_summary.dart';
import '../repositories/dashboard_repository.dart';

class HrDashBoardController extends GetxController with StateMixin {
  final DashBoardDataSource _dasBoardDataSource;
  HrDashBoardController(this._dasBoardDataSource);

  final RxInt currentIndex = 0.obs;

  RxInt jobDetailsSelectedIndex = 0.obs; // Track the selected tab index
  late PageController pageController; // For smooth scrolling

  RxBool isCandidateSelected = false.obs; // Check if a candidate is selected
  RxBool isJobApplicationBoardLoading = false.obs;
  RxBool isJobApplicationUpdateLoading = false.obs;
  RxBool isUpdateCandidateLoading = false.obs;
  RxBool isRemoveCandidateLoading = false.obs;
  RxBool isJobUpdateLoading = false.obs;
  RxBool isJobApplicationRemoveLoading = false.obs;
  RxBool isCandidateListLoading = false.obs;
  RxBool isCandidateBySearchLoading = false.obs;
  RxBool isCandidateFilterLoading = false.obs;

  RxBool isPasteButtonActive =
      false.obs; // Track if the paste button should be active

  RxString selectedHiringStageId = ''.obs;

  RxString selectedJobApplicationId = ''.obs;
  RxString selectedJobId = ''.obs;
  RxString nextHiringStagesId = ''.obs;
  RxInt nextHiringStateIndex = 0.obs;

  RxString selectedCandidateId = ''.obs;///todo

  final ScrollController scrollController = ScrollController();

  TextEditingController candidateEmail = TextEditingController();
  TextEditingController candidateFirstName = TextEditingController();
  TextEditingController candidateLastName = TextEditingController();
  TextEditingController candidateSearchController = TextEditingController();

  EmployeeOverview? employeeOverview;
  JobOpening? jobOpening;
  CandidateList? candidateList;
  FilterHiringStages? filterHiringStages;
  FilterJobsDropdown? filterJobsDropdown;









  LeaveTimeLogSummary? leaveTimeLogSummary;
  JobApplicationBoard? jobApplicationBoard;

  getEmployeeOverView() async {
    employeeOverview = await _dasBoardDataSource.getEmployeeOverview();
  }

  getJobOpening() async {
    change(null, status: RxStatus.loading());
    jobOpening = await _dasBoardDataSource.getJobOpening();
    change(null, status: RxStatus.success());
  }

  getCandidateList(String searchKey) async {
    isCandidateListLoading(true);
    candidateList = await _dasBoardDataSource.getCandidateList(searchKey: searchKey);
    isCandidateListLoading(false);
  }

  getCandidateBySearch(String searchKey) async {
    isCandidateBySearchLoading(true);
    candidateList = await _dasBoardDataSource.getCandidateList(searchKey: searchKey);
    isCandidateBySearchLoading(false);
  }


  getJobsDropdown() async {
    isCandidateFilterLoading(true);
    filterJobsDropdown = await _dasBoardDataSource.getJobsDropdown();
    isCandidateFilterLoading(false);
  }

  getHiringStages() async {
    isCandidateFilterLoading(true);
    filterHiringStages = await _dasBoardDataSource.getHiringStages();
    isCandidateFilterLoading(false);
  }







  getLeaveAndTimeLogSummary() async {
    change(null, status: RxStatus.loading());
    leaveTimeLogSummary = await _dasBoardDataSource.getLeaveAndTimeLogSummary();
    change(null, status: RxStatus.success());
  }

  getJobApplicationBoard({required String entityId}) async {
    isJobApplicationBoardLoading(true);
    jobApplicationBoard =
        await _dasBoardDataSource.getJobApplicationBoard(entityId: entityId);

    ///Add hiring first stage Id
    selectedHiringStageId.value =
        jobApplicationBoard?.getJobApplicationBoard?.hiringStages?.first.id ??
            "";

    nextHiringStagesId.value =
        jobApplicationBoard?.getJobApplicationBoard?.hiringStages?[1].id ?? "";

    isJobApplicationBoardLoading(false);
  }

  Future updateJobApplication(
      {required String hiringStageId,
      required String jobApplicationId,
      required String entryId}) async {
    isJobApplicationUpdateLoading(true);
    bool? response = await _dasBoardDataSource.updateJobApplication(
        hiringStageId: hiringStageId, jobApplicationId: jobApplicationId);

    if (response == true) {
      showSuccessMessage(message: "Job application has been updated!");
      _updatedDate(entryId);
    }
    isJobApplicationUpdateLoading(false);
  }


  Future updateCandidate({required String candidateId,required String jobId ,required String email, required String firstName, required String lastName}) async {

    isUpdateCandidateLoading(true);
    bool? response = await _dasBoardDataSource.updateCandidate(jobId: jobId,candidateId: candidateId,email: email,firstName: firstName,lastName: lastName);

    if (response == true) {
      showSuccessMessage(message: "Candidate has been update successfully ");
    }
    isUpdateCandidateLoading(false);
  }


  Future removeCandidate({required String candidateId,required String jobId}) async {

    isRemoveCandidateLoading(true);
    bool? response = await _dasBoardDataSource.removeCandidate(jobId: jobId,candidateId: candidateId);

    if (response == true) {
      showSuccessMessage(message: "Candidate has been remove successfully");
    }
    isRemoveCandidateLoading(false);
  }



  Future updateJob({required String entryId}) async {
    isJobUpdateLoading(true);
    bool? response = await _dasBoardDataSource.updateJob(
      entityId: entryId,
    );

    if (response == true) {
      showSuccessMessage(message: "Job has been updated!");
      _updatedDate(entryId);
    }
    isJobUpdateLoading(false);
  }

  removeJobApplication(
      {required String candidateId, required String jobId}) async {
    isJobApplicationRemoveLoading(true);
    bool? response = await _dasBoardDataSource.removeJobApplication(
        jobId: jobId, candidateId: candidateId);
    if (response == true) {
      showSuccessMessage(message: "Job application has been removed!");
      getJobApplicationBoard(entityId: jobId);
      Get.back(canPop: false);
    }
    isJobApplicationRemoveLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
        initialPage: jobDetailsSelectedIndex.value,
        viewportFraction: 0.9); // Set viewportFraction for smooth swipe
    scrollController.addListener(() {
      final double offset = scrollController.offset;
      final int index = (offset / 340).round(); // Assuming item width is 340
      currentIndex.value = index;
    });

    _getDate();
  }

  @override
  void onClose() {
    scrollController.dispose();
    candidateEmail.dispose();
    candidateFirstName.dispose();
    candidateLastName.dispose();
    candidateSearchController.dispose();
    pageController.dispose();

    super.onClose();
  }

  void _getDate() async {
    await getEmployeeOverView();
    await getJobOpening();
    await getLeaveAndTimeLogSummary();
  }

  void _updatedDate(String entryId) {
    getJobApplicationBoard(entityId: entryId);
    selectedHiringStageId.value = "";
    selectedCandidateId.value = "";
    selectedJobApplicationId.value = "";
    isPasteButtonActive(false);
    isCandidateSelected(false);
    currentIndex(0);
    selectedHiringStageId.value = "";
    selectedCandidateId.value = "";
    selectedJobApplicationId.value = "";
    isPasteButtonActive(false);
    jobDetailsSelectedIndex(0);
  }
}
