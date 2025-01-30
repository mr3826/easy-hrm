import 'package:flutter/material.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/timeline_summary_by_date.dart';
import '../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../../../modules/timeline/view/widget/timelog_summary_working_gol_layout.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/utils.dart';

class TimelineCalendar extends StatelessWidget {
  final TimelineSummaryByDate timelineSummaryByDate;
  const TimelineCalendar({super.key, required this.timelineSummaryByDate});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const TimeLineCalendar(),
        Positioned(top: 0, child: _summaryLayout(context)),
      ],
    );
  }

  _summaryLayout(BuildContext context) {
    return Container(
      color: AppColor.cardColor,
      width: MediaQuery.of(context).size.width,
      child: workingScheduleLayout(
          schedule: getConvertSecondsToHours(timelineSummaryByDate
                  .getTimelogSummaryForApp?.totalScheduledSeconds ??
              ""),
          balanceTime: getConvertSecondsToHours(
              timelineSummaryByDate.getTimelogSummaryForApp?.balance ?? ""),
          loggedTime: getConvertSecondsToHours(timelineSummaryByDate
                  .getTimelogSummaryForApp?.loggedTotalSeconds ??
              ""),
          paidLeave: getConvertSecondsToHours(timelineSummaryByDate
                  .getTimelogSummaryForApp?.totalLeavesSeconds ??
              "")),
    );
  }
}
