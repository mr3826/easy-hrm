import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/modules/timeline/model/timeline_summary_by_date.dart';
import 'package:payrun_mobile/modules/timeline/model/timelog_details_by_month.dart';
import '../../../network/exception_helper.dart';
import '../../../network/network_client.dart';
import '../../../utils/api_endpoints.dart';

class TimelineSummaryController extends GetxController with StateMixin {
  var selectedValue = "".obs;

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

    ///For timelog summary calender
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MMMM').format(now);
    selectedValue.value = '${now.year}-$currentMonth';
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
    final response = await NetworkClient().graphRequest(queryString: getTimelineSummaryByDateQuery, variables: {
      "queryData": {
        "start_date": selectedMonthStartDate.value,
        "end_date": selectedMonthEndDate.value,
      }
    });
    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      print(response.data);
      timelineSummaryByMonth = TimelineSummaryByMonth.fromJson(response.data!);
    }
    isMonthlySummaryDataLoading(false);
  }

  getTimelogDetailsByMonth() async {
    isMonthlySummaryDataLoading(true);
    print(
        "getTimelogDetailsByMonth ::: start_data ${selectedMonthStartDate.value} end date ${selectedMonthEndDate.value}");
    final response = await NetworkClient()
        .graphRequest(queryString: getTimelogDetailsByMonthQuery, variables: {
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
