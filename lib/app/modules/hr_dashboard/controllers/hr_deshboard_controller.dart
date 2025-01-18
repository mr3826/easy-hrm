import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import '../models/employee_overview.dart';
import '../models/job_applocation_board.dart';
import '../models/job_opening.dart';
import '../models/leave_timline_summary.dart';
import '../repositories/dashboard_repository.dart';

class HrDashBoardController extends GetxController with StateMixin {
  final DashBoardDataSource _dasBoardDataSource;
  HrDashBoardController(this._dasBoardDataSource);
  //
  final RxInt currentIndex = 0.obs;
  // final RxInt jobTabCurrentIndex = 0.obs;

  RxInt jobDetailsSelectedIndex = 0.obs; // Track the selected tab index
  late PageController pageController; // For smooth scrolling

  RxBool isCandidateSelected = false.obs; // Check if a candidate is selected
  RxBool isJobApplicationBoardLoading = false.obs;
  RxBool isJobApplicationUpdateLoading = false.obs;
  RxBool isJobApplicationRemoveLoading = false.obs;

  RxBool isPasteButtonActive =
      false.obs; // Track if the paste button should be active

  RxString selectedHiringStageId = ''.obs;

  RxString selectedJobApplicationId = ''.obs;
  RxString selectedJobId = ''.obs;
  RxString nextHiringStagesId = ''.obs;
  RxInt nextHiringStateIndex = 0.obs;

  RxString selectedCandidateId = ''.obs;

  ///todo

  final ScrollController scrollController = ScrollController();

  TextEditingController candidateEmail = TextEditingController();
  TextEditingController candidateFirstName = TextEditingController();
  TextEditingController candidateLastName = TextEditingController();

  EmployeeOverview? employeeOverview;
  JobOpening? jobOpening;
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
    bool? response;
    response = await _dasBoardDataSource.updateJobApplication(
        hiringStageId: hiringStageId, jobApplicationId: jobApplicationId);

    if (response == true) {
      showSuccessMessage(message: "Job application has been updated!");
      _updatedDate(entryId);
    }
    isJobApplicationUpdateLoading(false);
  }

  removeJobApplication(
      {required String candidateId, required String jobId}) async {
    isJobApplicationRemoveLoading(true);
    bool? response;
    response = await _dasBoardDataSource.removeJobApplication(
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
