import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/employee_overview.dart';
import '../models/job_opening.dart';
import '../models/leave_timline_summary.dart';
import '../repositories/dashboard_repository.dart';

class HrDashBoardController extends GetxController with StateMixin {
  final DasBoardDataSource _dasBoardDataSource;
  HrDashBoardController(this._dasBoardDataSource);

  final RxInt currentIndex = 0.obs;
  final RxInt jobTabCurrentIndex = 0.obs;

  RxInt jobDetailsSelectedIndex = 0.obs; // Track the selected tab index
  late PageController pageController; // For smooth scrolling

  RxBool isCandidateSelected = false.obs; // Check if a candidate is selected

  RxBool isPasteButtonActive =
      false.obs; // Track if the paste button should be active

  RxString selectedCandidateId = ''.obs; // Ensure it's reactive

  int activeStarIndex = -1;
  RxString reviewerInputValue = "".obs;

  final ScrollController scrollController = ScrollController();

  TextEditingController candidateEmail = TextEditingController();
  TextEditingController candidateFirstName = TextEditingController();
  TextEditingController candidateLastName = TextEditingController();
  TextEditingController createReviewMessage = TextEditingController();

  EmployeeOverview? employeeOverview;
  JobOpening? jobOpening;
  LeaveTimeLogSummary? leaveTimeLogSummary;

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
    createReviewMessage.dispose();
    pageController.dispose();

    super.onClose();
  }

  void _getDate() async {
    await getEmployeeOverView();
    await getJobOpening();
    await getLeaveAndTimeLogSummary();
  }
}
