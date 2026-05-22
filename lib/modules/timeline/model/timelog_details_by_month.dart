class TimelogDetailsByMonth {
  GetDailyTimeEntries? getDailyTimeEntries;

  TimelogDetailsByMonth({this.getDailyTimeEntries});

  TimelogDetailsByMonth.fromJson(Map<String, dynamic> json) {
    getDailyTimeEntries = json['getDailyTimeEntries'] != null
        ? GetDailyTimeEntries.fromJson(json['getDailyTimeEntries'])
        : null;
  }
}

class GetDailyTimeEntries {
  List<Data>? data;

  GetDailyTimeEntries({this.data});

  GetDailyTimeEntries.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

}

class Data {
  String? entryDay;
  String? totalScheduledSeconds;
  String? loggedTotalSeconds;
  String? totalLeavesSeconds;
  String? balance;
  bool? isFlaggedTimelog;

  Data(
      {this.entryDay,
        this.totalScheduledSeconds,
        this.loggedTotalSeconds,
        this.totalLeavesSeconds,
        this.isFlaggedTimelog,
        this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    entryDay = json['entry_day'];
    totalScheduledSeconds = json['total_scheduled_seconds'];
    isFlaggedTimelog = json['is_flagged_timelog'];
    loggedTotalSeconds = json['logged_total_seconds'];
    totalLeavesSeconds = json['total_leaves_seconds'];
    balance = json['balance'];
  }

}


