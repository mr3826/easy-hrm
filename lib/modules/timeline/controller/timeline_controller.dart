import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/domain/files_model.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/common/widget/warning_message.dart';
import 'package:payrun_mobile/modules/dashboard/domain/upcomming_leave_dashboard.dart';
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
import '../../../app/home/view/screen/main_screen.dart';
import '../../../common/domain/last_input_model.dart';
import '../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../network/exception_helper.dart';
import '../../dashboard/presentation/controller/employee_dashboard_controller.dart';
import '../model/calendar_timeline.dart';

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
  RxString projectColor = ''.obs;
  final searchInputData = TextEditingController().obs;
  late Timer updateDataTime;
  CalendarTimeline calendarTimeline = CalendarTimeline();

  List<CalendarEventData<String>>? timelogList = <CalendarEventData<String>>[];

  final isTimelogEntryOrRemoveLoading = false.obs;

  StartOrEndTimerResponse? startOrEndTimerResponse;
  TimerEntryResponse? timerEntryResponse;
  ProjectDropDownResponse? projectDropDownResponse;
  TimelineSummaryByDate? timelineSummaryByDate;
  TimelineSummaryByMonth? timelineSummaryByMonth;

  var isSelectDate = ''.obs;

  /// Method to check if the button should be enabled
  RxBool isValueChangeForTimeLogUpdate = false.obs;

  // Future<bool> startOrEndTimer({required String timerType}) async {
  //   final response = await NetworkClient()
  //       .graphRequest(queryString: startOrEndTimerQueryData, variables: {
  //     "inputData": {"timer_type": timerType}
  //   });
  //
  //   if (response.hasException) {
  //     ExceptionHelper.errorHandler(
  //         exception: response.exception!, methodName: "saveTimeEntry");
  //     return false;
  //   } else {
  //     startOrEndTimerResponse =
  //         StartOrEndTimerResponse.fromJson(response.data!);
  //     if (startOrEndTimerResponse?.startOrStopTimer?.endDate == null) {
  //       showSuccessMessage(message: AppString.timerStartedSuccessfulMessage.tr);
  //       Get.find<TimeCounterController>().start();
  //       _refreshTimeline();
  //     } else {
  //       if (Get.find<TimeCounterController>().timer.isActive &&
  //           Get.find<TimeCounterController>().animationTimer.isActive) {
  //         Get.find<TimeCounterController>().stop();
  //         Get.find<TimeCounterController>().isRunningHorizontalLine(false);
  //       }
  //     }
  //     return true;
  //   }
  // }

  /// Starts or stops the timer based on the [timerType].
  ///
  /// This method sends a GraphQL request to start or stop a timer based on the
  /// [timerType] ("start" or "end"). It handles the response and updates the UI
  /// accordingly, either starting the timer or stopping it based on the server's response.
  ///
  /// If the timer is successfully started, it triggers a success message and starts
  /// the timer in the [TimeCounterController]. If the timer is stopped, it also stops
  /// the animation and the timer in the same controller.
  ///
  /// Returns `true` if the timer was successfully started or stopped, and `false` if
  /// an exception occurred during the API call.
  ///
  /// Throws: Exception handled by [ExceptionHelper.errorHandler].
  Future<bool> startOrEndTimer({required String timerType}) async {
    try {
      // Make the GraphQL request to start or stop the timer.
      final response = await NetworkClient()
          .graphRequest(queryString: startOrEndTimerQueryData, variables: {
        "inputData": {"timer_type": timerType}
      });

      // Handle exception from response
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "saveTimeEntry");
        return false;
      }

      // Parse response data
      startOrEndTimerResponse =
          StartOrEndTimerResponse.fromJson(response.data!);

      // If endDate is null, the timer has started
      if (startOrEndTimerResponse?.startOrStopTimer?.endDate == null) {
        // Show success message and start timer in the controller
        showSuccessMessage(message: AppString.timerStartedSuccessfulMessage.tr);
        Get.find<TimeCounterController>().start();
        _refreshTimeline();
      } else {
        // If the timer is active, stop it along with the animation
        TimeCounterController timerController =
            Get.find<TimeCounterController>();
        if (timerController.timer.isActive &&
            timerController.animationTimer.isActive) {
          timerController.stop();
          timerController.isRunningHorizontalLine(false);
        }
      }

      return true;
    } catch (e) {
      // Handle unexpected errors
      log("startOrEndTimer:: ${e.toString()}");
      return false;
    }
  }

  // saveTimeEntry() async {
  //   isTimelogEntryOrRemoveLoading(true);
  //   final response = await NetworkClient()
  //       .graphRequest(queryString: saveTimerQueryData, variables: {
  //     "inputData": {
  //       "description": descriptionController.text,
  //       "end_date":
  //           "${DateTime.parse(startOrEndTimerResponse?.startOrStopTimer?.endDate ?? DateTime.now().toString()).toUtc()}",
  //       "start_date":
  //           "${DateTime.parse(startOrEndTimerResponse?.startOrStopTimer?.startDate ?? DateTime.now().toString()).toUtc()}",
  //       "status": "pending",
  //       "task_id": taskId.value.isNotEmpty ? taskId.value : null,
  //       "project_id": projectId.value.isNotEmpty ? projectId.value : null,
  //       "timeline_id": startOrEndTimerResponse?.startOrStopTimer?.id ?? ""
  //     }
  //   });
  //
  //   if (response.hasException) {
  //     ExceptionHelper.errorHandler(
  //         exception: response.exception!, methodName: "saveTimeEntry");
  //   } else {
  //     showSuccessMessage(message: AppString.timerSavedSuccessfulMessage.tr);
  //     timerEntryResponse = TimerEntryResponse.fromJson(response.data!);
  //     taskId.value = "";
  //     taskName.value = '';
  //     projectId.value = '';
  //     Get.find<TimeCounterController>().isTotalCount(true);
  //     descriptionController.clear();
  //     Get.find<TimeCounterController>().reset();
  //     Get.find<DashboardController>().getMonthlyTimelineInfoForDashboard();
  //     Get.find<DashboardController>().getProfileInfoForDashboard();
  //     _refreshTimeline();
  //
  //     Get.to(() => const MainScreen(
  //           routeIndex: 0,
  //         ));
  //   }
  //   isTimelogEntryOrRemoveLoading(false);
  // }

  /// Saves a time entry based on the current timer data.
  ///
  /// This method sends a GraphQL request to save the time entry using the start and end dates from the
  /// [startOrEndTimerResponse], along with optional task and project IDs if provided.
  ///
  /// If the time entry is successfully saved, the method:
  /// - Clears the task and project data.
  /// - Resets the time entry description.
  /// - Resets the [TimeCounterController] and refreshes the dashboard and timeline data.
  /// - Navigates back to the main screen.
  ///
  /// If there is an exception during the request, it is handled by [ExceptionHelper.errorHandler].
  ///
  /// The [isTimelogEntryOrRemoveLoading] flag is used to show loading state during the API call.
  Future<void> saveTimeEntry() async {
    // Show loading indicator
    isTimelogEntryOrRemoveLoading(true);

    // Prepare variables for the GraphQL request
    final variables = {
      "inputData": {
        "description": descriptionController.text,
        "end_date":
            _formatDate(startOrEndTimerResponse?.startOrStopTimer?.endDate),
        "start_date":
            _formatDate(startOrEndTimerResponse?.startOrStopTimer?.startDate),
        "status": "pending",
        "task_id": taskId.value.isNotEmpty ? taskId.value : null,
        "project_id": projectId.value.isNotEmpty ? projectId.value : null,
        "timeline_id": startOrEndTimerResponse?.startOrStopTimer?.id ?? ""
      }
    };

    try {
      // Make the GraphQL request to save the timer entry
      final response = await NetworkClient().graphRequest(
        queryString: saveTimerQueryData,
        variables: variables,
      );

      // Handle response exception
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "saveTimeEntry");
      } else {
        // Success: Show a success message and process the response
        showSuccessMessage(message: AppString.timerSavedSuccessfulMessage.tr);
        timerEntryResponse = TimerEntryResponse.fromJson(response.data!);

        // Reset fields and controllers after successful save
        _resetFields();

        // Refresh dashboard and timeline data
        Get.find<EmployeeDashboardController>().getMonthlyTimelineInfoForDashboard();
        Get.find<EmployeeDashboardController>().getProfileInfoForDashboard();
        _refreshTimeline();

        // Navigate to the main screen
        Get.to(() => const MainScreen(routeIndex: 0));
      }
    } finally {
      // Hide loading indicator after completion
      isTimelogEntryOrRemoveLoading(false);
    }
  }

  /// Formats the date string to UTC format. Defaults to the current date and time if [date] is null.
  String _formatDate(String? date) {
    return "${DateTime.parse(date ?? DateTime.now().toString()).toUtc()}";
  }

  /// Resets the task, project, and description fields and the time counter.
  void _resetFields() {
    taskId.value = "";
    taskName.value = '';
    projectId.value = '';
    descriptionController.clear();
    Get.find<TimeCounterController>().reset();
    Get.find<TimeCounterController>().isTotalCount(true);
  }

  ///dev check
  ///with utc
  createManualEntry() async {
    isManualEntryLoading(true);

    Duration timeDifference = DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
        .difference(DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));
    if (!timeDifference.isNegative) {
      isTimeInvalid(false);
      final response = await NetworkClient()
          .graphRequest(queryString: createNewEntryQuery, variables: {
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
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "createManualEntry");
      } else {
        showSuccessMessage(message: "Time entry created successfully");
        taskId.value = "";
        taskName.value = '';
        projectId.value = '';
        descriptionController.clear();
        Get.off(() => const MainScreen(routeIndex: 0));
        _refreshTimeline();
      }
    } else {
      showWarningMessage(message: "Provide a valid project/task ");
    }
    isManualEntryLoading(false);
  }

  ///dev check
  ///with utc
  updateTimelineLogDetails() async {
    isUpdateTimeLogLoading(true);

    Duration timeDifference = DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
        .difference(DateTime.parse(
            "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));

    if (!timeDifference.isNegative) {
      isTimeInvalid(false);
      final response = await NetworkClient().graphRequest(
          queryString: updateTimelineLogDetailsQueryData,
          variables: {
            "inputData": {
              "timeline_id": timeLineID,
              "description": descriptionController.text,
              "end_date":
                  "${DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}").toUtc()}",
              "start_date":
                  "${DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}").toUtc()}",
              "status": "pending",
              "task_id": taskId.value.isNotEmpty ? taskId.value : null,
              "project_id": projectId.value.isNotEmpty ? projectId.value : null,
            }
          });

      log(response.toString(), error: 0);

      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!,
            methodName: "updateTimelineLogDetails");
      } else {
        descriptionController.clear();
        timeLineID = '';
        taskId.value = "";
        taskName.value = '';
        projectId.value = '';
        Get.off(() => const MainScreen(routeIndex: 0));
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
        .graphRequest(queryString: getProjectDropdownQuery, variables: {
      "queryData": {"searchText": taskSearchController.text},
      "optionData": {"limit": 200}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(
          exception: response.exception!, methodName: "getProjectDropdown");
    } else {
      projectDropDownResponse =
          ProjectDropDownResponse.fromJson(response.data!);

      if (taskSearchController.text.isEmpty &&
          projectDropDownResponse?.getProjectsDropdown != null &&
          projectDropDownResponse!.getProjectsDropdown!.isNotEmpty) {
        taskName.value =
            projectDropDownResponse?.getProjectsDropdown?.first.name ?? "";
        projectId.value =
            projectDropDownResponse?.getProjectsDropdown?.first.projectId ?? "";
        projectColor.value =
            projectDropDownResponse?.getProjectsDropdown?.first.color ?? "";
      }
    }
    isLoading(false);
  }

  Future<bool> removeTimeEntry({String? timeLogId}) async {
    isTimelogEntryOrRemoveLoading(true);
    final response = await NetworkClient()
        .graphRequest(queryString: removeTimerQueryData, variables: {
      "inputData": {
        "timeline_id":
            timeLogId ?? startOrEndTimerResponse?.startOrStopTimer?.id ?? ""
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(
          exception: response.exception!, methodName: "removeTimeEntry");
      isTimelogEntryOrRemoveLoading(false);
      return false;
    } else {
      showSuccessMessage(message: AppString.timerRemovedSuccessfulMessage.tr);
      taskId.value = "";
      Get.find<TimeCounterController>().isTotalCount(true);
      descriptionController.clear();
      Get.find<TimeCounterController>().reset();
      Get.off(() => const MainScreen(routeIndex: 0));
      isTimelogEntryOrRemoveLoading(false);
      _refreshTimeline();
      return true;
    }
  }

  getTimelineSummaryByMonth(
      {required String? startDate, required String? endDate}) async {
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

  getTimelineSummaryByDate(
      {required String? startDate, String? endDate}) async {
    isTimelineSummaryByDateLoading(true);
    log("getTimelineSummaryByDate start & end ==>$startDate And $endDate");

    final response = await NetworkClient()
        .graphRequest(queryString: getTimelineSummaryByDateQuery, variables: {
      "queryData": {
        "start_date": "$startDate",
        "end_date": "$endDate",
      }
    });
    log("getTimelineSummaryByDate ==> $response");
    if (response.hasException) {
      log("getTimelineByDate:: ${response.exception.toString()}");
    } else {
      timelineSummaryByDate = TimelineSummaryByDate.fromJson(response.data!);
      log("balance time ==> ${TimelineSummaryByDate.fromJson(response.data!).getTimelogSummaryForApp?.balance}");
    }
    isTimelineSummaryByDateLoading(false);
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

  _refreshTimeline() async {
    await getTimelineSummaryByMonth(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");

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

  getCalendarTimelineDataByDate(
      {required String? startDate, String? endDate}) async {
    isTimelineCalendarByDateLoading(true);

    final responseForCalendar = await NetworkClient()
        .graphRequest(queryString: getCalendarTimelineQuery, variables: {
      "queryData": {"start_time": startDate, "end_time": endDate}
    });

    if (responseForCalendar.hasException) {
      ExceptionHelper.errorHandler(
          exception: responseForCalendar.exception!,
          methodName: "getCalendarTimelineDataByDate");
    } else {
      if (timelogList!.isNotEmpty) {
        for (var value in timelogList!) {
          CalendarControllerProvider.of(Get.context!).controller.remove(value);
        }
      }

      timelogList?.clear();

      calendarTimeline = CalendarTimeline.fromJson(responseForCalendar.data!);

      timelogList =
          calendarTimeline.getCalenderTimelinesForApp?.timelines?.map((e) {
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
      timelogList?.addAll(calendarTimeline.getCalenderTimelinesForApp?.leaves
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
                          scheduleSecond: int.parse(e.leaveDetails?[0].scheduleSecond.toString()??""),
                          leaveSecond: int.parse(e.leaveDetails?[0].leaveSecond.toString()??""),
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

      if (updateDataTime.isActive) {
        print("updateDataTime.isActive ${updateDataTime.isActive}");
        updateDataTime.cancel();
        print("updateDataTime.isActive ${updateDataTime.isActive}");
      }
      updateDataAfterTwoMinutes();
    }

    isTimelineCalendarByDateLoading(false);
  }

  void updateDataAfterTwoMinutes() {
    updateDataTime = Timer.periodic(const Duration(minutes: 2), (timer) {
      if (timelogList != null && timelogList!.isNotEmpty) {
        for (var value in timelogList!) {
          CalendarControllerProvider.of(Get.context!).controller.remove(value);
        }
      }

      timelogList =
          calendarTimeline.getCalenderTimelinesForApp?.timelines?.map((e) {
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
          calendarTimeline.getCalenderTimelinesForApp?.leaves?.map((e) {
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
}
