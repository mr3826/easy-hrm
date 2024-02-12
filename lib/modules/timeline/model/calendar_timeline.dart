import '../../leave/model/leave_record_response.dart';

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
  List<Data>? leaves;
  List<Timelines>? timelines;

  GetCalenderTimelinesForApp({this.leaves, this.timelines});

  GetCalenderTimelinesForApp.fromJson(Map<String, dynamic> json) {
    if (json['leaves'] != null) {
      leaves = <Data>[];
      json['leaves'].forEach((v) {
        leaves!.add(Data.fromJson(v));
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

class Timelines {
  String? id;
  String? description;
  String? endDate;
  String? startDate;
  String? status;
  Task? task;
  String? totalMinutes;
  Project? project;

  Timelines(
      {this.id,
      this.description,
      this.endDate,
      this.startDate,
      this.status,
      this.task,
      this.totalMinutes,
      this.project});

  Timelines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    status = json['status'];
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
    totalMinutes = json['total_minutes'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
  }
}

class Task {
  String? name;
  String? id;
  Task({this.name, this.id});

  Task.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
}

class Project {
  String? id;
  String? name;
  String? color;

  Project({this.id, this.name, this.color});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }
}
