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
  List<LeaveRequests>? leaveRequests;

  GetLeaveDetailsByDate({this.leaveRequests});

  GetLeaveDetailsByDate.fromJson(Map<String, dynamic> json) {
    if (json['leave_requests'] != null) {
      leaveRequests = <LeaveRequests>[];
      json['leave_requests'].forEach((v) {
        leaveRequests!.add(LeaveRequests.fromJson(v));
      });
    }
  }
}

class LeaveRequests {
  String? status;
  LeaveType? leaveType;
  dynamic duration;
  String? createdAt;

  LeaveRequests({this.status, this.leaveType, this.duration, this.createdAt});

  LeaveRequests.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    leaveType = json['leaveType'] != null
        ? LeaveType.fromJson(json['leaveType'])
        : null;
    duration = json['duration'];
    createdAt = json['createdAt'];
  }
}

class LeaveType {
  String? type;

  LeaveType({this.type});

  LeaveType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }
}
