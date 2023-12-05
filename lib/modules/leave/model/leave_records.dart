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
  String? createdAt;
  LeaveType? leaveType;
  dynamic duration;
  String? status;

  GetLeaveRecords(
      {this.endDate,
        this.startDate,
        this.id,
        this.createdAt,
        this.leaveType,
        this.duration,
        this.status});

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
  }

}

class LeaveType {
  String? type;

  LeaveType({this.type});

  LeaveType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

}
