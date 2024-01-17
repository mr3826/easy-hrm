import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/timeline/controller/sf_calendar.dart';
import 'package:payrun_mobile/modules/timeline/controller/timer_controller.dart';
import 'package:payrun_mobile/modules/timeline/model/project_dropdown_response.dart';
import 'package:payrun_mobile/modules/timeline/model/start_or_end_timer_response.dart';
import 'package:payrun_mobile/modules/timeline/model/timeline_summary_by_date.dart';
import 'package:payrun_mobile/modules/timeline/model/timer_entry_response.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../common/domain/last_input_model.dart';
import '../../../network/exception_helper.dart';
import '../model/calendar_timeline.dart';
import '../model/create_time_entry.dart';

class TimelineController extends GetxController with StateMixin {
  Timer? _timer;

  @override
  void onInit() {
    getProjectDropdown();

    //monthly summary
    //by default its current month

    getTimelineSummaryByMonth(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");

    getCalendarTimelineDataByDate(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 2, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 2, 23, 59, 59)}");

    // _timer = Timer.periodic(const Duration(minutes: 2), (timer) {
    //   getCalendarTimelineDataByDate(
    //       startDate:
    //           "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0)}",
    //       endDate:
    //           "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59)}");

    // log("GetCalendarTimelineDataByDate Call after 2 minute", error: 0);
    // });

    super.onInit();
  }

  final isLoading = false.obs;
  final isManualEntryLoading = false.obs;
  final isTimelineCalendarByDateLoading = false.obs;
  final isTimelineSummaryByDateLoading = false.obs;
  final isUpdateTimeLogLoading = false.obs;
  final taskName = "".obs;
  final isTimeInvalid = false.obs;
  final taskId = "".obs;
  String timeLogStatus = "";
  String timeLogDuration = "";
  String timeLineID = "";
  Color timeLogColor = AppColor.primaryColor;

  RxList<CalendarEventData<String>> eventsOfTask =
      <CalendarEventData<String>>[].obs;

  RxList<CalendarEventData<String>> eventOfLeave =
      <CalendarEventData<String>>[].obs;

  List<Meeting> meetings = <Meeting>[];

  StartOrEndTimerResponse? startOrEndTimerResponse;
  TimerEntryResponse? timerEntryResponse;
  ProjectDropDownResponse? projectDropDownResponse;
  TimelineSummaryByDate? timelineSummaryByDate;
  CalendarTimeline? calendarTimeline;
  TimelineSummaryByMonth? timelineSummaryByMonth;

  startOrEndTimer({required String timerType}) async {
    final response =
        await NetworkClient().mutationGraphData(startOrEndTimerQueryData, {
      "inputData": {"timer_type": timerType}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      startOrEndTimerResponse =
          StartOrEndTimerResponse.fromJson(response.data!);
      if (startOrEndTimerResponse?.startOrStopTimer?.endDate == null) {
        showSuccessMessage(message: AppString.timerStartedSuccessfulMessage);
        Get.find<TimeCounterController>().start();
      } else {
        if (Get.find<TimeCounterController>().timer.isActive) {
          Get.find<TimeCounterController>().stop();
        }
      }
    }
  }

  saveTimeEntry() async {
    final response =
        await NetworkClient().mutationGraphData(saveTimerQueryData, {
      "inputData": {
        "description": descriptionController.text,
        "end_date": startOrEndTimerResponse?.startOrStopTimer?.endDate ?? "",
        "start_date":
            startOrEndTimerResponse?.startOrStopTimer?.startDate ?? "",
        "status": "pending",
        "task_id": taskId.value,
        "timeline_id": startOrEndTimerResponse?.startOrStopTimer?.id ?? ""
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      timerEntryResponse = TimerEntryResponse.fromJson(response.data!);
      print(timerEntryResponse?.updateTimelineEntry?.startDate);
      taskId.value = "";
      Get.find<TimeCounterController>().isTotalCount(true);
      descriptionController.clear();
      Get.find<TimeCounterController>().reset();
      Get.back(canPop: false);
    }
  }

  updateTimelineLogDetails(
      {timeLineId,
      description,
      endDate,
      startDate,
      status,
      taskId,
      projectId}) async {
    isUpdateTimeLogLoading(true);
    log("updateTimelineLogDetails start & end ==>$startDate And $endDate");

    final response = await NetworkClient()
        .mutationGraphData(updateTimelineLogDetailsQueryData, {
      "inputData": {
        "timeline_id": "$timeLineId",
        "description": "$description",
        "end_date": "$endDate",
        "start_date": "$startDate",
        "status": "$status",
      }
    });

    log(response.toString(), error: 0);

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      getCalendarTimelineDataByDate(
          startDate:
              "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0)}",
          endDate:
              "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59)}");

      getTimelineSummaryByMonth(
          startDate:
              "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
          endDate:
              "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");
      Get.back();
    }
    isUpdateTimeLogLoading(false);
  }

  getProjectDropdown() async {
    isLoading(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: getProjectDropdownQuery, variables: {
      "queryData": {"searchText": taskSearchController.text},
      "optionData": {"limit": 200}
    });

    if (response.hasException) {
      log("getProjectDropdown", error: response.exception.toString());
    } else {
      projectDropDownResponse =
          ProjectDropDownResponse.fromJson(response.data!);
    }
    isLoading(false);
  }

  createManualEntry() async {
    isManualEntryLoading(true);
    Duration timeDifference =
        DateTime.parse(Get.find<DateTimeController>().requestedOutDate.value)
            .difference(DateTime.parse(
                Get.find<DateTimeController>().requestedInDate.value));
    if (!timeDifference.isNegative) {
      isTimeInvalid(false);
      print(taskId.value);
      if (taskId.isNotEmpty) {
        final response =
            await NetworkClient().mutationGraphData(createNewEntryQuery, {
          "inputData": {
            "end_date": Get.find<DateTimeController>()
                .requestedOutDate
                .value
                .replaceAll(" ", "T"),
            "description": descriptionController.text,
            "start_date": Get.find<DateTimeController>()
                .requestedInDate
                .value
                .replaceAll(" ", "T"),
            "status": "pending",
            "task_id": taskId.value
          }
        });
        if (response.hasException) {
          log(response.exception.toString());
        } else {
          print(CreateTimelineEntryResponse.fromJson(response.data!)
              .createTimelineEntry
              ?.id);
          taskId.value = "";
          descriptionController.clear();
          Get.back(canPop: false);
        }
      }
    } else {
      isTimeInvalid(true);
    }
    isManualEntryLoading(false);
  }

  getTimelineSummaryByMonth(
      {required String? startDate, required String? endDate}) async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: getTimelineSummaryByDateQuery, variables: {
      "queryData": {
        "start_time": startDate,
        "end_time": endDate,
      }
    });
    if (response.hasException) {
      log("getTimelineByMonth:: ${response.exception.toString()}");
    } else {
      timelineSummaryByMonth = TimelineSummaryByMonth.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }


  getTimelineSummaryByDate(
      {required String? startDate, String? endDate}) async {
    isTimelineSummaryByDateLoading(true);
    log("getTimelineSummaryByDate start & end ==>$startDate And $endDate");

    final response = await NetworkClient()
        .getGraphQuery(queryString: getTimelineSummaryByDateQuery, variables: {
      "queryData": {
        "start_time": "$startDate",
        "end_time": "$endDate",
        "is_calender_summary": true
      }
    });
    log("getTimelineSummaryByDate ==> $response");
    if (response.hasException) {
      log("getTimelineByDate:: ${response.exception.toString()}");
    } else {
      timelineSummaryByDate = TimelineSummaryByDate.fromJson(response.data!);
      log("balance time ==> ${TimelineSummaryByDate.fromJson(response.data!).getTimelogSummaryForApp?.balanced}");
    }
    isTimelineSummaryByDateLoading(false);
  }


  getCalendarTimelineDataByDate(
      {required String? startDate, String? endDate}) async {
    log("getCalendarTimelineDataByDate start & end ==>$startDate And $endDate");

    isTimelineCalendarByDateLoading(true);

    final responseForCalendar = await NetworkClient()
        .getGraphQuery(queryString: getCalendarTimelineQuery, variables: {
      "queryData": {"start_time": "$startDate", "end_time": "$endDate"}
    });

    if (responseForCalendar.hasException) {
      ExceptionHelper.errorHandler(exception: responseForCalendar.exception!);
      isTimelineCalendarByDateLoading(false);
    } else {
      calendarTimeline = CalendarTimeline.fromJson(responseForCalendar.data!);
      print(  calendarTimeline?.getCalenderTimelinesForApp?.timelines?.length);

      calendarTimeline?.getCalenderTimelinesForApp?.timelines?.map((e) {
        return meetings.add(
          Meeting(
            e.startDate.toString(),
            DateTime.parse(e.startDate ?? DateTime.now().toString()),
            DateTime.parse(e.endDate ?? DateTime.now().toString()),
            const Color(0xFF0F8644),
            false,
          ),
        );
      }).toList();
    }

    isTimelineCalendarByDateLoading(false);
  }
}
