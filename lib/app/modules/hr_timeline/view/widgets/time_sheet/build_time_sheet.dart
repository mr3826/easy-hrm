import 'package:flutter/material.dart';
import 'build_timesheet_list.dart';

class BuildTimeSheet extends StatelessWidget {
  const BuildTimeSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 66.0,left: 8,top: 8,right: 8),
      child: BuildTimesheetList(),
    );
  }
}






