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

class TimeLogSummary extends StatelessWidget {
 final bool isEmployee;
  const TimeLogSummary({super.key,required this.isEmployee});

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
              if(isEmployee==true)
               SummaryTimeLogCalendar(),

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
                  : Column(
                      children: [
                        workingScheduleLayout(
                            schedule: getConvertSecondsToHours(
                                Get.find<TimelineSummaryController>()
                                        .timelineSummaryByDate
                                        ?.getTimelogSummaryForApp
                                        ?.totalScheduledSeconds.toString() ??
                                    ""),
                            balanceTime: getConvertSecondsToHours(
                                Get.find<TimelineSummaryController>()
                                        .timelineSummaryByDate
                                        ?.getTimelogSummaryForApp
                                        ?.balance.toString()  ??
                                    ""),
                            loggedTime: getConvertSecondsToHours(
                                Get.find<TimelineSummaryController>()
                                        .timelineSummaryByDate
                                        ?.getTimelogSummaryForApp
                                        ?.loggedTotalSeconds.toString()  ??
                                    ""),
                            paidLeave: getConvertSecondsToHours(
                                Get.find<TimelineSummaryController>()
                                        .timelineSummaryByDate
                                        ?.getTimelogSummaryForApp
                                        ?.totalLeavesSeconds.toString()  ??
                                    "")),
                        _timelogDetails()
                      ],
                    )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshScreen() async {
    await Get.find<TimelineSummaryController>().getTimelineSummaryByDate();
    await Get.find<TimelineSummaryController>().getTimelogDetailsByMonth();
  }

  _timelogDetails() {
    final timelogDetails = Get.find<TimelineSummaryController>().timelogDetailsByMonth;

    if (timelogDetails?.getDailyTimeEntries?.data?.isEmpty ?? true) {
      return Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: Center(
          child: Text(
            AppString.textWeDidNotEtc.tr,
            style: AppStyle.small_text_grey,
          ),
        ),
      );
    } else {
      return  IndividualTimeLayout(isEmployee: isEmployee,);
    }
  }
}
