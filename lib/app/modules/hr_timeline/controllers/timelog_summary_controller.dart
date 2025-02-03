import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/timeline_summary_by_date.dart';
import 'package:payrun_mobile/modules/timeline/model/timelog_details_by_month.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/utils.dart';
import '../repositories/timeline_data_source.dart';

class TimelineSummaryController extends GetxController with StateMixin {
  final TimelineDataSource _timelineDataSource;
  TimelineSummaryController(this._timelineDataSource);

  var selectedValue = "".obs;

  @override
  void onInit() async {
    ///For timelog summary calender
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MMMM').format(now);
    selectedValue.value = '${now.year}-$currentMonth';
    super.onInit();
  }

  RxBool isTimelineSummaryByDateLoading = false.obs;
  RxBool isMonthlySummaryDataLoading = false.obs;
  RxString selectedSummaryDate = "".obs;
  RxInt selectedYearIndex = 10.obs;
  TimelogDetailsByMonth? timelogDetailsByMonth;
  TimelineSummaryByDate? timelineSummaryByDate;



  getTimelineSummaryByDate({String? startDate, String? endDate, String? orgId}) async {
    String startDate = "${formatDate(date: Get.find<DateTimeController>().requestedDate.value,format: "yyyy-MM-dd")} 00:00:00.000";
    String endDate = "${formatDate(date: Get.find<DateTimeController>().requestedEndDate.value,format: "yyyy-MM-dd")} 23:59:59.000";

    isTimelineSummaryByDateLoading(true);
    final String organizationId = orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);
    log("getTimelineSummaryByDate start & end ==>$startDate And $endDate orgId ; $organizationId");

    timelineSummaryByDate = await _timelineDataSource.getTimelineSummaryByDate(
        startDate: startDate,
        endDate: endDate,
        orgUserId: organizationId);
    isTimelineSummaryByDateLoading(false);
  }



  getTimelogDetailsByMonth({String? startDate, String? endDate, String? orgId}) async {
    String startDate = "${formatDate(date: Get.find<DateTimeController>().requestedDate.value,format: "yyyy-MM-dd")} 00:00:00.000";
    String endDate = "${formatDate(date: Get.find<DateTimeController>().requestedEndDate.value,format: "yyyy-MM-dd")} 23:59:59.000";
    isMonthlySummaryDataLoading(true);

    final String organizationId = orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);
    log("getTimelogDetailsByMonth start & end ==>$startDate And $endDate orgId ; $organizationId");

    timelogDetailsByMonth = await _timelineDataSource.getTimelogDetailsByMonth(
        startDate: startDate,
        endDate: endDate,
        orgUserId: organizationId);
    isMonthlySummaryDataLoading(false);
  }


}
