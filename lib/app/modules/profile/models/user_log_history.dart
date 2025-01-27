class UserLogHistory {
  GeTimelogAndLeaveAvailabilityForApp? geTimelogAndLeaveAvailabilityForApp;

  UserLogHistory({this.geTimelogAndLeaveAvailabilityForApp});

  UserLogHistory.fromJson(Map<String, dynamic> json) {
    geTimelogAndLeaveAvailabilityForApp =
    json['geTimelogAndLeaveAvailabilityForApp'] != null
        ? GeTimelogAndLeaveAvailabilityForApp.fromJson(
        json['geTimelogAndLeaveAvailabilityForApp'])
        : null;
  }
}

class GeTimelogAndLeaveAvailabilityForApp {
  String? totalLogged;
  String? totalSchedule;
  String? balanceLeave;

  GeTimelogAndLeaveAvailabilityForApp(
      {this.totalLogged, this.totalSchedule, this.balanceLeave});

  GeTimelogAndLeaveAvailabilityForApp.fromJson(Map<String, dynamic> json) {
    totalLogged = json['total_logged'];
    totalSchedule = json['total_schedule'];
    balanceLeave = json['balance_leave'];
  }

}
