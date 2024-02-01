import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_summary_dashboard.dart';
import 'package:payrun_mobile/network/exception_helper.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../dashboard/controller/dashbpard_controller.dart';
import '../../home/view/screen/main_screen.dart';
import '../model/leave_details_by_date.dart';

class LeaveScreenController extends GetxController with StateMixin {
  LeaveSummaryForDashboard? leaveSummaryForDashboard;
  LeaveDetailsByDate? leaveDetailsByDate;
  final isLoading = false.obs;
  final cancelLeaveLoader = false.obs;

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
        "startDate": "${date.value}T00:00:00",
        "endDate": "${date.value}T23:59:00"
      }
    });
    log("getLeaveDetailsByDate details :::: $response",error: 200);


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
      Get.off(() => const MainScreen(
            routeIndex: 1,
          ));
      await getLeaveSummaryForDashboard();
      await getLeaveDetailsByDate();
      await Get.find<DashboardController>()
          .getMonthlyTimelineInfoForDashboard();
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
      Get.off(() => const MainScreen(
            routeIndex: 1,
          ));
      await getLeaveSummaryForDashboard();
      await getLeaveDetailsByDate();
      await Get.find<DashboardController>()
          .getMonthlyTimelineInfoForDashboard();
    }

    cancelLeaveLoader(false);
  }

  @override
  void onInit() async {
    Get.put(DateTimePickerController());
    date = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
    await getLeaveSummaryForDashboard();
    await getLeaveDetailsByDate();
    super.onInit();
  }
}
