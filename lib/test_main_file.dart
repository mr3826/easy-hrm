import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: DaySelectionScreen(),
    );
  }
}

class DaySelectionScreen extends StatelessWidget {
  final List<String> dayList = [
    "Today",
    "Yesterday",
    "This week",
    "Last week",
    "This month",
    "Last month",
    "Custom"
  ];

  final DateRangeController dateRangeController = Get.put(DateRangeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Date Range")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dayList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => dateRangeController.onDaySelected(dayList[index]),
                    child: Text(dayList[index]),
                  ),
                );
              },
            ),
          ),
          Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              dateRangeController.selectedDateRange.value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )),
        ],
      ),
    );
  }
}














class DateRangeController extends GetxController {


  final selectedDateRange = "".obs;

  void onDaySelected(String day) {
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateRange = "";
    switch (day) {
      case "Today":
        dateRange = "Date: ${formatter.format(now)}";
        break;
      case "Yesterday":
        final yesterday = now.subtract(const Duration(days: 1));
        dateRange = "Date: ${formatter.format(yesterday)}";
        break;
      case "This week":
        final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        dateRange = "From: ${formatter.format(startOfWeek)} to ${formatter.format(endOfWeek)}";
        break;
      case "Last week":
        final endOfLastWeek = now.subtract(Duration(days: now.weekday % 7 + 1));
        final startOfLastWeek = endOfLastWeek.subtract(const Duration(days: 6));
        dateRange = "From: ${formatter.format(startOfLastWeek)} to ${formatter.format(endOfLastWeek)}";
        break;
      case "This month":
        final startOfMonth = DateTime(now.year, now.month, 1);
        final endOfMonth = DateTime(now.year, now.month + 1, 0); // Last day of current month
        dateRange = "From: ${formatter.format(startOfMonth)} to ${formatter.format(endOfMonth)}";
        break;
      case "Last month":
        final startOfLastMonth = DateTime(now.year, now.month - 1, 1);
        final endOfLastMonth = DateTime(now.year, now.month, 0); // Last day of previous month
        dateRange = "From: ${formatter.format(startOfLastMonth)} to ${formatter.format(endOfLastMonth)}";
        break;
      case "Custom":
        dateRange = "Select a custom date range";
        break;
      default:
        dateRange = "Unknown selection";
    }

    selectedDateRange.value = dateRange;
  }



}


