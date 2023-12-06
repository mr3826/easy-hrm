import 'dart:convert';

import 'package:intl/intl.dart';

void main() {
  const jsonResponse = """
  
  {
  "data": {
    "getLeaveRecords": [
        {
        "end_date": "2022-10-27T15:00:00.000Z",
        "start_date": "2022-10-27T13:01:00.000Z"
      },
      {
        "end_date": "2023-12-07T00:00:00.000Z",
        "start_date": "2023-12-06T00:00:00.000Z"
      },
      {
        "end_date": "2023-10-26T15:00:00.000Z",
        "start_date": "2023-10-26T13:01:00.000Z"
      },
      {
        "end_date": "2023-10-26T12:00:00.000Z",
        "start_date": "2023-10-26T10:01:00.000Z"
      },
      {
        "end_date": "2023-10-26T10:00:00.000Z",
        "start_date": "2023-10-26T09:00:00.000Z"
      },
      {
        "end_date": "2023-11-26T11:00:00.000Z",
        "start_date": "2023-11-26T09:00:00.000Z"
      },
      {
        "end_date": "2022-01-25T00:00:00.000Z",
        "start_date": "2022-01-24T00:00:00.000Z"
      },
      {
        "end_date": "2022-01-23T00:00:00.000Z",
        "start_date": "2022-01-22T00:00:00.000Z"
      },
      {
        "end_date": "2023-01-27T11:00:00.000Z",
        "start_date": "2023-01-27T03:00:00.000Z"
      },
      {
        "end_date": "2023-11-30T13:23:51.533Z",
        "start_date": "2023-11-30T08:23:51.533Z"
      },
      {
        "end_date": "2023-11-29T13:23:50.818Z",
        "start_date": "2023-11-29T08:23:50.818Z"
      },
      {
        "end_date": "2023-11-28T13:23:50.209Z",
        "start_date": "2023-11-28T08:23:50.208Z"
      },
      {
        "end_date": "2023-11-27T13:23:49.550Z",
        "start_date": "2023-11-27T08:23:49.550Z"
      },
      {
        "end_date": "2023-11-26T13:23:49.165Z",
        "start_date": "2023-11-26T08:23:49.165Z"
      },
      {
        "end_date": "2023-11-25T13:23:48.769Z",
        "start_date": "2023-11-25T08:23:48.769Z"
      },
      {
        "end_date": "2023-11-24T13:23:48.135Z",
        "start_date": "2023-11-24T08:23:48.135Z"
      },
      {
        "end_date": "2023-11-23T13:23:47.744Z",
        "start_date": "2023-11-23T08:23:47.744Z"
      },
      {
        "end_date": "2023-11-22T13:23:47.133Z",
        "start_date": "2023-11-22T08:23:47.132Z"
      },
      {
        "end_date": "2023-11-21T16:23:46.476Z",
        "start_date": "2023-11-21T08:23:46.476Z"
      },
      {
        "end_date": "2023-10-31T18:09:00.000Z",
        "start_date": "2023-10-31T18:06:00.000Z"
      }
    ]
  }
}
  
  """;

  final Map<String, dynamic> data = jsonDecode(jsonResponse);
  final List<LeaveRecord> leaveRecords = List<LeaveRecord>.from(
    data['data']['getLeaveRecords'].map(
      (record) => LeaveRecord.fromJson(record),
    ),
  );

  // Group leave records by month
  final Map<int, List<LeaveRecord>> recordsByMonth = {};

  for (LeaveRecord record in leaveRecords) {
    final int monthKey = record.start_date.month;
    print("MonthName:::: $monthKey ${getMonthName(monthKey)}");

    if (recordsByMonth.containsKey(monthKey)) {
      recordsByMonth[monthKey]!.add(record);
    } else {
      recordsByMonth[monthKey] = [record];
    }
  }

  //

  // Create a list of Month<LeaveRecords>
  final monthsList = recordsByMonth.entries
      .map(
        (entry) => Month(
          leaveRecords: entry.value,
          monthName: getMonthName(entry.key)
        ),
      )
      .toList();


  print(monthsList);

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Get the first date of the year
  DateTime firstDateOfYear = DateTime(DateTime.now().year, 1, 1);
  String formattedDate =
      DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, 12, 31));

  // Get the last date of the year
  DateTime lastDateOfYear = DateTime(DateTime.now().year, 12, 31);

  print('First date of the year: $formattedDate');
  print('Last date of the year: $lastDateOfYear');

}


String getMonthName(int monthIndex) {
  if (monthIndex < 1 || monthIndex > 12) {
    throw ArgumentError('Month index should be between 1 and 12');
  }

  return DateTime(2023, monthIndex).toString().split(' ')[0];
}

class LeaveRecord {
  final DateTime start_date;
  final DateTime end_date;


  @override
  String toString() {
    return 'LeaveRecord{start_date: $start_date, end_date: $end_date}';
  }

  LeaveRecord({
    required this.start_date,
    required this.end_date,
  });

  factory LeaveRecord.fromJson(Map<String, dynamic> json) {
    return LeaveRecord(
      start_date: DateTime.parse(json['start_date']),
      end_date: DateTime.parse(json['end_date']),
    );
  }
}

class Month {
  final String monthName;
  final List<LeaveRecord> leaveRecords;

  Month({required this.monthName, required this.leaveRecords});

  @override
  String toString() {
    return 'Month{monthName: $monthName, leaveRecords: $leaveRecords}';
  }
}
