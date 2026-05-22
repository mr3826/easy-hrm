import '../../../common/domain/files_model.dart';
import '../../leave/domain/leave_record_response.dart';

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
  String? id;
  String? endDate;
  String? startDate;
  String? status;
  String? createdAt;
  String? description;
  dynamic numberOfDays;
  List<LeaveDetails>? leaveDetails;
  LeaveType? leaveType;
  List<Files>? files;

  GetUpcomingLeavesForApp(
      {this.endDate,
      this.startDate,
      this.status,
      this.createdAt,
      this.numberOfDays,
      this.description,
      this.leaveType,
      this.files,
      this.id});

  GetUpcomingLeavesForApp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    status = json['status'];
    description = json['description'];
    createdAt = json['createdAt'];
    numberOfDays = json['number_of_days'];
    if (json['leave_details'] != null) {
      leaveDetails = <LeaveDetails>[];
      json['leave_details'].forEach((v) {
        leaveDetails!.add(LeaveDetails.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    leaveType = json['leaveType'] != null
        ? LeaveType.fromJson(json['leaveType'])
        : null;
  }
}

class LeaveDetails {
  int? scheduleSecond;
  int? leaveSecond;
  String? date;

  LeaveDetails({this.scheduleSecond, this.leaveSecond, this.date});

  LeaveDetails.fromJson(Map<String, dynamic> json) {
    scheduleSecond = json['schedule_seconds'];
    leaveSecond = json['leave_seconds'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schedule_seconds'] = scheduleSecond;
    data['leave_seconds'] = leaveSecond;
    data['date'] = date;
    return data;
  }
}
