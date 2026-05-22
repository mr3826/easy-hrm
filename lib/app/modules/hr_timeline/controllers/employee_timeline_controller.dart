import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/domain/files_model.dart';
import 'package:payrun_mobile/modules/dashboard/domain/upcomming_leave_dashboard.dart';
import 'package:payrun_mobile/modules/timeline/model/start_or_end_timer_response.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/timeline_summary_by_date.dart';
import 'package:payrun_mobile/modules/timeline/model/timer_entry_response.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import '../../../../common/domain/last_input_model.dart';
import '../models/calendar_timeline.dart';
import '../repositories/timeline_data_source.dart';
import 'global_timline_controller.dart';

class EmployeeTimelineController extends GetxController with StateMixin {
  final TimelineDataSource _timelineDataSource;
  EmployeeTimelineController(this._timelineDataSource);
  final isTimelineCalendarByDateLoading = false.obs;
  late Timer updateDataTime;
  RxBool isTimelineSummaryLoading = false.obs;
  CalendarTimeline calendarTimeline = CalendarTimeline();

  List<CalendarEventData<String>>? timelogList = <CalendarEventData<String>>[];
  final isTimelogEntryOrRemoveLoading = false.obs;
  StartOrEndTimerResponse? startOrEndTimerResponse;
  TimerEntryResponse? timerEntryResponse;
  TimelineSummaryByDate? timelineSummaryByDate;
  TimelineSummaryByMonth? timelineSummaryByMonth;

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

  getTimelineCalenderByDate({String? startDate, String? endDate}) async {
    isTimelineCalendarByDateLoading(true);

    final String formattedStartDate = startDate ?? DateTime.now().toString();
    final String formattedEndDate = endDate ?? DateTime.now().toString();


    log("getTimelineCalenderByDate_employee ==>$startDate And $endDate");
    calendarTimeline = await _timelineDataSource.getTimelineCalender(
            startDate: formattedStartDate,
            endDate: formattedEndDate) ??
        CalendarTimeline();

    if (timelogList?.isNotEmpty ?? false) {
      for (var value in timelogList!) {
        CalendarControllerProvider.of(Get.context!).controller.remove(value);
      }
    }
    timelogList?.clear();
    timelogList =
        calendarTimeline.getCalenderTimelinesForApp?.data?.timelines?.map((e) {
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
    isTimelineSummaryLoading(true);
    final response = await NetworkClient()
        .graphRequest(queryString: getTimelineSummaryByDateQuery, variables: {
      "queryData": {
        "start_date": startDate,
        "end_date": endDate,
      }
    });
    if (response.hasException) {
    } else {
      timelineSummaryByMonth = TimelineSummaryByMonth.fromJson(response.data!);
    }
    isTimelineSummaryLoading(false);
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

  _refreshTimeline() async {
    TimelineGlobalController controller = Get.find<TimelineGlobalController>();
    String startDate = controller.selectedTimeLineStartDate.value;
    String endDte = controller.selectedTimeLineEndDate.value;

    ///Exiting  user (default user)
    _defaultTimelineUpdate(startDate, endDte);
  }

  void _defaultTimelineUpdate(String startDate, String endDte) async {
    await getTimelineSummaryByMonth(
        startDate:
        "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
        "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");
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
