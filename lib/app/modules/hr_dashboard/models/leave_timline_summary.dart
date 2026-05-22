class LeaveTimeLogSummary {
  GetLeaveAndTimelogRequestSummary? getLeaveAndTimelogRequestSummary;

  LeaveTimeLogSummary({this.getLeaveAndTimelogRequestSummary});

  LeaveTimeLogSummary.fromJson(Map<String, dynamic> json) {
    getLeaveAndTimelogRequestSummary =
    json['getLeaveAndTimelogRequestSummary'] != null
        ? GetLeaveAndTimelogRequestSummary.fromJson(
        json['getLeaveAndTimelogRequestSummary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getLeaveAndTimelogRequestSummary != null) {
      data['getLeaveAndTimelogRequestSummary'] =
          getLeaveAndTimelogRequestSummary!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_candidates'] = totalCandidates;
    data['leave_request'] = leaveRequest;
    data['timelog_request'] = timelogRequest;
    return data;
  }
}
