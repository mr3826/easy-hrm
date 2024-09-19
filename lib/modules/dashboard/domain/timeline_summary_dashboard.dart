class TimelineSummaryDashboard {
  GetMonthlyTimelog? getMonthlyTimelog;

  TimelineSummaryDashboard({this.getMonthlyTimelog});

  TimelineSummaryDashboard.fromJson(Map<String, dynamic> json) {
    getMonthlyTimelog = json['getMonthlyTimelog'] != null
        ?  GetMonthlyTimelog.fromJson(json['getMonthlyTimelog'])
        : null;
  }


}

class GetMonthlyTimelog {
  String? progressPercentage;
  String? totalSchedule;
  String? totalLogged;

  GetMonthlyTimelog(
      {this.progressPercentage, this.totalSchedule, this.totalLogged});

  GetMonthlyTimelog.fromJson(Map<String, dynamic> json) {
    progressPercentage = json['progress_percentage'];
    totalSchedule = json['total_schedule'];
    totalLogged = json['total_logged'];
  }

}
