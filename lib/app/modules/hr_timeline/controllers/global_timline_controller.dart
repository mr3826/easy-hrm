import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../../common/widget/success_message.dart';
import '../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../common/widget/warning_message.dart';
import '../../../../enum.dart';
import '../../../../modules/timeline/model/start_or_end_timer_response.dart';
import '../../../../utils/app_string.dart';
import '../../../global/controller/timmer_controller.dart';
import '../../../home/view/screen/main_screen.dart';
import '../models/project_dropdown_response.dart';
import '../repositories/timeline_data_source.dart';

class TimelineGlobalController extends GetxController {
  final TimelineDataSource _timelineDataSource;
  TimelineGlobalController(this._timelineDataSource);

  final isProjectListLoading = false.obs;
  final isProistLoading = false.obs;
  final isManualEntryLoading = false.obs;
  final isUpdateTimeLogLoading = false.obs;
  final isStartTimerLoading = false.obs;
  final isEndTimerLoading = false.obs;
  final isTimelogEntryOrRemoveLoading = false.obs;
  RxBool isValueChangeForTimeLogUpdate = false.obs;
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

    print('''
                            
                     
                            task_name: ${Get.find<TimelineGlobalController>().taskName.value}
                            projectId : ${ Get.find<TimelineGlobalController>().projectId.value}
                            task_id : ${ Get.find<TimelineGlobalController>().taskId.value}
                            task_color : ${ Get.find<TimelineGlobalController>().projectColor.value}
                            
                        
                        
                            ''');

    isProjectListLoading(false);
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

  removeTimelineEntry({String? timeLogId}) async {
    String? id = addTimeLogId.isNotEmpty ? addTimeLogId : timeLogId;
    isTimelogEntryOrRemoveLoading(true);
    bool response =
        await _timelineDataSource.removeTimelineEntry(timeLogId: id.toString());
    if (response) {
      showSuccessMessage(message: AppString.timerRemovedSuccessfulMessage.tr);
      Get.find<TimeCounterController>().isTotalCount(true);
      descriptionController.clear();
      Get.find<TimeCounterController>().reset();
      Get.off(() => const MainScreen(routeIndex: 0));
      isTimelogEntryOrRemoveLoading(false);
      _refreshTimeline();
      return true;
    }
    isTimelogEntryOrRemoveLoading(false);
  }

  Future<bool> startOrEndTimer({required String timerType}) async {
    if (timerType == StartOrEndTimer.end.name) {
      isEndTimerLoading(true);
    } else {
      isStartTimerLoading(true);
    }

    startOrEndTimerResponse = await _timelineDataSource.startOrEndTimer(timerTyp: timerType);

    print('''
    startOrEndTimer : =>
    type: $timerType
    start_date : ${
        startOrEndTimerResponse?.startOrStopTimer?.startDate
    }   end_date : ${
        startOrEndTimerResponse?.startOrStopTimer?.endDate
    }
    
    ''');
    if (startOrEndTimerResponse?.startOrStopTimer?.endDate == null) {
      showSuccessMessage(message: AppString.timerStartedSuccessfulMessage.tr);
      Get.find<TimeCounterController>().start();
      _refreshTimeline();
    } else {
      if (Get.find<TimeCounterController>().timer.isActive &&
          Get.find<TimeCounterController>().animationTimer.isActive) {
        Get.find<TimeCounterController>().stop();
        Get.find<TimeCounterController>().isRunningHorizontalLine(false);
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
    Duration timeDifference = DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
        .difference(DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));
    if (!timeDifference.isNegative) {
      bool? response = await _timelineDataSource.createManualEntry(startDate: DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}").toUtc().toString(),
          endDate: DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}").toUtc().toString(),
          des: descriptionController.text,
          projectId: projectId.value,
          taskId: taskId.value,
          orgId: orgUserId.value,
          status:status.value
      );
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
      startDate:
          "${DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}").toUtc()}",
      endDate:
          "${DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}").toUtc()}",
      des: descriptionController.text,
      projectId: projectId.toString(),
      taskId: taskId.toString(),
      timelineId: timeLineId.toString(),
    );
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

  /// Formats the date string to UTC format. Defaults to the current date and time if [date] is null.
  String _formatDate(String? date) {
    return "${DateTime.parse(date ?? DateTime.now().toString()).toUtc()}";
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}

bool isEmployee = false;

_refreshTimeline() async {
  if (isEmployee == true) {
    HrTimelineController controller = Get.find<HrTimelineController>();
    Get.find<TimelineGlobalController>().taskId.value = "";
    await controller.getTimelineSummaryByMonth(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");

    await controller.getTimelineSummaryByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");
  } else {
    HrTimelineController controller = Get.find<HrTimelineController>();
    Get.find<TimelineGlobalController>().taskId.value = "";
    await controller.getTimelineSummaryByMonth(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");

    await controller.getTimelineSummaryByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");
  }
}
