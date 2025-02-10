import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../../global/utils/date_format_helper.dart';
import '../../../../controller/hr_leave_controller.dart';
import '../../../../controller/leave_controller.dart';
import 'calendar_task_card_widget.dart';
import 'calendar_widget.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  // Generate a list of all dates in the current month
  List<DateTime> _generateDatesForCurrentMonth() {
    DateTime now = DateTime.parse(
        Get.find<LeaveController>().selectedMonthDate.toString());

    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return List.generate(
        daysInMonth, (index) => DateTime(now.year, now.month, index + 1));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> monthDates = _generateDatesForCurrentMonth();
    Map<String, List<Task>> taskData =
        Get.find<HrLeaveController>().getTaskDataFromLeaves();

    return RefreshIndicator(
      onRefresh: _refreshScreen,
      child: ListView.builder(
        itemCount: monthDates.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          DateTime date = monthDates[index];
          String formattedDate = DateFormat("yyyy-MM-dd").format(date);
          String dayLabel = DateFormat("EEE").format(date);
          List<Task> tasks = taskData[formattedDate] ?? [];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Divider(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Date Display
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              DateFormatHelper.formatDate(
                                  date: date.toString(), format: "dd"),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(dayLabel,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.03)),
                        ],
                      ),
                    ),
                  ),
                  // Task Display
                  Expanded(
                    child: Column(
                      children: tasks.isEmpty
                          ? [const VerticalDottedDivider()]
                          : tasks
                              .map((task) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: TaskCard(
                                      task: task,
                                    ),
                                  ))
                              .toList(),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

Future<void> _refreshScreen() async {
  HrLeaveController controller = Get.find<HrLeaveController>();
  LeaveController leaveController = Get.find<LeaveController>();

  controller.getHrLeaveCalender(
      startDate: leaveController.startDate.toString(),
      endDate: leaveController.endDate.toString());
}
