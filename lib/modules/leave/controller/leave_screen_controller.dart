import 'dart:developer';

import 'package:get/get.dart';
import 'package:graphql/src/core/query_result.dart';
import 'package:payrun_mobile/modules/leave/controller/calendar_date_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_summary_dashboard.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';

import '../model/leave_details_by_date.dart';

class LeaveScreenController extends GetxController with StateMixin {
  LeaveSummaryForDashboard? leaveSummaryForDashboard;
  LeaveDetailsByDate? leaveDetailsByDate;
  final isLoading = false.obs;

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

    if (response.hasException) {
      log(response.exception.toString());
    } else {
      leaveDetailsByDate = LeaveDetailsByDate.fromJson(response.data!);
    }

    isLoading(false);
  }

  @override
  void onInit() async {
    await getLeaveSummaryForDashboard();
    await getLeaveDetailsByDate();
    super.onInit();
  }
}
