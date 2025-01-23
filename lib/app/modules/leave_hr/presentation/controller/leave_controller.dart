import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_string.dart';

class LeaveController extends GetxController {
  /// The total number of tabs in the leave management UI.
  RxInt tabLength = 0.obs;

  RxInt leaveTypeSelectedIndex = (-1).obs;  // Default to -1, indicating no selection

  /// The index of the selected leave status, used for updating leave status (e.g., Pending, Approved).
  RxInt selectedStatusIndex = 0.obs;

  /// Index of the current selected item in the leave list, helps with tracking list interactions.
  RxInt listIndex = 0.obs;

  /// List of tab names displayed in the leave UI (e.g., Calendar and Leave Record).
  RxList<String> tabList = [AppString.textCalendar, AppString.textLeaveRecord].obs;

  /// List of day filter options available for selecting date ranges (e.g., Today, This week).
  List<String> dayList = ["Today", "Yesterday", "This week", "Last week", "This month", "Last month", "Custom"];

  /// List of status options to categorize leave requests (e.g., Pending, Approved).
  final List<String> statusOptions = ["Pending", "Approved"];

  /// Controller for managing the search input field in the leave UI.
  final searchController = TextEditingController().obs;

  /// Holds the current search text entered by the user.
  final searchText = ''.obs;

  /// The selected date range for filtering leave records.
  final selectedDateRange = "".obs;

  var selectAssignLeave = 'This year'.obs;

  final List<String> items = [
    'This year',
    'Next year',
  ];

  /// The currently selected year index.
  RxInt selectedYearIndex = 0.obs;

  /// List of years starting with the current year,
  /// including the last 24 years and the next 2 years.
  final List<int> years = [
    for (int i = 0; i < 25; i++) DateTime.now().year - i, // Current year and last 24 years
    for (int i = 1; i <= 2; i++) DateTime.now().year + i, // Next 2 years
  ];

  /// The currently selected month index.
  RxInt selectedMonthIndex = (DateTime.now().month - 1).obs;

  /// List of month names for selection.
  final List<String> months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  /// Returns the DateTime for the selected month in the selected year.
  Rx<DateTime> get selectedMonthDate => DateTime(years[selectedYearIndex.value], selectedMonthIndex.value + 1).obs;

  Rx<DateTime> get selectedYearDate => DateTime(years[selectedYearIndex.value]).obs;

  /// Current date in a formatted string (optional, can be removed if not needed).
  RxString currentDate = "This month".obs;

  /// Method to get the start date of the selected month and year
  DateTime get startDate {
    // First day of the selected month
    return DateTime(years[selectedYearIndex.value], selectedMonthIndex.value + 1, 1);
  }

  /// Method to get the end date of the selected month and year
  DateTime get endDate {
    // Last day of the selected month
    DateTime firstDayNextMonth = DateTime(years[selectedYearIndex.value], selectedMonthIndex.value + 1 + 1, 1);
    return firstDayNextMonth.subtract(const Duration(days: 1));
  }
}