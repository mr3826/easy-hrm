class TimelogDetailsByMonth {
  List<GetTimelogsForApp>? getTimelogsForApp;

  TimelogDetailsByMonth({this.getTimelogsForApp});

  TimelogDetailsByMonth.fromJson(Map<String, dynamic> json) {
    if (json['getTimelogsForApp'] != null) {
      getTimelogsForApp = <GetTimelogsForApp>[];
      json['getTimelogsForApp'].forEach((v) {
        getTimelogsForApp!.add(GetTimelogsForApp.fromJson(v));
      });
    }
  }
}

class GetTimelogsForApp {
  String? balance;
  String? date;
  String? day;
  String? leave;
  String? logged;
  String? schedule;

  GetTimelogsForApp(
      {this.balance, this.date, this.leave, this.logged, this.schedule,this.day});

  GetTimelogsForApp.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    date = json['date'];
    leave = json['leave'];
    logged = json['logged'];
    schedule = json['schedule'];
    day = json['day'];
  }
}
