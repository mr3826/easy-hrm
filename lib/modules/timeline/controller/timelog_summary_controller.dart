import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:payrun_mobile/modules/timeline/model/timeline_summary_by_date.dart';
import 'package:payrun_mobile/modules/timeline/model/timelog_details_by_month.dart';

import '../../../network/exception_helper.dart';
import '../../../network/network_client.dart';
import '../../../utils/api_endpoints.dart';

class TimelineSummaryController extends GetxController with StateMixin {
  @override
  void onInit() async {
    selectedMonthStartDate =
        "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}"
            .obs;
    selectedMonthEndDate =
        "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}"
            .obs;
    await getTimelineByMonth();
    await getTimelogDetailsByMonth();
    super.onInit();
  }

  RxBool isMonthlySummaryDataLoading = false.obs;
  RxString selectedSummaryDate = "".obs;
  RxInt selectedYearIndex = 10.obs;

  TimelineSummaryByMonth? timelineSummaryByMonth;
  TimelogDetailsByMonth? timelogDetailsByMonth;

  late RxString selectedMonthStartDate;

  late RxString selectedMonthEndDate;

  getTimelineByMonth() async {
    isMonthlySummaryDataLoading(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: getTimelineSummaryByDateQuery, variables: {
      "queryData": {
        "start_time": selectedMonthStartDate.value,
        "end_time": selectedMonthEndDate.value,
      }
    });
    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      print(response.data);
      timelineSummaryByMonth = TimelineSummaryByMonth.fromJson(response.data!);
      print(timelineSummaryByMonth?.getTimelogSummaryForApp?.totalSchedule);
    }
    isMonthlySummaryDataLoading(false);
  }

  getTimelogDetailsByMonth() async {
    isMonthlySummaryDataLoading(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: getTimelogDetailsByMonthQuery, variables: {
      "queryData": {
        "start_date": selectedMonthStartDate.value,
        "end_date": selectedMonthEndDate.value,
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      timelogDetailsByMonth = TimelogDetailsByMonth.fromJson(response.data!);
    }
    isMonthlySummaryDataLoading(false);
  }
}
