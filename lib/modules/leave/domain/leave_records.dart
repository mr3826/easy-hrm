import '../../../common/domain/files_model.dart';
import 'leave_record_response.dart';

class LeaveRecords {
  List<GetLeaveRecords>? getLeaveRecords;

  LeaveRecords({this.getLeaveRecords});

  LeaveRecords.fromJson(Map<String, dynamic> json) {
    if (json['getLeaveRecords'] != null) {
      getLeaveRecords = <GetLeaveRecords>[];
      json['getLeaveRecords'].forEach((v) {
        getLeaveRecords!.add(GetLeaveRecords.fromJson(v));
      });
    }
  }
}

class GetLeaveRecords {
  String? endDate;
  String? startDate;
  String? id;
  String? description;
  String? createdAt;
  LeaveType? leaveType;
  dynamic duration;
  String? status;
  List<Files>? files;
  List<LeaveDetails>? leaveDetails;

  GetLeaveRecords(
      {this.endDate,
      this.startDate,
      this.id,
      this.createdAt,
      this.leaveType,
      this.files,
      this.duration,
       this.leaveDetails,
      this.status,
      this.description});

  GetLeaveRecords.fromJson(Map<String, dynamic> json) {
    endDate = json['end_date'];
    startDate = json['start_date'];
    id = json['id'];
    createdAt = json['createdAt'];
    leaveType = json['leaveType'] != null
        ? LeaveType.fromJson(json['leaveType'])
        : null;
    duration = json['duration'];
    status = json['status'];
    description = json['description'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schedule_hour'] = scheduleHour;
    data['leave_hour'] = leaveHour;
    data['date'] = date;
    return data;
  }
}
