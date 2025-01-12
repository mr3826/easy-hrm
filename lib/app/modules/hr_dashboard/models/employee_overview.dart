class EmployeeOverview {
  GetEmployeeOverview? getEmployeeOverview;

  EmployeeOverview({this.getEmployeeOverview});

  EmployeeOverview.fromJson(Map<String, dynamic> json) {
    getEmployeeOverview = json['getEmployeeOverview'] != null
        ? new GetEmployeeOverview.fromJson(json['getEmployeeOverview'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getEmployeeOverview != null) {
      data['getEmployeeOverview'] = this.getEmployeeOverview!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['working_today'] = this.workingToday;
    data['on_leave_today'] = this.onLeaveToday;
    data['not_working_today'] = this.notWorkingToday;
    return data;
  }
}
