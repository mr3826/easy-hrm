import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/employee_timeline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../../common/widget/success_message.dart';
import '../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../common/widget/warning_message.dart';
import '../../../../enum.dart';
import '../../../../modules/timeline/model/start_or_end_timer_response.dart';
import '../../../../utils/app_string.dart';
import '../../../global/controller/timmer_controller.dart';
import '../../../global/controller/user_info_controller.dart';
import '../../../global/enum/user_enum.dart';
import '../../../home/view/screen/main_screen.dart';
import '../models/project_dropdown_response.dart';
import '../models/time_entry_details.dart';
import '../models/timeline_summary_by_date.dart';
import '../repositories/timeline_data_source.dart';

class TimelineGlobalController extends GetxController {
  final TimelineDataSource _timelineDataSource;
  TimelineGlobalController(this._timelineDataSource);


  final isProjectListLoading = false.obs;
  final isProistLoading = false.obs;
  final isManualEntryLoading = false.obs;
  final isTimelineSummaryByDateLoading = false.obs;
  final isUpdateTimeLogLoading = false.obs;
  final isStartTimerLoading = false.obs;
  final isTimeEntryLoading = false.obs;
  final isEndTimerLoading = false.obs;
  final isTimelogEntryOrRemoveLoading = false.obs;
  RxBool isValueChangeForTimeLogUpdate = false.obs;
  RxBool isEmployee = false.obs;
  final isTimeInvalid = false.obs;

  String addTimeLogId = "";
  RxString taskId = "".obs;
  RxString taskName = "".obs;
  RxString projectId = "".obs;
  RxString projectColor = "".obs;
  RxString timeLineId = "".obs;
  RxString orgUserId = "".obs;
  RxString status = "".obs;

  TextEditingController descriptionController = TextEditingController();

  ProjectDropDownResponse? projectDropDownResponse;
  StartOrEndTimerResponse? startOrEndTimerResponse;
  TimelineSummaryByDate? timelineSummaryByDate;
  TimeEntryDetails? timeEntryDetails;

  Future<ProjectDropDownResponse?> getProjectList({String? searchText}) async {
    isProjectListLoading(true);
    projectDropDownResponse =
        await _timelineDataSource.getProjectList(searchText: searchText ?? "");
    final taskInfo = projectDropDownResponse?.getProjectsDropdown?.first;

    taskName.value = taskInfo?.name ?? "";
    projectId.value = taskInfo?.id ?? "";
    projectColor.value = taskInfo?.color ?? "";
    if (taskInfo?.tasks != null && taskInfo!.tasks!.isNotEmpty) {
      taskId.value = taskInfo.tasks!.first.taskId.toString();
    }
    isProjectListLoading(false);
    return null;
  }


  Future<TimeEntryDetails?> getTimeEntryDetails({String? orgId,required String timelindId}) async {
    print('timelindId : $timelindId');
    isTimeEntryLoading(true);
    final String organizationId = orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);
    timeEntryDetails = await _timelineDataSource.getTimeEntryDetails(timelineId: timelindId.toString(),orgId:organizationId);
    isTimeEntryLoading(false);
    return null;
  }




  Future<bool> saveTimelineEntry() async {
    isTimelogEntryOrRemoveLoading(true);
    bool? response = await _timelineDataSource.saveTimelineEntry(
        des: descriptionController.text,
        startDate:
            _formatDate(startOrEndTimerResponse?.startOrStopTimer?.startDate),
        endDate:
            _formatDate(startOrEndTimerResponse?.startOrStopTimer?.endDate),
        taskId: taskId.value,
        projectId: projectId.value,
        timelineId: startOrEndTimerResponse?.startOrStopTimer?.id ?? "");

    if (response == true) {
      showSuccessMessage(message: AppString.timerSavedSuccessfulMessage.tr);

      _refreshTimeline();

      Get.find<TimeCounterController>().reset();

      Get.find<TimeCounterController>().isTotalCount(true);

      Get.to(() => const MainScreen(routeIndex: 0));

      taskId.value = "";
      taskName.value = '';
      projectId.value = '';
      orgUserId.value = '';
    }

    isTimelogEntryOrRemoveLoading(false);
    return false;
  }

  Future<bool> startOrEndTimer({required String timerType}) async {
    if (timerType == StartOrEndTimer.end.name) {
      isEndTimerLoading(true);
    } else {
      isStartTimerLoading(true);
    }
    startOrEndTimerResponse = await _timelineDataSource.startOrEndTimer(timerTyp: timerType);

    if(startOrEndTimerResponse?.startOrStopTimer !=null){
      if (startOrEndTimerResponse?.startOrStopTimer?.endDate == null) {
        showSuccessMessage(message: AppString.timerStartedSuccessfulMessage.tr);
        Get.find<TimeCounterController>().start();
        _refreshTimeline();
      }else {
        if (Get.find<TimeCounterController>().timer.isActive &&
            Get.find<TimeCounterController>().animationTimer.isActive) {
          Get.find<TimeCounterController>().stop();
          Get.find<TimeCounterController>().isRunningHorizontalLine(false);
        }
      }
    }

    if (timerType == StartOrEndTimer.end.name) {
      isEndTimerLoading(false);
    } else {
      isStartTimerLoading(false);
    }
    return true;
  }

  Future<bool?> createManualEntry() async {
    isManualEntryLoading(true);
    Duration timeDifference = DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
        .difference(DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));
    if (!timeDifference.isNegative) {
      bool? response = await _timelineDataSource.createManualEntry(
          startDate: DateTime.parse(
                  "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}")
              .toUtc()
              .toString(),
          endDate: DateTime.parse(
                  "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
              .toUtc()
              .toString(),
          des: descriptionController.text,
          projectId: projectId.value,
          taskId: taskId.value,
          orgId: orgUserId.value.isEmpty
              ? GetStorage().read(AppString.ORGANIZATION_USER_ID)
              : orgUserId.value,
          status: status.value);
      if (response) {
        showSuccessMessage(message: "Time entry created successfully");
        taskId.value = "";
        taskName.value = '';
        projectId.value = '';
        orgUserId.value = '';
        status.value = '';
        descriptionController.clear();
        Get.off(() => const MainScreen(routeIndex: 0));
        _refreshTimeline();
      }
    } else {
      showWarningMessage(message: "Provide a valid project/task ");
    }
    isManualEntryLoading(false);
    return null;
  }

  Future<bool?> updateTimelineLogDetails() async {
    isUpdateTimeLogLoading(true);
    bool? response = await _timelineDataSource.updateTimelineLogDetails(
        startDate: "${DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}").toUtc()}",
        endDate: "${DateTime.parse("${Get.find<DateTimePickerController>().outDate.value} ${Get.find<DateTimePickerController>().outTime.value}").toUtc()}",
        des: descriptionController.text,
        projectId: projectId.value,
        taskId: taskId.value,
        timelineId: timeLineId.value,
        status: status.value);
    if (response) {
      showSuccessMessage(message: "Time entry update successfully");
      taskId.value = "";
      taskName.value = '';
      projectId.value = '';
      timeLineId.value = '';
      orgUserId.value = '';
      status.value = '';
      descriptionController.clear();
      Get.off(() => const MainScreen(routeIndex: 0));
      _refreshTimeline();
    }

    isUpdateTimeLogLoading(false);
    return null;
  }

  getTimelineSummaryByDate(
      {String? startDate, String? endDate, String? orgId}) async {
    isTimelineSummaryByDateLoading(true);
    final String formattedStartDate = startDate ?? DateTime.now().toString();
    final String formattedEndDate = endDate ?? DateTime.now().toString();
    final String organizationId =
        orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);
    log("getTimelineSummaryByDate start & end ==>$startDate And $endDate");
    timelineSummaryByDate = await _timelineDataSource.getTimelineSummaryByDate(
        startDate: formattedStartDate,
        endDate: formattedEndDate,
        orgUserId: organizationId);
    isTimelineSummaryByDateLoading(false);
  }

  Future<bool?> removeTimelineEntry({String? timeLogId}) async {
    String? id = timeLogId ??
        Get.find<TimelineGlobalController>()
            .startOrEndTimerResponse
            ?.startOrStopTimer
            ?.id ??
        "";
    isTimelogEntryOrRemoveLoading(true);
    bool response =
        await _timelineDataSource.removeTimelineEntry(timeLogId: id.toString());
    if (response) {
      _updateRouteWithTimeEntry();
    }
    isTimelogEntryOrRemoveLoading(false);
    return null;
  }

  void _updateRouteWithTimeEntry() {
    showSuccessMessage(message: AppString.timerRemovedSuccessfulMessage.tr);
    Get.off(() => const MainScreen(routeIndex: 0));
    TimelineGlobalController controller = Get.find<TimelineGlobalController>();
    _refreshTimeline();
    controller.taskId.value = "";
    controller.taskName.value = "";
    controller.projectColor.value = "";

    Get.find<TimeCounterController>().isTotalCount(true);
    descriptionController.clear();
    Get.find<TimeCounterController>().reset();
    isTimelogEntryOrRemoveLoading(false);
  }

  /// Formats the date string to UTC format. Defaults to the current date and time if [date] is null.
  String _formatDate(String? date) {
    return "${DateTime.parse(date ?? DateTime.now().toString()).toUtc()}";
  }


  @override
  void onInit() {
    if(Get.find<UserInfoController>().userRole != UserEnum.employee){
      isEmployee(false);
    }else{
      isEmployee(true);
    }
    super.onInit();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }


}


_refreshTimeline() async {
  if (Get.find<TimelineGlobalController>().isEmployee.isTrue) {
    EmployeeTimelineController controller = Get.find<EmployeeTimelineController>();
    Get.find<TimelineGlobalController>().taskId.value = "";
    await controller.getTimelineCalenderByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");

    await Get.find<TimelineGlobalController>().getTimelineSummaryByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");
  } else {
    HrTimelineController controller = Get.find<HrTimelineController>();
    Get.find<TimelineGlobalController>().taskId.value = "";
    await controller.getTimelineCalenderByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");

    await Get.find<TimelineGlobalController>().getTimelineSummaryByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");
  }
}
