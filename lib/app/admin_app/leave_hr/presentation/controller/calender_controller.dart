import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

/// A controller for managing the calendar's state and date selections.
class CalendarController {
  // The currently focused day in the calendar.
  var focusedDay = DateTime.now().obs;

  // The start and end of the selected date range.
  var rangeStart = Rxn<DateTime>();
  var rangeEnd = Rxn<DateTime>();

  // The mode for range selection (enabled or disabled).
  var rangeSelectionMode = RangeSelectionMode.toggledOff.obs;

  /// Selects a specific day and updates the focused day.
  void selectDay(DateTime selectedDay, DateTime newFocusedDay) {
    focusedDay.value = newFocusedDay;

    if (rangeSelectionMode.value == RangeSelectionMode.toggledOn) {
      if (rangeStart.value == null ||
          selectedDay.isBefore(rangeStart.value!) ||
          selectedDay.isAfter(rangeEnd.value!)) {
        // Start a new range if selected day is outside the current range.
        rangeStart.value = selectedDay;
        rangeEnd.value = null;
      } else {
        // Update the end of the range.
        rangeEnd.value = selectedDay;
      }
    } else {
      // Start a new range selection.
      rangeStart.value = selectedDay;
      rangeEnd.value = null;
      rangeSelectionMode.value = RangeSelectionMode.toggledOn;
    }
  }

  /// Selects a range of dates and updates the focused day.
  void selectRange(DateTime? start, DateTime? end, DateTime newFocusedDay) {
    rangeStart.value = start;
    rangeEnd.value = end;
    focusedDay.value = newFocusedDay;
    rangeSelectionMode.value = RangeSelectionMode.toggledOn;
  }

  /// Updates the currently focused day.
  void updateFocusedDay(DateTime newFocusedDay) {
    focusedDay.value = newFocusedDay;
  }

  /// Clears the current date range and resets selection mode.
  void clearRange() {
    rangeStart.value = null;
    rangeEnd.value = null;
    rangeSelectionMode.value = RangeSelectionMode.toggledOff;
    print("Cleared date range");
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
        print("Custom date selection");
        break;

      default:
        print("Invalid selection");
        return;
    }

    // Update the observable values
    rangeStart.value = start;
    rangeEnd.value = end;

    // Print the selected range
    print("Selected range: ${rangeStart.value} to ${rangeEnd.value}");
  }
}
