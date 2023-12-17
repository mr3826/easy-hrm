import '../../leave/model/leave_records.dart';

class UpcommingLeaveDashboard {
  List<GetUpcomingLeavesForApp>? getUpcomingLeavesForApp;

  UpcommingLeaveDashboard({this.getUpcomingLeavesForApp});

  UpcommingLeaveDashboard.fromJson(Map<String, dynamic> json) {
    if (json['getUpcomingLeavesForApp'] != null) {
      getUpcomingLeavesForApp = <GetUpcomingLeavesForApp>[];
      json['getUpcomingLeavesForApp'].forEach((v) {
        getUpcomingLeavesForApp!.add(GetUpcomingLeavesForApp.fromJson(v));
      });
    }
  }
}

class GetUpcomingLeavesForApp {
  String? endDate;
  String? startDate;
  String? status;
  String? createdAt;
  dynamic numberOfDays;
  LeaveType? leaveType;

  GetUpcomingLeavesForApp(
      {this.endDate,
      this.startDate,
      this.status,
      this.createdAt,
      this.numberOfDays});

  GetUpcomingLeavesForApp.fromJson(Map<String, dynamic> json) {
    endDate = json['end_date'];
    startDate = json['start_date'];
    status = json['status'];
    createdAt = json['createdAt'];
    numberOfDays = json['number_of_days'];
    leaveType = json['leaveType'] != null
        ? LeaveType.fromJson(json['leaveType'])
        : null;
  }
}
