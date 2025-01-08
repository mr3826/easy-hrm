import 'dart:developer';
import 'package:get/get.dart';


class TimeSheetController  {

  RxString currentDate = "This month".obs;
  List<String> dayList = ["Today", "Yesterday", "This week", "Last week", "This month", "Last month", "Custom"];

  RxInt listIndex = 0.obs;


  // The start and end of the selected date range.
  var rangeStart = Rxn<DateTime>();
  var rangeEnd = Rxn<DateTime>();
  /// Clears the current date range and resets selection mode.
  void clearRange() {
    rangeStart.value = null;
    rangeEnd.value = null;
  }

  /// Handles selection of predefined date ranges.
  void onDaySelected(String day) {
    final now = DateTime.now();
    DateTime start;
    DateTime end;

    switch (day) {
      case "0": //Today
        start = now;
        end = now; // End same as start for Today
        break;

      case "1": //Yesterday
        start = now.subtract(const Duration(days: 1));
        end = start; // End same as start for Yesterday
        break;

      case "2": //This week
        start = now.subtract(
            Duration(days: now.weekday - 1)); // Start of the current week
        end = start.add(const Duration(days: 6)); // End of the current week
        break;

      case "3": //Last week
        end = now
            .subtract(Duration(days: now.weekday)); // End of last week (Sunday)
        start = end
            .subtract(const Duration(days: 6)); // Start of last week (Monday)
        break;

      case "4": //This month
        start = DateTime(now.year, now.month, 1); // Start of the month
        end = DateTime(
            now.year, now.month + 1, 0); // Last day of the current month
        break;

      case "5": //Last month
        start = DateTime(now.year, now.month - 1, 1); // Start of last month
        end = DateTime(now.year, now.month, 0); // Last day of last month
        break;

      case "6": //Custom
      // Handle custom date selection if needed
        start = DateTime.now(); // Placeholder for custom start
        end = DateTime.now(); // Placeholder for custom end
        break;

      default:
        return;
    }

    // Update the observable values
    rangeStart.value = start;
    rangeEnd.value = end;

    // Print the selected range
    log("Selected range: ${rangeStart.value} to ${rangeEnd.value}");
  }



}
