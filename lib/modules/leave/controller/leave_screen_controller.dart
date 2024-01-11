import 'dart:developer';

import 'package:get/get.dart';
import 'package:payrun_mobile/modules/leave/controller/calendar_date_controller.dart';
import 'package:payrun_mobile/modules/leave/model/cancel_leave_res.dart';
import 'package:payrun_mobile/modules/leave/model/leave_summary_dashboard.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/utils.dart';

import '../../home/view/screen/main_screen.dart';
import '../model/leave_details_by_date.dart';

class LeaveScreenController extends GetxController with StateMixin {
  LeaveSummaryForDashboard? leaveSummaryForDashboard;
  LeaveDetailsByDate? leaveDetailsByDate;
  final isLoading = false.obs;
  final cancelLeaveLoader = false.obs;

  getLeaveSummaryForDashboard() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: getLeaveSummaryForDashboardQuery);

    if (response.hasException) {
      log(response.exception.toString());
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
        "startDate": "${Get.find<DateController>().formattedDateTime}T00:00:00",
        "endDate": "${Get.find<DateController>().formattedDateTime}T23:59:00"
      }
    });

    print("getLeaveDetailsByDate::: ${response.data}");

    if (response.hasException) {
      log(response.exception.toString());
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
      log(response.exception.toString());
    } else {
      print(CancelLeaveResponse.fromJson(response.data!).updateLeave?.id);
      Get.off(() => MainScreen(
            routeIndex: 1,
          ));
    }

    cancelLeaveLoader(false);
  }

  void updateLeave(
      {required String leaveId,
      required String startDate,
      required String? endDate,
      required String? leaveTypeId}) async {
    print("""
    required String leaveId::$leaveId,
      required String startDate::$startDate,
      required String? endDate::$endDate
    """);
    cancelLeaveLoader(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: cancelLeaveQuery, variables: {
      "inputData": {
        "leave_id": leaveId,
        "status": "pending",
        "description": leaveNoteController.text,
        "end_date": endDate,
        "start_date": startDate,
        "leave_type_id": leaveTypeId
      }
    });

    if (response.hasException) {
      log(response.exception.toString());
    } else {
      print(CancelLeaveResponse.fromJson(response.data!).updateLeave?.id);
      Get.off(() => MainScreen(
            routeIndex: 1,
          ));
    }

    cancelLeaveLoader(false);
  }

  @override
  void onInit() async {
    await getLeaveSummaryForDashboard();
    await getLeaveDetailsByDate();
    super.onInit();
  }
}
