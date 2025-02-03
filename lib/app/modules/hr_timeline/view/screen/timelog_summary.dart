import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/timelog_summary_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/individual_schedule_layout.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timelog_summary_calendar_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timelog_summary_working_gol_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../utils/utils.dart';
import '../../bindings/TimelineSummaryBindings.dart';
import '../../controllers/hr_timeline_controller.dart';
import '../widgets/time_sheet/timelog_summary_details.dart';

class TimeLogSummary extends GetView<TimelineSummaryController> {
  final LogSummaryUserInfo? logSummaryUserInfo;
  final bool isEmployee;

  const TimeLogSummary({
    super.key,
    required this.isEmployee,
    this.logSummaryUserInfo,
  });

  @override
  Widget build(BuildContext context) {
    TimeSheetBindings().dependencies();
    return Scaffold(
      appBar: customAppbar(title: AppString.text_time_log_summary.tr),
      body: RefreshIndicator(
        backgroundColor: AppColor.cardColor,
        color: AppColor.primaryColor,
        onRefresh: _refreshScreen,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              if (isEmployee) SummaryTimeLogCalendar(),
              Obx(
                () => controller.isMonthlySummaryDataLoading.isTrue &&
                        controller.isTimelineSummaryByDateLoading.isTrue
                    ? _buildLoadingIndicator()
                    : Column(
                        children: [
                          _buildWorkingSchedule(),
                          _buildTimeLogDetails(),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshScreen() async {
    if (isEmployee == true) {
      await controller.getTimelineSummaryByDate();
      await controller.getTimelogDetailsByMonth();
    } else {
      controller.getTimelineSummaryByDate(
          orgId: Get.find<HrTimelineController>().orgUserId);
      controller.getTimelogDetailsByMonth(
          orgId: Get.find<HrTimelineController>().orgUserId);
    }
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.35),
        child: const CupertinoActivityIndicator(
          color: Colors.blueAccent,
          radius: 18,
        ),
      ),
    );
  }

  Widget _buildWorkingSchedule() {
    final summary = controller.timelineSummaryByDate?.getTimelogSummaryForApp;

    return workingScheduleLayout(
      schedule: getConvertSecondsToHours(
          summary?.totalScheduledSeconds?.toString() ?? "0"),
      balanceTime:
          getConvertSecondsToHours(summary?.balance?.toString() ?? "0"),
      loggedTime: getConvertSecondsToHours(
          summary?.loggedTotalSeconds?.toString() ?? "0"),
      paidLeave: getConvertSecondsToHours(
          summary?.totalLeavesSeconds?.toString() ?? "0"),
    );
  }

  Widget _buildTimeLogDetails() {
    final timelogDetails = controller.timelogDetailsByMonth;
    final hasData =
        timelogDetails?.getDailyTimeEntries?.data?.isNotEmpty ?? false;

    return hasData
        ? IndividualTimeLayout(
            isEmployee: isEmployee,
            logSummaryUserInfo: logSummaryUserInfo,
          )
        : Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Center(
              child: Text(
                AppString.textWeDidNotEtc.tr,
                style: AppStyle.small_text_grey,
              ),
            ),
          );
  }
}
