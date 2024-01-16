import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timeline_calendar.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timelog_summary_working_gol_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';

import '../../../auth/presentation/view/otp_screen.dart';
import '../../controller/timeline_controller.dart';

class TimeLogView extends StatelessWidget {
  const TimeLogView({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarControllerProvider.of(context)
        .controller
        .addAll(Get.find<TimelineController>().eventsOfTask ?? []);
    CalendarControllerProvider.of(context)
        .controller
        .addAll(Get.find<TimelineController>().eventOfLeave ?? []);

    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            const TimeLineCalendar(),
            Positioned(
                top: AppLayout.getHeight(76),
                child: Container(
                  color: AppColor.backgroundColor,
                  width: MediaQuery.of(context).size.width,
                  child: workingScheduleLayout(
                      schedule: Get.find<TimelineController>()
                              .timelineSummaryByDate
                              ?.getTimelogSummaryForApp
                              ?.totalSchedule ??
                          "",
                      balanceTime: Get.find<TimelineController>()
                              .timelineSummaryByDate
                              ?.getTimelogSummaryForApp
                              ?.balanced ??
                          "",
                      loggedTime: Get.find<TimelineController>()
                              .timelineSummaryByDate
                              ?.getTimelogSummaryForApp
                              ?.totalLogged ??
                          "",
                      paidLeave: Get.find<TimelineController>()
                              .timelineSummaryByDate
                              ?.getTimelogSummaryForApp
                              ?.paidLeave ??
                          ""),
                )),
          ],
        ));
  }

  _onLoading(context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: marginLayout.copyWith(top: 12, bottom: 12),
          child: const Center(
              child: CupertinoActivityIndicator(
            animating: true,
          )),
        ));
  }
}
