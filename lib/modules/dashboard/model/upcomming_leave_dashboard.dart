import '../../../common/domain/files_model.dart';
import '../../leave/model/leave_record_response.dart';

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
  LeaveType? leaveType;
  List<Files>?files;


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
