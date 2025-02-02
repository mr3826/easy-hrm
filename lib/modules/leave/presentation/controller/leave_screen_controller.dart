import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/employee_timeline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/leave/data/remote/leave_remote_data_source.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/leave_record_controller.dart';
import 'package:payrun_mobile/modules/leave/domain/leave_summary_dashboard.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../app/modules/hr_timeline/controllers/timelog_summary_controller.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../dashboard/presentation/controller/employee_dashboard_controller.dart';
import '../../domain/leave_details_by_date.dart';
import '../../domain/workshief_response_by_date.dart';

class LeaveScreenController extends GetxController with StateMixin {
  LeaveSummaryForDashboard? leaveSummaryForDashboard;
  LeaveDetailsByDate? leaveDetailsByDate;
  final isLoading = false.obs;
  final cancelLeaveLoader = false.obs;
  String? startTime;
  String? endTime;
  List<int> holidays = <int>[6, 7];
  late RxString date;

  final LeaveRemoteDataSource _leaveRemoteDataSource =
      Get.find<LeaveRemoteDataSource>();

  /// Fetches the leave summary for the dashboard and updates the state.
  Future<void> getLeaveSummaryForDashboard() async {
    change(null, status: RxStatus.loading());
    leaveSummaryForDashboard =
        await _leaveRemoteDataSource.getLeaveSummaryForDashboard();
    change(null, status: RxStatus.success());
  }

  /// Fetches the leave details for a specific date and updates the state.
  Future<void> getLeaveDetailsByDate() async {
    isLoading(true);
    leaveDetailsByDate = await _leaveRemoteDataSource.getLeaveRecordByDate(
      startDate: date.value,
      endDate: date.value,
    );
    isLoading(false);
  }

  /// Cancels a leave and updates the relevant data if successful.
  Future<void> cancelLeave({required String leaveId}) async {
    cancelLeaveLoader(true);
    final bool response =
        await _leaveRemoteDataSource.cancelLeave(leaveId: leaveId);

    if (response) {
      showSuccessMessage(message: AppString.leaveCanceledSuccessMessage.tr);
      updateData();
      Get.back(canPop: false);
      Get.back(canPop: false);
    }
    cancelLeaveLoader(false);
  }

  /// Removes a leave and updates the timeline data if successful.
  Future<void> removeLeave({required String leaveId}) async {
    cancelLeaveLoader(true);
    final bool response =
        await _leaveRemoteDataSource.removeLeave(leaveId: leaveId);

    if (response) {
      showSuccessMessage(message: AppString.leaveRemovedSuccessMessage.tr);
      updateData();
      _updateTimelineData();
      Get.back(canPop: false);
      Get.back(canPop: false);
    }
    cancelLeaveLoader(false);
  }

  /// Fetches the work shift schedule and processes holidays.
  Future<void> getWorkShift() async {
    final WorkShiftResponse? workShiftResponse =
        await _leaveRemoteDataSource.getWorkShift();

    final GetWorkScheduleForAssignLeave? workSchedule = workShiftResponse
        ?.getWorkScheduleForAssignLeave
        ?.firstWhere((element) => element.isHoliday == false,
            orElse: () => GetWorkScheduleForAssignLeave());

    startTime = workSchedule?.startTime;
    endTime = workSchedule?.endTime;

    holidays = workShiftResponse?.getWorkScheduleForAssignLeave
            ?.where((e) => e.isHoliday == true)
            .map((e) => e.dayOfWeek!)
            .toList() ??
        [];

    // Convert Sunday from 0 to 7 for compatibility with Table Calendar.
    if (holidays.contains(0)) {
      holidays.remove(0);
      holidays.add(7);
    }
  }

  @override
  void onInit() async {
    Get.put(DateTimePickerController());
    date = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
    await getLeaveSummaryForDashboard();
    await getLeaveDetailsByDate();
    await getWorkShift();
    super.onInit();
  }
}

/// Updates data across different controllers.
void updateData() {
  final LeaveScreenController leaveScreenController = Get.find<LeaveScreenController>();
  leaveScreenController
    ..getLeaveSummaryForDashboard()
    ..getLeaveDetailsByDate();

  Get.find<LeaveRecordsController>().getLeaveRecordsData();
  Get.find<EmployeeDashboardController>().getUpComingInfoForDashboard();
  _updateTimelineData();
}

/// Updates timeline data across different timeline controllers.
void _updateTimelineData() {
  final DateTimeController dateTimeController = Get.find<DateTimeController>();
  final DateTime requestedDate =
      DateTime.parse(dateTimeController.requestedDate.value);

  final TimelineGlobalController timelineController = Get.find<TimelineGlobalController>();

  final TimelineSummaryController timelineSummaryController = Get.find<TimelineSummaryController>();

  timelineController.getTimelineSummaryByDate(
    startDate: DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)
        .toString(),
    endDate:
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)
            .toString(),
  );

  timelineController.getTimelineSummaryByDate(
    startDate: DateTime(
            requestedDate.year, requestedDate.month, requestedDate.day, 0, 0, 0)
        .toString(),
    endDate: DateTime(requestedDate.year, requestedDate.month,
            requestedDate.day, 23, 59, 59)
        .toString(),
  );


  if(Get.find<TimelineGlobalController>().isEmployee.isTrue){
    Get.find<EmployeeTimelineController>().getTimelineCalenderByDate(
      startDate: DateTime(
          requestedDate.year, requestedDate.month, requestedDate.day, 0, 0, 0)
          .toString(),
      endDate: DateTime(requestedDate.year, requestedDate.month,
          requestedDate.day, 23, 59, 59)
          .toString(),
    );
  }else{
    Get.find<HrTimelineController>().getTimelineCalenderByDate(
      startDate: DateTime(
          requestedDate.year, requestedDate.month, requestedDate.day, 0, 0, 0)
          .toString(),
      endDate: DateTime(requestedDate.year, requestedDate.month,
          requestedDate.day, 23, 59, 59)
          .toString(),
      orgId: Get.find<TimelineGlobalController>().searchEmployeeId,


    );
  }







  timelineSummaryController.getTimelineSummaryByDate();
  timelineSummaryController.getTimelogDetailsByMonth();
}
