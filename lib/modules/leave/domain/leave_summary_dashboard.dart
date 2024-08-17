class LeaveSummaryForDashboard {
  GetLeaveSummaryForDashboard? getLeaveSummaryForDashboard;

  LeaveSummaryForDashboard({this.getLeaveSummaryForDashboard});

  LeaveSummaryForDashboard.fromJson(Map<String, dynamic> json) {
    getLeaveSummaryForDashboard = json['getLeaveSummaryForDashboard'] != null
        ? GetLeaveSummaryForDashboard.fromJson(
            json['getLeaveSummaryForDashboard'])
        : null;
  }
}

class GetLeaveSummaryForDashboard {
  String? totalLeaveDay;
  String? takenLeave;
  String? balanceLeave;

  GetLeaveSummaryForDashboard(
      {this.totalLeaveDay, this.takenLeave, this.balanceLeave});

  GetLeaveSummaryForDashboard.fromJson(Map<String, dynamic> json) {
    totalLeaveDay = json['total_leave_day'];
    takenLeave = json['taken_leave'];
    balanceLeave = json['balance_leave'];
  }
}
