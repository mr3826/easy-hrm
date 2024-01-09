import 'leave_record_response.dart';

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
  List<Data>? leaveRequests;

  GetLeaveDetailsByDate({this.leaveRequests});

  GetLeaveDetailsByDate.fromJson(Map<String, dynamic> json) {
    if (json['leave_requests'] != null) {
      leaveRequests = <Data>[];
      json['leave_requests'].forEach((v) {
        leaveRequests!.add(Data.fromJson(v));
      });
    }
  }

}
