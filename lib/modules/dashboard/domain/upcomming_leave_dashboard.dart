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
        leaveDetails!.add(new LeaveDetails.fromJson(v));
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
  String? scheduleHour;
  String? leaveHour;
  String? date;

  LeaveDetails({this.scheduleHour, this.leaveHour, this.date});

  LeaveDetails.fromJson(Map<String, dynamic> json) {
    scheduleHour = json['schedule_hour'];
    leaveHour = json['leave_hour'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schedule_hour'] = this.scheduleHour;
    data['leave_hour'] = this.leaveHour;
    data['date'] = this.date;
    return data;
  }
}
