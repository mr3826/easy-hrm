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
    switch (day) {
      case "Today":
        rangeStart.value = now;
        print("Selected Today: ${rangeStart.value}");
        break;

      case "Yesterday":
        rangeStart.value = now.subtract(const Duration(days: 1));
        print("Selected Yesterday: ${rangeStart.value}");
        break;

      case "This week":
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        rangeStart.value = startOfWeek;
        rangeEnd.value = startOfWeek.add(const Duration(days: 6));
        print("Selected This Week: ${rangeStart.value} to ${rangeEnd.value}");
        break;

      case "Last week":
        final endOfLastWeek = now.subtract(Duration(days: now.weekday));
        final startOfLastWeek = endOfLastWeek.subtract(const Duration(days: 6));
        rangeStart.value = startOfLastWeek;
        rangeEnd.value = endOfLastWeek;
        print("Selected Last Week: ${rangeStart.value} to ${rangeEnd.value}");
        break;

      case "This month":
        rangeStart.value = DateTime(now.year, now.month, 1);
        rangeEnd.value = DateTime(now.year, now.month + 1, 0);
        print("Selected This Month: ${rangeStart.value} to ${rangeEnd.value}");
        break;

      case "Last month":
        rangeStart.value = DateTime(now.year, now.month - 1, 1);
        rangeEnd.value = DateTime(now.year, now.month, 0);
        print("Selected Last Month: ${rangeStart.value} to ${rangeEnd.value}");
        break;

      case "Custom":
        print("Custom date selection");
        break;

      default:
        print("Invalid selection");
    }
  }
}
