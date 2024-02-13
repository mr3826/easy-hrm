import 'leave_record_response.dart';

class LeaveDetailsByDate {
  List<Data>? getLeaveRequests;

  LeaveDetailsByDate({this.getLeaveRequests});

  LeaveDetailsByDate.fromJson(Map<String, dynamic> json) {
    if (json['getLeaveRequests'] != null) {
      getLeaveRequests = <Data>[];
      json['getLeaveRequests'].forEach((v) {
        getLeaveRequests!.add(Data.fromJson(v));
      });
    }
  }
}
