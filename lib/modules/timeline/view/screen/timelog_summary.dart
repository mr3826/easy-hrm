import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/individual_schedule_layout.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timelog_summary_calendar_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timelog_summary_working_gol_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';


class TimeLogSummary extends StatelessWidget {
  const TimeLogSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: AppString.text_time_log_summary.tr),
      body: Column(
        children: [
          SummaryTimeLogCalendar(),
          workingScheduleLayout(),
          IndividualTimeLayout(),

        ],
      ),
    );
  }
}
