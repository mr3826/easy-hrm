import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../utils/app_string.dart';
import '../../../global/controller/user_info_controller.dart';
import '../models/time_sheet_model.dart';
import '../repositories/timeline_data_source.dart';


class TimeSheetController extends GetxController {

  final TimelineDataSource _timelineDataSource;
  TimeSheetController(this._timelineDataSource);

  RxString currentDate = "This month".obs;
  List<String> dayList = ["Today", "Yesterday", "This week", "Last week", "This month", "Last month", "Custom"];
  RxInt listIndex = 0.obs;
  // The start and end of the selected date range.
  var rangeStart = Rxn<DateTime>();
  var rangeEnd = Rxn<DateTime>();





  TimeSheetModel? timeSheetModel;


  final isTimeSheetLoading = false.obs;










  Future<void> getTimesheetByDate({String ?startDate,  String? endDate, String ?orgId}) async {

    final String formattedStartDate = startDate ?? DateTime.now().toString();
    final String formattedEndDate = endDate ?? DateTime.now().toString();

    final String organizationId = orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID);

    isTimeSheetLoading(true);
    timeSheetModel = await _timelineDataSource.getTimesheetByDate(startDate: formattedStartDate, endDate: formattedEndDate, orgId: organizationId);
    isTimeSheetLoading(false);
  }














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
