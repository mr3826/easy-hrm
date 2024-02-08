import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/common/widget/warning_message.dart';
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
  final projectId = "".obs;
  RxString selectedSummaryDate = "".obs;
  RxInt selectedYearIndex = 10.obs;
  RxInt currentYear = DateTime.now().year.obs;
  String timeLogStatus = "";
  String timeLogDuration = "";
  String timeLineID = "";
  Color timeLogColor = AppColor.primaryColor;
  late Timer _apiCallAfter2MinsTimer;

  CalendarTimeline calendarTimeline = CalendarTimeline();
  List<CalendarEventData<String>>? timelogList = <CalendarEventData<String>>[];

  final isTimelogEntryOrRemoveLoading = false.obs;
  final isTimelogRemoveLoading = false.obs;

  RxList<CalendarEventData<String>> eventsOfTask =
      <CalendarEventData<String>>[].obs;

  RxList<CalendarEventData<String>> eventOfLeave =
      <CalendarEventData<String>>[].obs;

  List<Appointment> meetings = <Appointment>[];

  StartOrEndTimerResponse? startOrEndTimerResponse;
  TimerEntryResponse? timerEntryResponse;
  ProjectDropDownResponse? projectDropDownResponse;
  TimelineSummaryByDate? timelineSummaryByDate;
  TimelineSummaryByMonth? timelineSummaryByMonth;

  Future<bool> startOrEndTimer({required String timerType}) async {
    final response =
        await NetworkClient().mutationGraphData(startOrEndTimerQueryData, {
      "inputData": {"timer_type": timerType}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
      return false;
    } else {
      startOrEndTimerResponse =
          StartOrEndTimerResponse.fromJson(response.data!);
      if (startOrEndTimerResponse?.startOrStopTimer?.endDate == null) {
        showSuccessMessage(message: AppString.timerStartedSuccessfulMessage.tr);
        Get.find<TimeCounterController>().start();
      } else {
        if (Get.find<TimeCounterController>().timer.isActive &&
            Get.find<TimeCounterController>().animationTimer.isActive) {
          Get.find<TimeCounterController>().stop();
        }
      }
      return true;
    }
  }

  ///done
  ///dev check
  saveTimeEntry() async {
    print('''
     "description": ${descriptionController.text},
        "end_date": ${startOrEndTimerResponse?.startOrStopTimer?.endDate ?? ""},
        "start_date":
            ${startOrEndTimerResponse?.startOrStopTimer?.startDate ?? ""},
        "status": "pending",
        "task_id": ${taskId.value.isNotEmpty ? taskId.value : null},
        "project_id": ${projectId.value.isNotEmpty ? projectId.value : null},
        "timeline_id": ${startOrEndTimerResponse?.startOrStopTimer?.id ?? ""}
    ''');

    isTimelogEntryOrRemoveLoading(true);
    final response =
        await NetworkClient().mutationGraphData(saveTimerQueryData, {
      "inputData": {
        "description": descriptionController.text,
        "end_date": startOrEndTimerResponse?.startOrStopTimer?.endDate ?? "",
        "start_date":
            startOrEndTimerResponse?.startOrStopTimer?.startDate ?? "",
        "status": "pending",
        "task_id": taskId.value.isNotEmpty ? taskId.value : null,
        "project_id": projectId.value.isNotEmpty ? projectId.value : null,
        "timeline_id": startOrEndTimerResponse?.startOrStopTimer?.id ?? ""
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      showSuccessMessage(message: AppString.timerSavedSuccessfulMessage.tr);
      timerEntryResponse = TimerEntryResponse.fromJson(response.data!);
      taskId.value = "";
      taskName.value = '';
      projectId.value = '';
      Get.find<TimeCounterController>().isTotalCount(true);
      descriptionController.clear();
      Get.find<TimeCounterController>().reset();
      _refreshTimeline();
      Get.to(() => const MainScreen(
            routeIndex: 0,
          ));
    }
    isTimelogEntryOrRemoveLoading(false);
  }

  ///done
  ///dev check
  createManualEntry() async {
    isManualEntryLoading(true);

    print('''
     "description": ${descriptionController.text},
        "end_date": ${DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}").toUtc().toString()},
        "start_date":
            ${DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}").toUtc().toString()},
        "status": "pending",
        "task_id": ${taskId.value.isNotEmpty ? taskId.value : null},
        "project_id": ${projectId.value.isNotEmpty ? projectId.value : null},
    ''');

    Duration timeDifference = DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
        .difference(DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));
    if (!timeDifference.isNegative) {
      isTimeInvalid(false);
      final response =
          await NetworkClient().mutationGraphData(createNewEntryQuery, {
        "inputData": {
          "end_date": DateTime.parse(
                  "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
              .toUtc()
              .toString(),
          "description": descriptionController.text,
          "start_date": DateTime.parse(
                  "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}")
              .toUtc()
              .toString(),
          "status": "pending",
          "task_id": taskId.value.isNotEmpty ? taskId.value : null,
          "project_id": projectId.value.isNotEmpty ? projectId.value : null,
        }
      });
      if (response.hasException) {
        ExceptionHelper.errorHandler(exception: response.exception!);
      } else {
        showSuccessMessage(message: "Time entry created successfully");
        Get.to(() => const MainScreen(
              routeIndex: 0,
            ));
        taskId.value = "";
        taskName.value = '';
        projectId.value = '';
        descriptionController.clear();
        _refreshTimeline();
      }
    } else {
      showWarningMessage(message: "Provide a valid project task ");
    }
    isManualEntryLoading(false);
  }

  ///todo
  updateTimelineLogDetails() async {
    isUpdateTimeLogLoading(true);

    Duration timeDifference = DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
        .difference(DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));
    print('''
     "description": ${descriptionController.text},
        "end_date": "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}",
        "start_date":
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}",
        "status": "pending",
        "task_id": ${taskId.value.isNotEmpty ? taskId.value : null},
        "project_id": ${projectId.value.isNotEmpty ? projectId.value : null},
        "timeline_id": $timeLineID
    ''');

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
          "status": "pending",
          "task_id": taskId.value.isNotEmpty ? taskId.value : null,
          "project_id": projectId.value.isNotEmpty ? projectId.value : null,
        }
      });

      log(response.toString(), error: 0);

      if (response.hasException) {
        ExceptionHelper.errorHandler(exception: response.exception!);
      } else {
        showSuccessMessage(message: AppString.timelogUpdateSuccessfully);
        Get.to(() => const MainScreen(
              routeIndex: 0,
            ));
        descriptionController.clear();
        timeLineID = '';
        taskId.value = "";
        taskName.value = '';
        projectId.value = '';
        _refreshTimeline();
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

  removeTimeEntry({String? timeLogId}) async {
    isTimelogRemoveLoading(true);
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
      Get.to(() => const MainScreen(
            routeIndex: 0,
          ));
      showSuccessMessage(message: AppString.timerRemovedSuccessfulMessage.tr);
      _refreshTimeline();
      taskId.value = "";
      Get.find<TimeCounterController>().isTotalCount(true);
      descriptionController.clear();
      Get.find<TimeCounterController>().reset();
    }
    isTimelogRemoveLoading(false);
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
      "queryData": {"start_time": startDate, "end_time": endDate}
    });

    if (responseForCalendar.hasException) {
      ExceptionHelper.errorHandler(exception: responseForCalendar.exception!);
    } else {
      // fetchDataAfterTwoMinutes();
      if (timelogList!.isNotEmpty) {
        for (var value in timelogList!) {
          CalendarControllerProvider.of(Get.context!).controller.remove(value);
        }
      }

      calendarTimeline = CalendarTimeline.fromJson(responseForCalendar.data!);

      timelogList =
          calendarTimeline.getCalenderTimelinesForApp?.timelines?.map((e) {
        ModelForDescription modelForDescription = ModelForDescription(
            status: e.status ?? "",
            description: e.description ?? "No added yet",
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
            endTime: e.endDate != null
                ? DateTime.parse("2024-01-24 ${e.endDate?.substring(11, 19)}")
                : DateTime.parse(
                    "2024-01-24 ${DateTime.now().toString().substring(11, 19)}"),
            event: "",
            title: '',
            description: objData);
      }).toList();
      timelogList?.addAll(calendarTimeline.getCalenderTimelinesForApp?.leaves
              ?.map((e) {
            //todo
            /// add files info
            ModelForDescription modelForDescription = ModelForDescription(
                status: e.status ?? "",
                description: e.description ?? "No added yet",
                endDate: e.endDate ?? "",
                startDate: e.startDate ?? "",
                duration: e.totalLeaveMinutes ?? "",
                numberOfDays: e.numberOfDays ?? 0,
                createdAt: e.createdAt ?? "",
                leaveId: e.id ?? "",
                taskName: e.leaveType?.leaveName ?? "",
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
                  ? DateTime.parse(
                      "2024-01-24 ${e.startDate?.substring(11, 19)}")
                  : DateTime.parse(
                      "2024-01-24 ${DateTime.now().toString().substring(11, 19)}"),
              endTime: e.endDate != null
                  ? DateTime.parse("2024-01-24 ${e.endDate?.substring(11, 19)}")
                  : DateTime.parse(
                      "2024-01-24 ${DateTime.now().toString().substring(11, 19)}"),
              event: "",
              title: '',
              description: objData,
            );
          }).toList() ??
          []);

      CalendarControllerProvider.of(Get.context!)
          .controller
          .addAll(timelogList ?? []);

      print("""
        
        timelogList?.length:: ${timelogList?.length}
        
        """);
    }

    isTimelineCalendarByDateLoading(false);
  }

  @override
  void onClose() {
    if (_apiCallAfter2MinsTimer.isActive) {
      _apiCallAfter2MinsTimer.cancel();
    }
    super.onClose();
  }

  @override
  void onInit() {
    getProjectDropdown();
    _refreshTimeline();
    fetchDataAfterTwoMinutes();

    super.onInit();
  }

  _refreshTimeline() async {
    await getTimelineSummaryByMonth(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month + 1, 0, 23, 59, 59)}");

    await getCalendarTimelineDataByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");
    await getTimelineSummaryByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");
  }

  void fetchDataAfterTwoMinutes() {
    _apiCallAfter2MinsTimer =
        Timer.periodic(const Duration(minutes: 2), (timer) async {
      await getCalendarTimelineDataByDate(
          startDate:
              "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
          endDate:
              "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");
    });
  }
}
