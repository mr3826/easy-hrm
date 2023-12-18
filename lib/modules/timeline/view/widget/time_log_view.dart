import 'package:flutter/material.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timeline_calendar.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timelog_summary_working_gol_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';

class TimeLogView extends StatelessWidget {
  const TimeLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          const TimeLineCalendar(),
          Positioned(
              top: 76,
              child: Container(
                  color: AppColor.backgroundColor,
                  width: MediaQuery.of(context).size.width,
                  child: workingScheduleLayout())),
        ],
      ),
    );
  }


}