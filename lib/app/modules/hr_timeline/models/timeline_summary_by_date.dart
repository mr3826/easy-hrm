class TimelineSummaryByMonth {
  GetTimelogSummaryForApp? getTimelogSummaryForApp;

  TimelineSummaryByMonth({this.getTimelogSummaryForApp});

  TimelineSummaryByMonth.fromJson(Map<String, dynamic> json) {
    getTimelogSummaryForApp = json['getSummaryForTimelines'] != null
        ?  GetTimelogSummaryForApp.fromJson(json['getSummaryForTimelines'])
        : null;
  }

}


class TimelineSummaryByDate {
  GetTimelogSummaryForApp? getTimelogSummaryForApp;

  TimelineSummaryByDate({this.getTimelogSummaryForApp});

  TimelineSummaryByDate.fromJson(Map<String, dynamic> json) {
    getTimelogSummaryForApp = json['getSummaryForTimelines'] != null
        ? GetTimelogSummaryForApp.fromJson(json['getSummaryForTimelines'])
        : null;
  }
}

class GetTimelogSummaryForApp {
  String? totalScheduledSeconds;
  String ?loggedTotalSeconds;
  String ?totalLeavesSeconds;
  String ?balance;
  String ?totalPendingSeconds;

  GetTimelogSummaryForApp(
      {this.totalScheduledSeconds,
        this.loggedTotalSeconds,
        this.totalLeavesSeconds,
        this.totalPendingSeconds,
        this.balance});

  GetTimelogSummaryForApp.fromJson(Map<String, dynamic> json) {
    totalScheduledSeconds = json['total_scheduled_seconds'];
    loggedTotalSeconds = json['logged_total_seconds'];
    totalLeavesSeconds = json['total_leaves_seconds'];
    totalPendingSeconds = json['pending_total_seconds'];
    balance = json['balance'];
  }


}
