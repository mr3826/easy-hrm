class TimelogDetailsByMonth {
  GetDailyTimeEntries? getDailyTimeEntries;

  TimelogDetailsByMonth({this.getDailyTimeEntries});

  TimelogDetailsByMonth.fromJson(Map<String, dynamic> json) {
    getDailyTimeEntries = json['getDailyTimeEntries'] != null
        ? new GetDailyTimeEntries.fromJson(json['getDailyTimeEntries'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getDailyTimeEntries != null) {
      data['getDailyTimeEntries'] = this.getDailyTimeEntries!.toJson();
    }
    return data;
  }
}

class GetDailyTimeEntries {
  List<Data>? data;

  GetDailyTimeEntries({this.data});

  GetDailyTimeEntries.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? entryDay;
  String? totalScheduledSeconds;
  String? loggedTotalSeconds;
  String? totalLeavesSeconds;
  String? balance;

  Data(
      {this.entryDay,
        this.totalScheduledSeconds,
        this.loggedTotalSeconds,
        this.totalLeavesSeconds,
        this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    entryDay = json['entry_day'];
    totalScheduledSeconds = json['total_scheduled_seconds'];
    loggedTotalSeconds = json['logged_total_seconds'];
    totalLeavesSeconds = json['total_leaves_seconds'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entry_day'] = this.entryDay;
    data['total_scheduled_seconds'] = this.totalScheduledSeconds;
    data['logged_total_seconds'] = this.loggedTotalSeconds;
    data['total_leaves_seconds'] = this.totalLeavesSeconds;
    data['balance'] = this.balance;
    return data;
  }
}


