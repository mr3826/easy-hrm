import 'package:flutter/material.dart';
import '../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../../../modules/timeline/view/widget/timelog_summary_working_gol_layout.dart';
import '../../../../../../utils/app_color.dart';



class TimelineCalendar extends StatelessWidget {
  const TimelineCalendar({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const TimeLineCalendar(),
        Positioned(top: 0,child: _summaryLayout(context)),
      ],
    );
  }
}



Widget _summaryLayout(BuildContext context) {
  return Container(
    color: AppColor.cardColor,
    width: MediaQuery.of(context).size.width,
    child: workingScheduleLayout(
        schedule: "12",
        balanceTime: "!2",
        loggedTime: "3423",
        paidLeave: "5423"),
  );
}


