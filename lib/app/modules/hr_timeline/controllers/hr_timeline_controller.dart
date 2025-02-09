import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/bindings/timeline_global_bindings.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/timelog_summary_controller.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/domain/files_model.dart';
import 'package:payrun_mobile/modules/dashboard/domain/upcomming_leave_dashboard.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/project_dropdown_response.dart';
import 'package:payrun_mobile/modules/timeline/model/timer_entry_response.dart';
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

  final isTimelineCalendarByDateLoading = false.obs;
  final isTimelineSummaryByDateLoading = false.obs;
  final isTimeEntryLoading = false.obs;
  final isTimeEntryUpdateLoading = false.obs;
  String orgUserId = "";
  late Timer updateDataTime;

  TextEditingController descriptionController = TextEditingController();
  CalendarTimeline calendarTimeline = CalendarTimeline();

  List<CalendarEventData<String>>? timelogList = <CalendarEventData<String>>[];
  final isTimelogEntryOrRemoveLoading = false.obs;
  TimerEntryResponse? timerEntryResponse;
  ProjectDropDownResponse? projectDropDownResponse;
  TimeLogsEntriesDetails? timeLogsEntriesDetails;
  UpdateTimelogEntry? updateTimelogEntry;

  @override
  void onInit() {

    TimelineGlobalBindings().dependencies();
    _refreshTimeline();


    if (!Get.isRegistered<DateTimeController>()) {
      Get.put(DateTimeController());
    }
    updateDataTime = Timer(Duration.zero, () {});
    updateDataAfterTwoMinutes();
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



  Future<bool?> removeTimelineEntryDetails({String? timeLogId, String? orgId,String? startDate,String ?endDate}) async {
    isTimelogEntryOrRemoveLoading(true);
    bool response = await _timelineDataSource.removeTimelineEntry(
        timeLogId: timeLogId.toString(), orgId: orgId);
    if (response) {
      Get.back(canPop: false);
      //   _updateRouteWithTimeEntry();
      Get.find<TimelineSummaryController>()
          .getTimelineSummaryByDate(orgId: orgId);
      Get.find<TimelineSummaryController>()
          .getTimelogDetailsByMonth(orgId: orgId);

      getTimeEntryDetails(startDate: startDate.toString(),endDate: endDate.toString());
    }
    isTimelogEntryOrRemoveLoading(false);
    return null;
  }






  Future<TimeLogsEntriesDetails?> updateTimeLogEntryById(
      {String? status, String? timelineId}) async {
    String? entryStatus = Get.find<TimelineGlobalController>().status.value.isEmpty ? status : Get.find<TimelineGlobalController>().status.value;
    String? entryTimeLineId = Get.find<TimelineGlobalController>().timeLineId.value.isEmpty ? timelineId : Get.find<TimelineGlobalController>().timeLineId.value;
    isTimeEntryUpdateLoading(true);
    updateTimelogEntry = await _timelineDataSource.updateTimeLogEntryById(status: entryStatus.toString(), timelineId: entryTimeLineId.toString());
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

  getTimelineCalenderByDate({String? startDate, String? endDate, String? orgId}) async {
    isTimelineCalendarByDateLoading(true);

    final String formattedStartDate = startDate ?? DateTime.now().toString();

    final String formattedEndDate = endDate ?? DateTime.now().toString();

    final String organizationId = orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);

    log("getTimelineCalenderByDate start & end ==>$startDate And $endDate org : $organizationId");

    calendarTimeline = await _timelineDataSource.getTimelineCalender(startDate: formattedStartDate, endDate: formattedEndDate, orgUserId: organizationId) ?? CalendarTimeline();
    if (timelogList?.isNotEmpty ?? false) {
      for (var value in timelogList!) {
        CalendarControllerProvider.of(Get.context!).controller.remove(value);
      }
    }

    timelogList?.clear();
    timelogList = calendarTimeline.getCalenderTimelinesForApp?.data?.timelines?.map((e) {
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


  DateTime _createEndDateForTimeLine({required String startDate, String? endDate}) {
    if (endDate != null) {
      int diffInMins = DateTime.parse(endDate)
          .difference(DateTime.parse(startDate))
          .inMinutes;
      if (!diffInMins.isNegative) {
        if (diffInMins <= 10) {
          return DateTime.parse("2024-01-24 ${DateTime.parse(endDate).add(const Duration(minutes: 10)).toString().substring(11, 19)}");
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
    TimelineGlobalController controller=Get.find<TimelineGlobalController>();
    String startDate=controller.selectedTimeLineStartDate.value;
    String endDte=controller.selectedTimeLineEndDate.value;

    ///short time log summary
    await controller. getTimelineSummaryByDate();

    if( Get.find<TimelineGlobalController>().searchEmployeeId.isNotEmpty){
      ///when employee user id not empty
      _updatedSelectedEmployee(startDate,endDte);
    }else{
      ///Exiting  user (default user)
      _defaultTimelineUpdate(startDate,endDte);
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

  void _updatedSelectedEmployee(String startDate,String endDte) async{
    await getTimelineCalenderByDate(
    orgId: Get.find<TimelineGlobalController>().searchEmployeeId,
    startDate:
    "${DateTime(DateTime.parse(startDate).year, DateTime.parse(startDate).month, DateTime.parse(startDate).day, 0, 0, 0)}",
    endDate:
    "${DateTime(DateTime.parse(endDte).year, DateTime.parse(endDte).month, DateTime.parse(endDte).day, 23, 59, 59)}"
    );

    await Get.find<TimelineGlobalController>().getTimelineSummaryByDate(
        orgId: Get.find<TimelineGlobalController>().searchEmployeeId,
        startDate:
        "${DateTime(DateTime.parse(startDate).year, DateTime.parse(startDate).month, DateTime.parse(startDate).day, 0, 0, 0)}",
        endDate:
        "${DateTime(DateTime.parse(endDte).year, DateTime.parse(endDte).month, DateTime.parse(endDte).day, 23, 59, 59)}");
  }

  void _defaultTimelineUpdate(String startDate, String endDte) async{
    await getTimelineCalenderByDate(
    startDate:
    "${DateTime(DateTime.parse(startDate).year, DateTime.parse(startDate).month, DateTime.parse(startDate).day, 0, 0, 0)}",
    endDate:
    "${DateTime(DateTime.parse(endDte).year, DateTime.parse(endDte).month, DateTime.parse(endDte).day, 23, 59, 59)}");


    await Get.find<TimelineGlobalController>().getTimelineSummaryByDate(
        startDate:
        "${DateTime(DateTime.parse(startDate).year, DateTime.parse(startDate).month, DateTime.parse(startDate).day, 0, 0, 0)}",
        endDate:
        "${DateTime(DateTime.parse(endDte).year, DateTime.parse(endDte).month, DateTime.parse(endDte).day, 23, 59, 59)}");
  }

}
