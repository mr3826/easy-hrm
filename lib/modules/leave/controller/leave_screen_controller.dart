import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_summary_dashboard.dart';
import 'package:payrun_mobile/network/exception_helper.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../home/view/screen/main_screen.dart';
import '../model/leave_details_by_date.dart';
import '../model/workshief_response_by_date.dart';

class LeaveScreenController extends GetxController with StateMixin {
  LeaveSummaryForDashboard? leaveSummaryForDashboard;
  LeaveDetailsByDate? leaveDetailsByDate;
  final isLoading = false.obs;
  final cancelLeaveLoader = false.obs;
  String? startTime;
  String? endTime;
  List<int> holidays = <int>[6, 7];

  late RxString date;

  getLeaveSummaryForDashboard() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: getLeaveSummaryForDashboardQuery);

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      leaveSummaryForDashboard =
          LeaveSummaryForDashboard.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  getLeaveDetailsByDate() async {
    isLoading(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: getLeaveDetailsByDateQuery, variables: {
      "queryData": {
        "start_date": "${date.value}T00:00:00",
        "end_date": "${date.value}T23:59:00"
      }
    });
    log("getLeaveDetailsByDate details :::: $response", error: 200);
    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      leaveDetailsByDate = LeaveDetailsByDate.fromJson(response.data!);
    }

    isLoading(false);
  }

  cancelLeave({required String leaveId}) async {
    cancelLeaveLoader(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: cancelLeaveQuery, variables: {
      "inputData": {"leave_id": leaveId, "status": "cancelled"}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      showSuccessMessage(message: AppString.leaveCanceledSuccessMessage.tr);
      Get.offAll(() => const MainScreen(
            routeIndex: 1,
          ));
    }

    cancelLeaveLoader(false);
  }

  removeLeave({required String leaveId}) async {
    cancelLeaveLoader(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: removeLeaveQuery, variables: {
      "inputData": {"leave_id": leaveId}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      showSuccessMessage(message: AppString.leaveRemovedSuccessMessage.tr);
      Get.offAll(() => const MainScreen(
            routeIndex: 1,
          ));
    }

    cancelLeaveLoader(false);
  }

  getWorkShift() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: workShiftQuery, variables: {
      "queryData": {
        "employee_id": GetStorage().read(AppString.ORGANIZATION_USER_ID),
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      WorkShiftResponse workShiftResponse =
          WorkShiftResponse.fromJson(response.data!);
      GetWorkScheduleForAssignLeave? value = workShiftResponse
          .getWorkScheduleForAssignLeave
          ?.firstWhere((element) => element.isHoliday == false);

      startTime = value?.startTime;
      endTime = value?.endTime;

      holidays = workShiftResponse.getWorkScheduleForAssignLeave
              ?.where((e) => e.isHoliday == true)
              .map((e) => e.dayOfWeek!)
              .toList() ??
          [];
      ///table calendar dont have 0 weekday key
      ///so if its 0 then convert it into 7
      if (holidays.contains(0)) {
        holidays.remove(0);
        holidays.add(7);
      }
    }
    change(null, status: RxStatus.success());
  }

  @override
  void onInit() async {
    Get.put(DateTimePickerController());
    date = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
    await getLeaveSummaryForDashboard();
    await getLeaveDetailsByDate();
    await getWorkShift();
    super.onInit();
  }
}
