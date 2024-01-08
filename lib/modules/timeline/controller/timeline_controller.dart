import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_helper_controller.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
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

import '../model/calendar_timeline.dart';
import '../model/create_time_entry.dart';

class TimelineController extends GetxController with StateMixin {
  @override
  void onInit() {
    log("""
    start: ${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0)}
    end:: ${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}
    """);
    getProjectDropdown();

    //individual date summary
    //by default its current date
    getTimelineSummaryByDate(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59)}");

    //monthly summary
    //by default its current month

    getTimelineSummaryByMonth(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");

    getCalendarTimelineDataByDate(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59)}");

    super.onInit();
  }

  final isLoading = false.obs;
  final isManualEntryLoading = false.obs;
  final isDateTimeMovementLoading = false.obs;
  final taskName = "".obs;
  final isTimeInvalid = false.obs;
  final taskId = "".obs;

  List<CalendarEventData<String>>? eventsData;

  StartOrEndTimerResponse? startOrEndTimerResponse;
  TimerEntryResponse? timerEntryResponse;
  ProjectDropDownResponse? projectDropDownResponse;
  TimelineSummaryByDate? timelineSummaryByDate;
  CalendarTimeline? calendarTimeline;
  TimelineSummaryByMonth? timelineSummaryByMonth;

  startOrEndTimer({required String timerType}) async {
    print("Method Called");
    final response =
        await NetworkClient().mutationGraphData(startOrEndTimerQueryData, {
      "inputData": {"timer_type": timerType}
    });

    if (response.hasException) {
      print(response.exception.toString());
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
      print(response.exception.toString());
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
      print(response.data);
      timelineSummaryByMonth = TimelineSummaryByMonth.fromJson(response.data!);
      print(timelineSummaryByMonth?.getTimelogSummaryForApp?.totalSchedule);
    }

    change(null, status: RxStatus.success());
  }

  getTimelineSummaryByDate(
      {required String? startDate, String? endDate}) async {
    isDateTimeMovementLoading(true);
    log("Next & previous date ==>$startDate And $endDate");
    print("Method called");
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
    isDateTimeMovementLoading(false);

  }

  getCalendarTimelineDataByDate(
      {required String? startDate, String? endDate}) async {
    isDateTimeMovementLoading(true);
   // Get.dialog(const CupertinoActivityIndicator(color: AppColor.cardColor,));
    final response = await NetworkClient()
        .getGraphQuery(queryString: getCalendarTimelineQuery, variables: {
      "queryData": {"start_time": "$startDate", "end_time": "$endDate"}
    });

    if (response.hasException) {
      log("getCalendarTimelineData:: ${response.exception.toString()}");
    } else {
      calendarTimeline = CalendarTimeline.fromJson(response.data!);
      eventsData = Get.find<TimelineController>()
          .calendarTimeline
          ?.getCalenderTimelinesForApp
          ?.timelines
          ?.map(
        (e) {
          DateTime dateTimeValue =
              DateTime.parse(e.startDate ?? DateTime.now().toString());
          return CalendarEventData(
            date: DateTime(
                dateTimeValue.year, dateTimeValue.month, dateTimeValue.day),
            startTime: DateTime.parse(e.startDate ?? DateTime.now().toString()),
            endTime: DateTime.tryParse(e.endDate ?? DateTime.now().toString()),
            event: e.task?.project?.name ?? "",
            title: e.task?.project?.name ?? "",
          );
        },
      ).toList();

    }
    isDateTimeMovementLoading(false);
 //  Get.back();
  }
}
