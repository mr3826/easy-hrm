import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controller/leave_controller.dart';
import '../../leave_recorde/leave_recorde_details /leave_record_details.dart';
import 'calendar_task_card_widget.dart';
import 'calendar_widget.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  // Generate a list of all dates in the current month
  List<DateTime> _generateDatesForCurrentMonth() {
    DateTime now = DateTime.parse(Get.find<LeaveController>().selectedMonthDate.toString());

    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return List.generate(
        daysInMonth, (index) => DateTime(now.year, now.month, index + 1));
  }

  //selectedMonthDate

  // Mock data to simulate tasks for specific dates
  Map<String, List<Task>> getMockedTaskData() {
    return {
      "2024-11-09": [
        Task(
          name: "Michael Buchenwald",
          role: "UI/UX Designer",
          leaveType: "Casual leave: Paid",
          status: "Pending",
          imageUrls: [
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3VuJfZepsmghuglByBpsb1rFIkgSeSK6nqA&s",
          ],
        ),
      ],
      "2024-11-12": [
        Task(
          name: "Group Task",
          isGroup: true,
          approvedCount: 1,
          pendingCount: 2,
          rejectedCount: 1,
          takenCount: 2,
          cancelledCount: 4,
          imageUrls: [
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg",
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg",
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg",
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg",
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg",
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg",
          ],
        ),
      ],
      "2024-11-14": [
        Task(
            name: "Sophia Fisher",
            role: "Developer",
            leaveType: "Sick leave",
            status: "Approved",
            isGroup: true,
            approvedCount: 01,
            pendingCount: 02,
            rejectedCount: 21,
            imageUrls: [
              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg",
              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg",
              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg",
              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg",
            ]),
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> monthDates = _generateDatesForCurrentMonth();
    Map<String, List<Task>> taskData = getMockedTaskData();

    return ListView.builder(
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
                            DateFormat("dd").format(date),
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
                                fontSize:
                                MediaQuery.of(context).size.width * 0.03)),
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
                        leaveRecordDetailsModel:
                        LeaveRecordDetailsModel(
                            leaveDate: "2024-11-10",
                            typeOfLeave: "Sick",
                            leaveStatus: "Paid",
                            leaveDuration: "2 days",
                            imgUrl: "",
                            employeeName: "Rifat Hasan",
                            designation:
                            "Mobile Application Developer",
                            applicationStatus: "pending",
                            applicationDate: "20 Apr 2034"),
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
    );
  }
}
