import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/domain/files_model.dart';
import 'package:payrun_mobile/modules/dashboard/domain/upcomming_leave_dashboard.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/project_dropdown_response.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/timeline_summary_by_date.dart';
import 'package:payrun_mobile/modules/timeline/model/timer_entry_response.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../common/domain/last_input_model.dart';
import '../models/calendar_timeline.dart';
import '../models/timelog_entries_details.dart';
import '../models/update_timelog_entry.dart';
import '../repositories/timeline_data_source.dart';
import 'global_timline_controller.dart';

class HrTimelineController extends GetxController with StateMixin {
  final TimelineDataSource _timelineDataSource;
  HrTimelineController(this._timelineDataSource);
  final isLoading = false.obs;
  final isProjectListLoading = false.obs;
  final isManualEntryLoading = false.obs;
  final isTimelineCalendarByDateLoading = false.obs;
  final isTimelineSummaryByDateLoading = false.obs;
  final isUpdateTimeLogLoading = false.obs;
  final isTimeEntryLoading = false.obs;
  final isTimeEntryUpdateLoading = false.obs;
  RxString selectedSummaryDate = "".obs;
  String orgUserId = "";
  RxInt selectedYearIndex = 10.obs;
  late Timer updateDataTime;

  TextEditingController descriptionController = TextEditingController();
  CalendarTimeline calendarTimeline = CalendarTimeline();

  List<CalendarEventData<String>>? timelogList = <CalendarEventData<String>>[];
  final isTimelogEntryOrRemoveLoading = false.obs;
  TimerEntryResponse? timerEntryResponse;
  ProjectDropDownResponse? projectDropDownResponse;
  TimelineSummaryByMonth? timelineSummaryByMonth;
  TimeLogsEntriesDetails? timeLogsEntriesDetails;
  UpdateTimelogEntry? updateTimelogEntry;

  @override
  void onInit() {
    if (!Get.isRegistered<DateTimeController>()) {
      Get.put(DateTimeController());
    }
    updateDataTime = Timer(Duration.zero, () {});
    updateDataAfterTwoMinutes();

    _refreshTimeline();

    super.onInit();
  }

  Future<TimeLogsEntriesDetails?> getTimeEntryDetails(
      {required String startDate,
      required String endDate,
      String? orgUserId}) async {
    isTimeEntryLoading(true);
    final String organizationId =
        orgUserId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);
    timeLogsEntriesDetails = await _timelineDataSource.getTimeLogEntries(
      startDate: startDate,
      endDate: endDate,
      orgUserId: organizationId,
    );
    isTimeEntryLoading(false);
    return null;
  }

  Future<TimeLogsEntriesDetails?> updateTimeLogEntryById(
      {String? status, String? timelineId}) async {
    String? entryStatus =
        Get.find<TimelineGlobalController>().status.value.isEmpty
            ? status
            : Get.find<TimelineGlobalController>().status.value;
    String? entryTimeLineId =
        Get.find<TimelineGlobalController>().timeLineId.value.isEmpty
            ? timelineId
            : Get.find<TimelineGlobalController>().timeLineId.value;
    isTimeEntryUpdateLoading(true);
    updateTimelogEntry = await _timelineDataSource.updateTimeLogEntryById(
        status: entryStatus.toString(), timelineId: entryTimeLineId.toString());

    if (updateTimelogEntry != null) {

      DateTime requestedDate = DateTime.parse(updateTimelogEntry?.updateTimelineEntry?.startDate ?? DateTime.now().toString());

      Get.find<HrTimelineController>().getTimeEntryDetails(
          startDate:
              "${DateTime(requestedDate.year, requestedDate.month, requestedDate.day, 0, 0, 0)}",
          endDate:
              "${DateTime(requestedDate.year, requestedDate.month, requestedDate.day, 23, 59, 59)}",
          orgUserId: updateTimelogEntry?.updateTimelineEntry?.orgUserId ?? "");
      refreshTimeline();
    }

    isTimeEntryUpdateLoading(false);
    return null;
  }

  getTimelineCalenderByDate(
      {String? startDate, String? endDate, String? orgId}) async {
    isTimelineCalendarByDateLoading(true);
    final String formattedStartDate = startDate ?? DateTime.now().toString();
    final String formattedEndDate = endDate ?? DateTime.now().toString();
    final String organizationId =
        orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);
    log("getTimelineCalenderByDate start & end ==>$startDate And $endDate org : $organizationId");
    calendarTimeline = await _timelineDataSource.getTimelineCalender(
            startDate: formattedStartDate,
            endDate: formattedEndDate,
            orgUserId: organizationId) ??
        CalendarTimeline();

    if (timelogList?.isNotEmpty ?? false) {
      for (var value in timelogList!) {
        CalendarControllerProvider.of(Get.context!).controller.remove(value);
      }
    }
    timelogList?.clear();
    timelogList =
        calendarTimeline.getCalenderTimelinesForApp?.data?.timelines?.map((e) {

          print(''''
          total_min ${e.totalMinutes}
      
          
          ''');
      ModelForDescription modelForDescription = ModelForDescription(
          status: e.status ?? "",
          description: e.description ?? "",
          timeLId: e.id ?? "",
          endDate: e.endDate ?? "",
          duration: e.totalMinutes ?? "",
          startDate: e.startDate ?? "",
          taskName: e.task?.name ?? "",
          taskId: e.task?.id ?? "",
          projectId: e.project?.id ?? "",
          projectName: e.project?.name ?? "",
          projectColor: e.project?.color ?? "");

      Map<String, dynamic> jsonModel = modelForDescription.toJson();
      String objData = jsonEncode(jsonModel);

      return CalendarEventData(
          date: DateTime.parse("2024-01-24"),
          startTime: e.startDate != null
              ? DateTime.parse("2024-01-24 ${e.startDate?.substring(11, 19)}")
              : DateTime.parse(
                  "2024-01-24 ${DateTime.now().toString().substring(11, 19)}"),
          endTime: _createEndDateForTimeLine(
              startDate: e.startDate ?? DateTime.now().toString(),
              endDate: e.endDate),
          event: "",
          title: '',
          description: objData);
    }).toList();
    timelogList?.addAll(calendarTimeline
            .getCalenderTimelinesForApp?.data?.leaves
            ?.map((e) {
          /// add files info
          ModelForDescription modelForDescription = ModelForDescription(
              status: e.status ?? "",
              description: e.description ?? "",
              endDate: e.endDate ?? "",
              startDate: e.startDate ?? "",
              duration: e.totalLeaveMinutes ?? "",
              numberOfDays: e.numberOfDays ?? 0,
              createdAt: e.createdAt ?? "",
              leaveId: e.id ?? "",
              leaveDetails: [
                e.leaveDetails != null && e.leaveDetails!.isNotEmpty
                    ? LeaveDetails(
                        scheduleSecond: int.parse(
                            e.leaveDetails?[0].scheduleSecond.toString() ?? ""),
                        leaveSecond: int.parse(
                            e.leaveDetails?[0].leaveSecond.toString() ?? ""),
                      )
                    : LeaveDetails()
              ],
              taskName: e.leaveType?.leaveName ?? "",
              files: [
                (e.files != null && e.files!.isNotEmpty)
                    ? Files(
                        name: e.files?[0].name ?? "",
                        id: e.files?[0].id ?? "",
                        key: e.files?[0].key ?? "",
                        size: e.files?[0].size ?? "",
                        createdAt: e.files?[0].createdAt ?? "",
                      )
                    : Files()
              ],
              leaveType: LeaveType(
                  type: e.leaveType?.type ?? "",
                  isAddNoteRequired: e.leaveType?.isAddNoteRequired ?? false,
                  isAttachDocumentRequired:
                      e.leaveType?.isAttachDocumentRequired ?? false,
                  leaveId: e.leaveType?.leaveId ?? "",
                  leaveName: e.leaveType?.leaveName ?? ""));

          Map<String, dynamic> jsonModel = modelForDescription.toJson();

          String objData = jsonEncode(jsonModel);
          return CalendarEventData(
            date: DateTime.parse("2024-01-24"),
            startTime: e.startDate != null
                ? DateTime.parse("2024-01-24 ${e.startDate?.substring(11, 19)}")
                : DateTime.parse(
                    "2024-01-24 ${DateTime.now().toString().substring(11, 19)}"),
            endTime: _createEndDateForTimeLine(
                startDate: e.startDate ?? DateTime.now().toString(),
                endDate: e.endDate),
            event: "",
            title: '',
            description: objData,
          );
        }).toList() ??
        []);

    CalendarControllerProvider.of(Get.context!)
        .controller
        .addAll(timelogList ?? []);

    if (updateDataTime.isActive) {
      updateDataTime.cancel();
    }
    updateDataAfterTwoMinutes();

    isTimelineCalendarByDateLoading(false);
  }

  getTimelineSummaryByMonth(
      {required String startDate, required String endDate}) async {
    print(
        "getTimelineSummaryByMonth_timeline ::: start_date $startDate end_date $endDate");

    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .graphRequest(queryString: getTimelineSummaryByDateQuery, variables: {
      "queryData": {
        "start_date": startDate,
        "end_date": endDate,
      }
    });
    if (response.hasException) {
      log("getTimelineByMonth:: ${response.exception.toString()}");
    } else {
      timelineSummaryByMonth = TimelineSummaryByMonth.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  DateTime _createEndDateForTimeLine(
      {required String startDate, String? endDate}) {
    if (endDate != null) {
      int diffInMins = DateTime.parse(endDate)
          .difference(DateTime.parse(startDate))
          .inMinutes;
      if (!diffInMins.isNegative) {
        if (diffInMins <= 10) {
          return DateTime.parse(
              "2024-01-24 ${DateTime.parse(endDate).add(const Duration(minutes: 10)).toString().substring(11, 19)}");
        } else {
          return DateTime.parse("2024-01-24 ${endDate.substring(11, 19)}");
        }
      } else {
        return DateTime.parse("2024-01-24 ${endDate.substring(11, 19)}");
      }
    } else {
      int diffInMins =
          DateTime.now().difference(DateTime.parse(startDate)).inMinutes;
      if (diffInMins > 10) {
        return DateTime.parse(
            "2024-01-24 ${DateTime.now().toString().substring(11, 19)}");
      } else {
        return DateTime.parse(
            "2024-01-24 ${DateTime.now().add(const Duration(minutes: 10)).toString().substring(11, 19)}");
      }
    }
  }

  _refreshTimeline() async {
    await getTimelineSummaryByMonth(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");

    if( Get.find<TimelineGlobalController>().searchEmployeeId.isNotEmpty){
      await getTimelineCalenderByDate(
        orgId: Get.find<TimelineGlobalController>().searchEmployeeId,
          startDate:
          "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
          endDate:
          "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");

      await Get.find<TimelineGlobalController>().getTimelineSummaryByDate(
          orgId: Get.find<TimelineGlobalController>().searchEmployeeId,

          startDate:
          "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
          endDate:
          "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");
    }else{
      await getTimelineCalenderByDate(
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

  void updateDataAfterTwoMinutes() {
    updateDataTime = Timer.periodic(const Duration(minutes: 2), (timer) {
      if (timelogList != null && timelogList!.isNotEmpty) {
        for (var value in timelogList!) {
          CalendarControllerProvider.of(Get.context!).controller.remove(value);
        }
      }

      timelogList = calendarTimeline.getCalenderTimelinesForApp?.data?.timelines
          ?.map((e) {
        ModelForDescription modelForDescription = ModelForDescription(
            status: e.status ?? "",
            description: e.description ?? "",
            timeLId: e.id ?? "",
            endDate: e.endDate ?? "",
            duration: e.totalMinutes ?? "",
            startDate: e.startDate ?? "",
            taskName: e.task?.name ?? "",
            taskId: e.task?.id ?? "",
            projectId: e.project?.id ?? "",
            projectName: e.project?.name ?? "",
            projectColor: e.project?.color ?? "");

        Map<String, dynamic> jsonModel = modelForDescription.toJson();
        String objData = jsonEncode(jsonModel);

        return CalendarEventData(
            date: DateTime.parse("2024-01-24"),
            startTime: e.startDate != null
                ? DateTime.parse("2024-01-24 ${e.startDate?.substring(11, 19)}")
                : DateTime.parse(
                    "2024-01-24 ${DateTime.now().toString().substring(11, 19)}"),
            endTime: _createEndDateForTimeLine(
                startDate: e.startDate ?? DateTime.now().toString(),
                endDate: e.endDate),
            event: "",
            title: '',
            description: objData);
      }).toList();

      timelogList?.addAll(
          calendarTimeline.getCalenderTimelinesForApp?.data?.leaves?.map((e) {
                //todo
                /// add files info
                ModelForDescription modelForDescription = ModelForDescription(
                    status: e.status ?? "",
                    description: e.description ?? "",
                    endDate: e.endDate ?? "",
                    startDate: e.startDate ?? "",
                    duration: e.totalLeaveMinutes ?? "",
                    numberOfDays: e.numberOfDays ?? 0,
                    createdAt: e.createdAt ?? "",
                    leaveId: e.id ?? "",
                    taskName: e.leaveType?.leaveName ?? "",
                    files: [
                      (e.files != null && e.files!.isNotEmpty)
                          ? Files(
                              name: e.files?[0].name ?? "",
                              id: e.files?[0].id ?? "",
                              key: e.files?[0].key ?? "",
                              size: e.files?[0].size ?? "",
                              createdAt: e.files?[0].createdAt ?? "",
                            )
                          : Files()
                    ],
                    leaveType: LeaveType(
                        type: e.leaveType?.type ?? "",
                        isAddNoteRequired:
                            e.leaveType?.isAddNoteRequired ?? false,
                        isAttachDocumentRequired:
                            e.leaveType?.isAttachDocumentRequired ?? false,
                        leaveId: e.leaveType?.leaveId ?? "",
                        leaveName: e.leaveType?.leaveName ?? ""));

                Map<String, dynamic> jsonModel = modelForDescription.toJson();

                String objData = jsonEncode(jsonModel);
                return CalendarEventData(
                  date: DateTime.parse("2024-01-24"),
                  startTime: e.startDate != null
                      ? DateTime.parse(
                          "2024-01-24 ${e.startDate?.substring(11, 19)}")
                      : DateTime.parse(
                          "2024-01-24 ${DateTime.now().toString().substring(11, 19)}"),
                  endTime: _createEndDateForTimeLine(
                      startDate: e.startDate ?? DateTime.now().toString(),
                      endDate: e.endDate),
                  event: "",
                  title: '',
                  description: objData,
                );
              }).toList() ??
              []);

      CalendarControllerProvider.of(Get.context!)
          .controller
          .addAll(timelogList ?? []);
    });
  }

  @override
  void disposeId(Object id) {
    descriptionController.dispose();
    super.disposeId(id);
  }
}
