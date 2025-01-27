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
        ? new GetTimelogSummaryForApp.fromJson(json['getSummaryForTimelines'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getTimelogSummaryForApp != null) {
      data['getSummaryForTimelines'] = this.getTimelogSummaryForApp!.toJson();
    }
    return data;
  }
}

class GetTimelogSummaryForApp {
  dynamic totalScheduledSeconds;
  dynamic loggedTotalSeconds;
  dynamic totalLeavesSeconds;
  dynamic balance;

  GetTimelogSummaryForApp(
      {this.totalScheduledSeconds,
        this.loggedTotalSeconds,
        this.totalLeavesSeconds,
        this.balance});

  GetTimelogSummaryForApp.fromJson(Map<String, dynamic> json) {
    totalScheduledSeconds = json['total_scheduled_seconds'];
    loggedTotalSeconds = json['logged_total_seconds'];
    totalLeavesSeconds = json['total_leaves_seconds'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_scheduled_seconds'] = this.totalScheduledSeconds;
    data['logged_total_seconds'] = this.loggedTotalSeconds;
    data['total_leaves_seconds'] = this.totalLeavesSeconds;
    data['balance'] = this.balance;
    return data;
  }
}
