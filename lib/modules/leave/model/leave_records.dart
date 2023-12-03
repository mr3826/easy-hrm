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
  String? description;
  String? endDate;
  String? startDate;
  String? status;
  dynamic duration;
  LeaveType? leaveType;

  GetLeaveRecords(
      {this.description,
        this.endDate,
        this.startDate,
        this.status,
        this.duration,
        this.leaveType});

  GetLeaveRecords.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    status = json['status'];
    duration = json['duration'];
    leaveType = json['leaveType'] != null
        ? LeaveType.fromJson(json['leaveType'])
        : null;
  }

}

class LeaveType {
  String? type;

  LeaveType({this.type});

  LeaveType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

}
