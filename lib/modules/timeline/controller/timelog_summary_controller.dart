import 'dart:developer';

import 'package:get/get.dart';
import 'package:payrun_mobile/modules/timeline/model/timeline_summary_by_date.dart';
import 'package:payrun_mobile/modules/timeline/model/timelog_details_by_month.dart';

import '../../../network/network_client.dart';
import '../../../utils/api_endpoints.dart';

class TimelineSummaryController extends GetxController {
  @override
  void onInit() async{
    await getTimelineByMonth(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");
    await getTimelogDetailsByMonth(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}");
    super.onInit();
  }

  RxBool isMonthlySummaryDataLoading = false.obs;

  TimelineSummaryByMonth? timelineSummaryByMonth;
  TimelogDetailsByMonth? timelogDetailsByMonth;

  getTimelineByMonth(
      {required String? startDate, required String? endDate}) async {
    isMonthlySummaryDataLoading(true);
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
    isMonthlySummaryDataLoading(false);
  }

  getTimelogDetailsByMonth(
      {required String? startDate, required String? endDate}) async {
    isMonthlySummaryDataLoading(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: getTimelogDetailsByMonthQuery, variables: {
      "queryData": {
        "start_date": startDate,
        "end_date": endDate,
      }
    });

    if (response.hasException) {
      log("getTimelogDetailsByMonth:: ${response.exception.toString()}");
    } else {
      timelogDetailsByMonth = TimelogDetailsByMonth.fromJson(response.data!);
    }
    isMonthlySummaryDataLoading(false);
  }
}
