import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/modules/leave/model/leave_records.dart';
import 'package:payrun_mobile/network/network_client.dart';

import '../../../utils/api_endpoints.dart';

class LeaveRecordsController extends GetxController with StateMixin {
  @override
  void onInit() {
    getLeaveRecords();
    super.onInit();
  }

  List<LeaveRecordsByMonth>? monthsList;

  getLeaveRecords() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: getLeaveRecordsQuery, variables: {
      "queryData": {
        "start_date":
            "${DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, 1, 1))}T00:00:00+06:00",
        "end_date":
            "${DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, 12, 31))}T00:00:00+06:00"
      }
    });
    if (response.hasException) {
      log(response.exception.toString());
    } else {
      LeaveRecords? leaveRecords = LeaveRecords.fromJson(response.data!);
      await groupLeaveRecordByMonth(leaveRecords);
      log(leaveRecords.toString());
    }
    change(null, status: RxStatus.success());
  }

  groupLeaveRecordByMonth(LeaveRecords leaveRecords) {
    final Map<int, List<GetLeaveRecords>> recordsByMonth = {};

    for (GetLeaveRecords record in leaveRecords.getLeaveRecords!) {
      final int monthKey = DateTime.parse(record.startDate!).month;
      if (recordsByMonth.containsKey(monthKey)) {
        recordsByMonth[monthKey]!.add(record);
      } else {
        recordsByMonth[monthKey] = [record];
      }
    }

    // Create a list of Month<LeaveRecords>
    monthsList = recordsByMonth.entries
        .map(
          (entry) => LeaveRecordsByMonth(
              leaveRecords: entry.value,
              monthName: _getMonthNameByIndex(entry.key)),
        )
        .toList();
    print(monthsList.toString());
  }

  String _getMonthNameByIndex(int monthIndex) {
    if (monthIndex < 1 || monthIndex > 12) {
      throw ArgumentError('Month index should be between 1 and 12');
    }

    DateTime dateTime = DateTime.parse(
        DateTime(DateTime.now().year, monthIndex).toString().split(' ')[0]);

    return "${_getMonthName(dateTime.month)}, ${dateTime.year}";
  }

  String _getMonthName(int monthIndex) {
    const List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return monthNames[monthIndex - 1];
  }
}

class LeaveRecordsByMonth {
  final String monthName;
  final List<GetLeaveRecords> leaveRecords;

  LeaveRecordsByMonth({required this.monthName, required this.leaveRecords});

  @override
  String toString() {
    return 'Month{monthName: $monthName, leaveRecords: $leaveRecords}';
  }
}
