class CalendarTimeline {
  GetCalenderTimelinesForApp? getCalenderTimelinesForApp;

  CalendarTimeline({this.getCalenderTimelinesForApp});

  CalendarTimeline.fromJson(Map<String, dynamic> json) {
    getCalenderTimelinesForApp = json['getCalenderTimelinesForApp'] != null
        ? GetCalenderTimelinesForApp.fromJson(
            json['getCalenderTimelinesForApp'])
        : null;
  }
}

class GetCalenderTimelinesForApp {
  List<Leaves>? leaves;
  List<Timelines>? timelines;

  GetCalenderTimelinesForApp({this.leaves, this.timelines});

  GetCalenderTimelinesForApp.fromJson(Map<String, dynamic> json) {
    if (json['leaves'] != null) {
      leaves = <Leaves>[];
      json['leaves'].forEach((v) {
        leaves!.add(Leaves.fromJson(v));
      });
    }
    if (json['timelines'] != null) {
      timelines = <Timelines>[];
      json['timelines'].forEach((v) {
        timelines!.add(Timelines.fromJson(v));
      });
    }
  }
}

class Leaves {
  String? createdAt;
  String? description;
  String? endDate;
  LeaveType? leaveType;
  String? startDate;
  String? status;
  String? totalLeaveMinutes;

  Leaves(
      {this.createdAt,
      this.description,
      this.endDate,
      this.leaveType,
      this.startDate,
      this.status,
      this.totalLeaveMinutes});

  Leaves.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    description = json['description'];
    endDate = json['end_date'];
    leaveType = json['leaveType'] != null
        ? LeaveType.fromJson(json['leaveType'])
        : null;
    startDate = json['start_date'];
    status = json['status'];
    totalLeaveMinutes = json['totalLeaveMinutes'];
  }
}

class LeaveType {
  String? name;
  String? type;
  String? id;

  LeaveType({this.name, this.type, this.id});

  LeaveType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    id = json['id'];
  }
}

class Timelines {
  String? description;
  String? endDate;
  String? startDate;
  String? status;
  Task? task;
  String? totalMinutes;

  Timelines(
      {this.description,
      this.endDate,
      this.startDate,
      this.status,
      this.task,
      this.totalMinutes});

  Timelines.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    status = json['status'];
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
    totalMinutes = json['total_minutes'];
  }
}

class Task {
  String? name;
  String? id;
  Project? project;

  Task({this.name, this.id, this.project});

  Task.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
  }
}

class Project {
  String? id;
  String? name;

  Project({this.id, this.name});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
