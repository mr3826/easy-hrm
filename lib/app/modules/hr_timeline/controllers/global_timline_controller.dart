import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../../common/widget/success_message.dart';
import '../../../../enum.dart';
import '../../../../modules/timeline/model/start_or_end_timer_response.dart';
import '../../../../modules/timeline/model/timer_entry_response.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/utils.dart';
import '../../../global/controller/timmer_controller.dart';
import '../../../home/view/screen/main_screen.dart';
import '../models/project_dropdown_response.dart';
import '../repositories/timeline_data_source.dart';

class TimelineGlobalController extends GetxController {
  final TimelineDataSource _timelineDataSource;
  TimelineGlobalController(this._timelineDataSource);

  final isProjectListLoading = false.obs;
  final isProistLoading = false.obs;
  final isStartAndEndTimerLoading = false.obs;
  final isEndTimerLoading = false.obs;
  final isTimelogEntryOrRemoveLoading = false.obs;
  String addTimeLogId = "";
  ProjectDropDownResponse? projectDropDownResponse;
  StartOrEndTimerResponse? startOrEndTimerResponse;

  Future<ProjectDropDownResponse?> getProjectList({String? searchText}) async {
    isProjectListLoading(true);
    projectDropDownResponse =
        await _timelineDataSource.getProjectList(searchText: searchText ?? "");

    isProjectListLoading(false);
    return null;
  }

  Future<bool> saveTimelineEntry({
     String? taskId,
    required String projectId,
  }) async {
    isProjectListLoading(true);
   bool? response=  await _timelineDataSource.saveTimelineEntry(
        des: descriptionController.text,
        startDate: _formatDate(startOrEndTimerResponse?.startOrStopTimer?.startDate),
        endDate: _formatDate(startOrEndTimerResponse?.startOrStopTimer?.endDate),
        taskId: taskId??"",
        projectId: projectId,
        timelineId: startOrEndTimerResponse?.startOrStopTimer?.id ?? "");

   if(response==true){
     showSuccessMessage(message: AppString.timerSavedSuccessfulMessage.tr);
   }

    isProjectListLoading(false);
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
      isStartAndEndTimerLoading(true);
    } else {
      isEndTimerLoading(true);
    }

    startOrEndTimerResponse =
        await _timelineDataSource.startOrEndTimer(timerTyp: timerType);
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
    if (timerType == StartOrEndTimer.start.name) {
      isStartAndEndTimerLoading(false);
    } else {
      isEndTimerLoading(false);
    }
    return true;
  }

  /// Formats the date string to UTC format. Defaults to the current date and time if [date] is null.
  String _formatDate(String? date) {
    return "${DateTime.parse(date ?? DateTime.now().toString()).toUtc()}";
  }
}

bool isEmployee = false;

_refreshTimeline() async {
  if (isEmployee == true) {
    HrTimelineController controller = Get.find<HrTimelineController>();
    controller.taskId.value = "";
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
    controller.taskId.value = "";
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
