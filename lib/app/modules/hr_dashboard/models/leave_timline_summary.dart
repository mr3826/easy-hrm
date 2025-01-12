class LeaveTimeLogSummary {
  GetLeaveAndTimelogRequestSummary? getLeaveAndTimelogRequestSummary;

  LeaveTimeLogSummary({this.getLeaveAndTimelogRequestSummary});

  LeaveTimeLogSummary.fromJson(Map<String, dynamic> json) {
    getLeaveAndTimelogRequestSummary =
    json['getLeaveAndTimelogRequestSummary'] != null
        ? new GetLeaveAndTimelogRequestSummary.fromJson(
        json['getLeaveAndTimelogRequestSummary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getLeaveAndTimelogRequestSummary != null) {
      data['getLeaveAndTimelogRequestSummary'] =
          this.getLeaveAndTimelogRequestSummary!.toJson();
    }
    return data;
  }
}

class GetLeaveAndTimelogRequestSummary {
  int? totalCandidates;
  int? leaveRequest;
  int? timelogRequest;

  GetLeaveAndTimelogRequestSummary(
      {this.totalCandidates, this.leaveRequest, this.timelogRequest});

  GetLeaveAndTimelogRequestSummary.fromJson(Map<String, dynamic> json) {
    totalCandidates = json['total_candidates'];
    leaveRequest = json['leave_request'];
    timelogRequest = json['timelog_request'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_candidates'] = this.totalCandidates;
    data['leave_request'] = this.leaveRequest;
    data['timelog_request'] = this.timelogRequest;
    return data;
  }
}
