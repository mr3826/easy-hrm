import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/timeline_summary_by_date.dart';
import 'package:payrun_mobile/modules/timeline/model/timelog_details_by_month.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/app_string.dart';
import '../repositories/timeline_data_source.dart';

class TimelineSummaryController extends GetxController with StateMixin {
  final TimelineDataSource _timelineDataSource;
  TimelineSummaryController(this._timelineDataSource);

  var selectedValue = "".obs;

  @override
  void onInit() async {
    // selectedMonthStartDate =
    //     "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}"
    //         .obs;
    // selectedMonthEndDate =
    //     "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}"
           // .obs;
    // await getTimelogDetailsByMonth();
    // await getTimelineSummaryByDate();

    ///For timelog summary calender
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MMMM').format(now);
    selectedValue.value = '${now.year}-$currentMonth';
    super.onInit();
  }

  RxBool isMonthlySummaryDataLoading = false.obs;
  RxString selectedSummaryDate = "".obs;
  RxInt selectedYearIndex = 10.obs;
  TimelogDetailsByMonth? timelogDetailsByMonth;
  TimelineSummaryByDate? timelineSummaryByDate;

   RxString selectedMonthStartDate= "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}".obs;
   RxString selectedMonthEndDate=  "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}".obs;



  getTimelineSummaryByDate({String? startDate, String? endDate, String? orgId}) async {
    String startDate = "${Get.find<DateTimeController>().requestedDate.value} 00:00:00.000";
    String endDate = "${Get.find<DateTimeController>().requestedDate.value} 23:59:59.000";

    isMonthlySummaryDataLoading(true);
    final String organizationId = orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);
    log("getTimelineSummaryByDate start & end ==>$startDate And $endDate orgId ; $organizationId");

    timelineSummaryByDate = await _timelineDataSource.getTimelineSummaryByDate(
        startDate: startDate,
        endDate: endDate,
        orgUserId: organizationId);
    isMonthlySummaryDataLoading(false);
  }



  getTimelogDetailsByMonth({String? startDate, String? endDate, String? orgId}) async {
    String startDate = "${Get.find<DateTimeController>().requestedDate.value} 00:00:00.000";
    String endDate = "${Get.find<DateTimeController>().requestedDate.value} 23:59:59.000";

    isMonthlySummaryDataLoading(true);

    final String organizationId = orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);
    log("getTimelogDetailsByMonth start & end ==>$startDate And $endDate orgId ; $organizationId");

    timelogDetailsByMonth = await _timelineDataSource.getTimelogDetailsByMonth(
        startDate: startDate,
        endDate: endDate,
        orgUserId: organizationId);
    isMonthlySummaryDataLoading(false);
  }























  //
  // getTimelogDetailsByMonth() async {
  //   isMonthlySummaryDataLoading(true);
  //   final response = await NetworkClient()
  //       .graphRequest(queryString: getTimelogDetailsByMonthQuery, variables: {
  //     "queryData": {
  //       "start_date": selectedMonthStartDate.value,
  //       "end_date": selectedMonthEndDate.value,
  //       "leave_statuses": ["approved", "pending"],
  //     },
  //     "optionData": {
  //       "limit": 50,
  //       "offset": 0,
  //       "order": [
  //         ["ta.entry_day", "desc"]
  //       ]
  //     }
  //   });
  //
  //   if (response.hasException) {
  //     ExceptionHelper.errorHandler(
  //         exception: response.exception!, methodName: "getTimelineByMonth");
  //   } else {
  //     timelogDetailsByMonth = TimelogDetailsByMonth.fromJson(response.data!);
  //   }
  //   isMonthlySummaryDataLoading(false);
  // }
}
