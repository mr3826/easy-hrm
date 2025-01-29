import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/domain/files_model.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/common/widget/warning_message.dart';
import 'package:payrun_mobile/modules/dashboard/domain/upcomming_leave_dashboard.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/project_dropdown_response.dart';
import 'package:payrun_mobile/modules/timeline/model/start_or_end_timer_response.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/timeline_summary_by_date.dart';
import 'package:payrun_mobile/modules/timeline/model/timer_entry_response.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../common/domain/last_input_model.dart';
import '../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../modules/dashboard/controller/dashbpard_controller.dart';
import '../../../global/controller/timmer_controller.dart';
import '../models/calendar_timeline.dart';
import '../../../../network/exception_helper.dart';
import '../../../home/view/screen/main_screen.dart';
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
  // final taskName = "".obs;
  // final taskId = "".obs;
  // final projectId = "".obs;
  RxString selectedSummaryDate = "".obs;
  RxInt selectedYearIndex = 10.obs;
  RxInt currentYear = DateTime.now().year.obs;
  String timeLogStatus = "";
  String timeLogDuration = "";
  // String timeLineID = "";
  Color timeLogColor = AppColor.primaryColor;
  //RxString projectColor = ''.obs;
  final searchInputData = TextEditingController().obs;
  late Timer updateDataTime;
  RxString isSelectDate = ''.obs;
  /// The index of the selected time entry status, used for updating time entry status (e.g., Pending, Approved).
  RxInt selectedStatusIndex = 0.obs;
  /// List of status options to categorize leave requests (e.g., Pending, Approved).
  /// Method to check if the button should be enabled
  //RxBool isValueChangeForTimeLogUpdate = false.obs;
  TextEditingController descriptionController =TextEditingController();
  CalendarTimeline calendarTimeline = CalendarTimeline();

  List<CalendarEventData<String>>? timelogList = <CalendarEventData<String>>[];
 final isTimelogEntryOrRemoveLoading = false.obs;
  StartOrEndTimerResponse? startOrEndTimerResponse;
  TimerEntryResponse? timerEntryResponse;
  ProjectDropDownResponse? projectDropDownResponse;
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


  getTimelineSummaryByDate({String ?startDate, String ?endDate,String ?orgId}) async {
    isTimelineSummaryByDateLoading(true);
    final String formattedStartDate = startDate ?? DateTime.now().toString();
    final String formattedEndDate = endDate ?? DateTime.now().toString();
    final String organizationId = orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);

    log("getTimelineSummaryByDate start & end ==>$startDate And $endDate");
    timelineSummaryByDate= await _timelineDataSource.getTimelineSummaryByDate(startDate: formattedStartDate, endDate: formattedEndDate,orgUserId:organizationId);
    isTimelineSummaryByDateLoading(false);
  }






 Future<bool?> removeTimelineEntry({String ?timeLogId}) async {
    String? id=  timeLogId ?? startOrEndTimerResponse?.startOrStopTimer?.id ?? "";
    isTimelogEntryOrRemoveLoading(true);
    bool response= await _timelineDataSource.removeTimelineEntry(timeLogId:id.toString());
    if(response){
      TimelineGlobalController controller=Get.find<TimelineGlobalController>();
      showSuccessMessage(message: AppString.timerRemovedSuccessfulMessage.tr);
      controller.taskId.value = ""; controller.taskName.value = ""; controller.projectColor.value = "";
      Get.find<TimeCounterController>().isTotalCount(true);
      descriptionController.clear();
      Get.find<TimeCounterController>().reset();
      Get.off(() => const MainScreen(routeIndex: 0));
      isTimelogEntryOrRemoveLoading(false);
      _refreshTimeline();
      return true;
    }
    isTimelogEntryOrRemoveLoading(false);
    return null;
  }



  getTimelineCalenderByDate({String ?startDate, String ?endDate,String ?orgId}) async {
    isTimelineCalendarByDateLoading(true);
    final String formattedStartDate = startDate ?? DateTime.now().toString();
    final String formattedEndDate = endDate ?? DateTime.now().toString();
    final String organizationId = orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);

    log("getTimelineCalenderByDate start & end ==>$startDate And $endDate org : $organizationId");
    calendarTimeline= await _timelineDataSource.getTimelineCalender(startDate: formattedStartDate, endDate: formattedEndDate,orgUserId:organizationId)??CalendarTimeline();

    calendarTimeline.getCalenderTimelinesForApp?.timelines?.forEach((e){

    });

    if (timelogList?.isNotEmpty??false) {
      for (var value in timelogList!) {
        CalendarControllerProvider.of(Get.context!).controller.remove(value);
      }
    }
    timelogList?.clear();
    timelogList = calendarTimeline.getCalenderTimelinesForApp?.timelines?.map((e) {
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

    isTimelineCalendarByDateLoading(false);
  }






















































  ///dev check
  ///with utc
  // createManualEntry() async {
  //   isManualEntryLoading(true);
  //
  //   Duration timeDifference = DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}").difference(DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));
  //   if (!timeDifference.isNegative) {
  //     isTimeInvalid(false);
  //     final response = await NetworkClient()
  //         .graphRequest(queryString: createNewEntryQuery, variables: {
  //       "inputData": {
  //         "end_date": DateTime.parse(
  //             "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
  //             .toUtc()
  //             .toString(),
  //         "description": descriptionController.text,
  //         "start_date": DateTime.parse(
  //             "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}")
  //             .toUtc()
  //             .toString(),
  //         "status": "pending",
  //         "task_id": taskId.value.isNotEmpty ? taskId.value : null,
  //         "project_id": projectId.value.isNotEmpty ? projectId.value : null,
  //       }
  //     });
  //     if (response.hasException) {
  //       ExceptionHelper.errorHandler(
  //           exception: response.exception!, methodName: "createManualEntry");
  //     } else {
  //       showSuccessMessage(message: "Time entry created successfully");
  //       taskId.value = "";
  //       taskName.value = '';
  //       projectId.value = '';
  //       descriptionController.clear();
  //       Get.off(() => const MainScreen(routeIndex: 0));
  //       _refreshTimeline();
  //     }
  //   } else {
  //     showWarningMessage(message: "Provide a valid project/task ");
  //   }
  //   isManualEntryLoading(false);
  // }

  ///dev check
  ///with utc
  // updateTimelineLogDetails() async {
  //   isUpdateTimeLogLoading(true);
  //
  //   Duration timeDifference = DateTime.parse(
  //       "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
  //       .difference(DateTime.parse(
  //       "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));
  //
  //   if (!timeDifference.isNegative) {
  //     isTimeInvalid(false);
  //     final response = await NetworkClient().graphRequest(
  //         queryString: updateTimelineLogDetailsQueryData,
  //         variables: {
  //           "inputData": {
  //             "timeline_id": timeLineID,
  //             "description": descriptionController.text,
  //             "end_date":
  //             "${DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}").toUtc()}",
  //             "start_date":
  //             "${DateTime.parse("${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}").toUtc()}",
  //             "status": "pending",
  //             "task_id": taskId.value.isNotEmpty ? taskId.value : null,
  //             "project_id": projectId.value.isNotEmpty ? projectId.value : null,
  //           }
  //         });
  //
  //     log(response.toString(), error: 0);
  //
  //     if (response.hasException) {
  //       ExceptionHelper.errorHandler(
  //           exception: response.exception!,
  //           methodName: "updateTimelineLogDetails");
  //     } else {
  //       descriptionController.clear();
  //       timeLineID = '';
  //       taskId.value = "";
  //       taskName.value = '';
  //       projectId.value = '';
  //       Get.off(() => const MainScreen(routeIndex: 0));
  //       _refreshTimeline();
  //     }
  //   } else {
  //     isTimeInvalid(true);
  //   }
  //
  //   isUpdateTimeLogLoading(false);
  // }

  // getProjectDropdown() async {
  //   isLoading(true);
  //   final response = await NetworkClient()
  //       .graphRequest(queryString: getProjectDropdownQuery, variables: {
  //     "queryData": {"searchText": taskSearchController.text},
  //     "optionData": {"limit": 200}
  //   });
  //
  //   if (response.hasException) {
  //     ExceptionHelper.errorHandler(
  //         exception: response.exception!, methodName: "getProjectDropdown");
  //   } else {
  //     projectDropDownResponse =
  //         ProjectDropDownResponse.fromJson(response.data!);
  //
  //     if (taskSearchController.text.isEmpty &&
  //         projectDropDownResponse?.getProjectsDropdown != null &&
  //         projectDropDownResponse!.getProjectsDropdown!.isNotEmpty) {
  //       taskName.value =
  //           projectDropDownResponse?.getProjectsDropdown?.first.name ?? "";
  //       projectId.value =
  //           projectDropDownResponse?.getProjectsDropdown?.first.projectId ?? "";
  //       projectColor.value =
  //           projectDropDownResponse?.getProjectsDropdown?.first.color ?? "";
  //     }
  //   }
  //   isLoading(false);
  // }

  // Future<bool> removeTimeEntry({String? timeLogId}) async {
  //   isTimelogEntryOrRemoveLoading(true);
  //   final response = await NetworkClient()
  //       .graphRequest(queryString: removeTimerQueryData, variables: {
  //     "inputData": {
  //       "timeline_id":
  //       timeLogId ?? startOrEndTimerResponse?.startOrStopTimer?.id ?? ""
  //     }
  //   });
  //
  //   if (response.hasException) {
  //     ExceptionHelper.errorHandler(
  //         exception: response.exception!, methodName: "removeTimeEntry");
  //     isTimelogEntryOrRemoveLoading(false);
  //     return false;
  //   } else {
  //     showSuccessMessage(message: AppString.timerRemovedSuccessfulMessage.tr);
  //     taskId.value = "";
  //     Get.find<TimeCounterController>().isTotalCount(true);
  //     descriptionController.clear();
  //     Get.find<TimeCounterController>().reset();
  //     Get.off(() => const MainScreen(routeIndex: 0));
  //     isTimelogEntryOrRemoveLoading(false);
  //     _refreshTimeline();
  //     return true;
  //   }
  // }






  getTimelineSummaryByMonth({required String startDate, required String endDate}) async {
    print("getTimelineSummaryByMonth_timeline ::: start_date $startDate end_date $endDate");

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

    await getTimelineCalenderByDate(
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

  void updateDataAfterTwoMinutes() {
    updateDataTime = Timer.periodic(const Duration(minutes: 2), (timer) {
      if (timelogList != null && timelogList!.isNotEmpty) {
        for (var value in timelogList!) {
          CalendarControllerProvider.of(Get.context!).controller.remove(value);
        }
      }

      timelogList = calendarTimeline.getCalenderTimelinesForApp?.timelines?.map((e) {
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


  @override
  void disposeId(Object id) {
    descriptionController.dispose();
    super.disposeId(id);
  }




}
