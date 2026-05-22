import '../../../../modules/leave/domain/leave_record_response.dart';


class CalendarTimeline {
  GetCalenderTimelinesForApp? getCalenderTimelinesForApp;

  CalendarTimeline({this.getCalenderTimelinesForApp});

  CalendarTimeline.fromJson(Map<String, dynamic> json) {
    getCalenderTimelinesForApp = json['getCalenderTimelines'] != null
        ? GetCalenderTimelinesForApp.fromJson(
        json['getCalenderTimelines'])
        : null;
  }

}

class GetCalenderTimelinesForApp {
  CalendarData? data;
  GetCalenderTimelinesForApp({this.data});

  GetCalenderTimelinesForApp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CalendarData.fromJson(json['data']) : null;
  }

}


class CalendarData {

  List<Data>? leaves;
  List<Timelines>? timelines;

  CalendarData({this.leaves, this.timelines});

  CalendarData.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['end_date'] = endDate;
    data['start_date'] = startDate;
    data['status'] = status;
    data['task'] = task;
    data['total_minutes'] = totalMinutes;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}
