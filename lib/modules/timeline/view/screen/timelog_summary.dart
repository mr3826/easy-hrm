import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/modules/timeline/controller/timelog_summary_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/individual_schedule_layout.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timelog_summary_calendar_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timelog_summary_working_gol_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';

class TimeLogSummary extends StatelessWidget {
  const TimeLogSummary({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TimelineSummaryController());
    return Scaffold(
      appBar: customAppbar(title: AppString.text_time_log_summary.tr),
      body: RefreshIndicator(
        onRefresh: _refreshScreen,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SummaryTimeLogCalendar(),
                Obx(() => Get.find<TimelineSummaryController>()
                        .isMonthlySummaryDataLoading
                        .isTrue
                    ? Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: Get.height * .35),
                            child: const CupertinoActivityIndicator(
                              color: Colors.blueAccent,
                              radius: 18,
                            )),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            workingScheduleLayout(
                                schedule: Get.find<TimelineSummaryController>()
                                        .timelineSummaryByMonth
                                        ?.getTimelogSummaryForApp
                                        ?.totalSchedule ??
                                    "",
                                balanceTime: Get.find<TimelineSummaryController>()
                                        .timelineSummaryByMonth
                                        ?.getTimelogSummaryForApp
                                        ?.balanced ??
                                    "",
                                loggedTime: Get.find<TimelineSummaryController>()
                                        .timelineSummaryByMonth
                                        ?.getTimelogSummaryForApp
                                        ?.totalLogged ??
                                    "",
                                paidLeave: Get.find<TimelineSummaryController>()
                                        .timelineSummaryByMonth
                                        ?.getTimelogSummaryForApp
                                        ?.paidLeave ??
                                    ""),
                            const IndividualTimeLayout(),
                          ],
                        ),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshScreen() async{
    await Get.find<TimelineSummaryController>().getTimelineByMonth();
    await Get.find<TimelineSummaryController>().getTimelogDetailsByMonth();
  }
}
