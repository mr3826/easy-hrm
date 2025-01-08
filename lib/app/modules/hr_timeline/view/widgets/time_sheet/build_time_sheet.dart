import 'package:flutter/material.dart';
import 'build_select_month.dart';
import 'build_timesheet_list.dart';

class BuildTimeSheet extends StatelessWidget {
  const BuildTimeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          BuildSelectMonth(),
          BuildTimesheetList()
        ],
      ),
    );
  }
}






