class EmployeeOverview {
  GetEmployeeOverview? getEmployeeOverview;

  EmployeeOverview({this.getEmployeeOverview});

  EmployeeOverview.fromJson(Map<String, dynamic> json) {
    getEmployeeOverview = json['getEmployeeOverview'] != null
        ? GetEmployeeOverview.fromJson(json['getEmployeeOverview'])
        : null;
  }

}

class GetEmployeeOverview {
  int? workingToday;
  int? onLeaveToday;
  int? notWorkingToday;

  GetEmployeeOverview(
      {this.workingToday, this.onLeaveToday, this.notWorkingToday});

  GetEmployeeOverview.fromJson(Map<String, dynamic> json) {
    workingToday = json['working_today'];
    onLeaveToday = json['on_leave_today'];
    notWorkingToday = json['not_working_today'];
  }

}
