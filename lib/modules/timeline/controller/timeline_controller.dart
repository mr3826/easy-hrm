import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/timeline/controller/time_formate_controller.dart';
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
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../common/domain/last_input_model.dart';
import '../../../common/widget/error_message.dart';
import '../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../network/exception_helper.dart';
import '../../home/view/screen/main_screen.dart';
import '../model/calendar_timeline.dart';
import '../model/create_time_entry.dart';

class TimelineController extends GetxController with StateMixin {
  final isLoading = false.obs;
  final isManualEntryLoading = false.obs;
  final isTimelineCalendarByDateLoading = false.obs;
  final isTimelineSummaryByDateLoading = false.obs;
  final isUpdateTimeLogLoading = false.obs;
  final taskName = "".obs;
  final isTimeInvalid = false.obs;
  final taskId = "".obs;
  RxInt selectedSummaryDate = 0.obs;
  RxInt currentYear = DateTime.now().year.obs;
  String timeLogStatus = "";
  String timeLogDuration = "";
  String timeLineID = "";
  Color timeLogColor = AppColor.primaryColor;

  final isTimelogEntryOrRemoveLoading = false.obs;

  RxList<CalendarEventData<String>> eventsOfTask =
      <CalendarEventData<String>>[].obs;

  RxList<CalendarEventData<String>> eventOfLeave =
      <CalendarEventData<String>>[].obs;

  List<Appointment> meetings = <Appointment>[];

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
        showSuccessMessage(message: AppString.timerStartedSuccessfulMessage.tr);
        Get.find<TimeCounterController>().start();
      } else {
        if (Get.find<TimeCounterController>().timer.isActive) {
          Get.find<TimeCounterController>().stop();
        }
      }
    }
  }

  saveTimeEntry() async {
    isTimelogEntryOrRemoveLoading(true);
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
      showSuccessMessage(message: AppString.timerSavedSuccessfulMessage.tr);
      timerEntryResponse = TimerEntryResponse.fromJson(response.data!);
      print(timerEntryResponse?.updateTimelineEntry?.startDate);
      taskId.value = "";
      Get.find<TimeCounterController>().isTotalCount(true);
      descriptionController.clear();
      Get.find<TimeCounterController>().reset();
      Get.to(() => MainScreen(
            routeIndex: 0,
          ));
    }
    isTimelogEntryOrRemoveLoading(false);
  }

  removeTimeEntry({String? timeLogId}) async {
    isTimelogEntryOrRemoveLoading(true);

    print("timelogId: $timeLogId");

    final response =
        await NetworkClient().mutationGraphData(removeTimerQueryData, {
      "inputData": {
        "timeline_id":
            timeLogId ?? startOrEndTimerResponse?.startOrStopTimer?.id ?? ""
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      showSuccessMessage(message: AppString.timerRemovedSuccessfulMessage.tr);
      taskId.value = "";
      Get.find<TimeCounterController>().isTotalCount(true);
      descriptionController.clear();
      Get.find<TimeCounterController>().reset();
      Get.back(canPop: false);
    }
    isTimelogEntryOrRemoveLoading(false);
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

    Duration timeDifference = DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
        .difference(DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));
    print("""timeDifference.isNegative:: ${timeDifference.isNegative}
    
    start time: "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"
    end time: "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}"
    """);

    if (!timeDifference.isNegative) {
      isTimeInvalid(false);
      final response = await NetworkClient()
          .mutationGraphData(updateTimelineLogDetailsQueryData, {
        "inputData": {
          "timeline_id": timeLineID,
          "description": descriptionController.text,
          "end_date":
              "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}",
          "start_date":
              "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}",
          "status": "pending"
        }
      });

      log(response.toString(), error: 0);

      if (response.hasException) {
        ExceptionHelper.errorHandler(exception: response.exception!);
      } else {
        descriptionController.clear();
        timeLineID = '';
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
        Get.find<TimelineController>().timeLineID = "";

        Get.back();
      }
    } else {
      isTimeInvalid(true);
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
    Duration timeDifference = DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
        .difference(DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));
    print("""timeDifference.isNegative:: ${timeDifference.isNegative}
    
    start time: "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"
    end time: "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}"
    """);
    if (!timeDifference.isNegative) {
      isTimeInvalid(false);
      if (taskId.isNotEmpty) {
        final response =
            await NetworkClient().mutationGraphData(createNewEntryQuery, {
          "inputData": {
            "end_date":
                "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}",
            "description": descriptionController.text,
            "start_date":
                "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}",
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
          _refreshTimeline();
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

      print("time line calendar ::: $responseForCalendar");

      meetings.clear();
      calendarTimeline?.getCalenderTimelinesForApp?.timelines?.map((e) {
        DateTime dateTimeNow = DateTime.now();
        DateTime dateStartTimeValue =
            DateTime.parse(e.startDate ?? DateTime.now().toString());
        DateTime dateEndTimeValue =
            DateTime.parse(e.endDate ?? DateTime.now().toString());

        ModelForDescription modelForDescription = ModelForDescription(
          status: e.status ?? "",
          description: e.description ?? "No added yet",
          timeLId: e.timelineId ?? "",
          endDate: e.endDate ?? "",
          startDate: e.startDate ?? "",
          duration: e.totalMinutes ?? "",
          taskName: e.task?.name ?? "",
        );

        Map<String, dynamic> jsonModel = modelForDescription.toJson();
        String jsonObject = jsonEncode(jsonModel);
        log(jsonModel.toString(), error: 1);

        log(jsonModel.toString(), error: 1);
        return meetings.add(
          Appointment(
            notes: "Note",
            location: jsonObject,
            startTime: DateTime(
              dateTimeNow.year,
              dateTimeNow.month,
              dateTimeNow.day,
              dateStartTimeValue.hour,
              dateStartTimeValue.minute,
              dateStartTimeValue.second,
            ),
            endTime: DateTime(
              dateTimeNow.year,
              dateTimeNow.month,
              dateTimeNow.day,
              dateEndTimeValue.hour,
              dateEndTimeValue.minute,
              dateEndTimeValue.second,
            ),
            subject: """
            ${timeFormatTo24h(DateTime.parse(e.startDate.toString()))}
            
            
            ${e.task?.project?.name ?? "No added yet"} 
            ${convertMiniToHour(Duration(minutes: int.parse(e.totalMinutes ?? "00"))).toString()} 
            
            ${timeFormatTo24h(DateTime.parse(e.endDate ?? Get.find<DateTimeController>().requestedDate.value))}
            
            
            """,
            color: statusAccordingToColor(e.status),
            isAllDay: false,
          ),
        );
      }).toList();

      calendarTimeline?.getCalenderTimelinesForApp?.leaves?.map((e) {
        DateTime dateTimeNow = DateTime.now();
        DateTime dateStartTimeValue =
            DateTime.parse(e.startDate ?? DateTime.now().toString());
        DateTime dateEndTimeValue =
            DateTime.parse(e.endDate ?? DateTime.now().toString());

        ModelForDescription modelForDescription = ModelForDescription(
          status: e.status ?? "",
          description: e.description ?? "No added yet",
          leaveId: e.id ?? "",
          endDate: e.endDate ?? "",
          startDate: e.startDate ?? "",
          numberOfDays: e.numberOfDays ?? "",
          leaveType: LeaveType(
              leaveName: e.leaveType?.leaveName ?? "",
              isAttachDocumentRequired: e.leaveType?.isAddNoteRequired ?? false,
              isAddNoteRequired: e.leaveType?.isAddNoteRequired ?? false,
              leaveId: e.leaveType?.leaveId ?? "",
              type: e.leaveType?.type ?? ""),
        );

        Map<String, dynamic> jsonModel = modelForDescription.toJson();
        String jsonObject = jsonEncode(jsonModel);
        log(jsonModel.toString(), error: 1);

        return meetings.add(
          Appointment(
            startTime: DateTime(
              dateTimeNow.year,
              dateTimeNow.month,
              dateTimeNow.day,
              dateStartTimeValue.hour,
              dateStartTimeValue.minute,
              dateStartTimeValue.second,
            ),
            endTime: DateTime(
              dateTimeNow.year,
              dateTimeNow.month,
              dateTimeNow.day,
              dateEndTimeValue.hour,
              dateEndTimeValue.minute,
              dateEndTimeValue.second,
            ),
            subject: """
            ${timeFormatTo24h(DateTime.parse(e.startDate.toString()))}
            

            ${e.leaveType?.leaveName ?? "No added yet"}
            ${convertMiniToHour(Duration(minutes: int.parse(e.totalLeaveMinutes.toString()))).toString()}  
            
           
            ${timeFormatTo24h(DateTime.parse(e.endDate ?? "00:00"))}
            
            """,
            color: statusAccordingToColor(e.status),
            isAllDay: false,
            location: jsonObject,
          ),
        );
      }).toList();
    }

    isTimelineCalendarByDateLoading(false);
  }

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
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59)}");
    getTimelineSummaryByDate(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59)}");

    super.onInit();
  }

  _refreshTimeline() async {
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
    getTimelineSummaryByDate(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59)}");
  }
}

statusAccordingToColor(status) {

  switch (status) {
    case "pending":
      return AppColor.pendingColor.withOpacity(0.1);
    case "approved":
      return AppColor.primaryColor.withOpacity(0.1);
    case "taken":
      return AppColor.takenColor.withOpacity(0.1);
    case "reject":
      return AppColor.errorColorLight.withOpacity(0.1);
    case "cancelled":
      return AppColor.errorColor.withOpacity(0.1);
    case "rejected":
      return AppColor.errorColor.withOpacity(0.1);
    default:
      return AppColor.hintColor.withOpacity(0.1);
  }
}
