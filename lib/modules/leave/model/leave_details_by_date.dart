import 'package:payrun_mobile/modules/leave/model/leave_records.dart';

class LeaveDetailsByDate {
  List<GetLeaveDetailsByDate>? getLeaveDetailsByDate;

  LeaveDetailsByDate({this.getLeaveDetailsByDate});

  LeaveDetailsByDate.fromJson(Map<String, dynamic> json) {
    if (json['getLeaveDetailsByDate'] != null) {
      getLeaveDetailsByDate = <GetLeaveDetailsByDate>[];
      json['getLeaveDetailsByDate'].forEach((v) {
        getLeaveDetailsByDate!.add(GetLeaveDetailsByDate.fromJson(v));
      });
    }
  }
}

class GetLeaveDetailsByDate {
  List<GetLeaveRecords>? leaveRequests;

  GetLeaveDetailsByDate({this.leaveRequests});

  GetLeaveDetailsByDate.fromJson(Map<String, dynamic> json) {
    if (json['leave_requests'] != null) {
      leaveRequests = <GetLeaveRecords>[];
      json['leave_requests'].forEach((v) {
        leaveRequests!.add(GetLeaveRecords.fromJson(v));
      });
    }
  }
}