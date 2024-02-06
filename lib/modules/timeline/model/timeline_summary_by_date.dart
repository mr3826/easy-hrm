class TimelineSummaryByDate {
  GetTimelogSummaryForApp? getTimelogSummaryForApp;

  TimelineSummaryByDate({this.getTimelogSummaryForApp});

  TimelineSummaryByDate.fromJson(Map<String, dynamic> json) {
    getTimelogSummaryForApp = json['getTimelogSummaryForApp'] != null
        ? GetTimelogSummaryForApp.fromJson(json['getTimelogSummaryForApp'])
        : null;
  }
}

class GetTimelogSummaryForApp {
  String? totalSchedule;
  String? totalLogged;
  String? paidLeave;
  String? balanced;

  GetTimelogSummaryForApp(
      {this.totalSchedule, this.totalLogged, this.paidLeave, this.balanced});

  GetTimelogSummaryForApp.fromJson(Map<String, dynamic> json) {
    totalSchedule = json['total_schedule'];
    totalLogged = json['total_logged'];
    paidLeave = json['paid_leave'];
    balanced = json['balanced'];
  }
}

class TimelineSummaryByMonth {
  GetTimelogSummaryForApp? getTimelogSummaryForApp;

  TimelineSummaryByMonth({this.getTimelogSummaryForApp});

  TimelineSummaryByMonth.fromJson(Map<String, dynamic> json) {
    getTimelogSummaryForApp = json['getTimelogSummaryForApp'] != null
        ?  GetTimelogSummaryForApp.fromJson(json['getTimelogSummaryForApp'])
        : null;
  }

}


