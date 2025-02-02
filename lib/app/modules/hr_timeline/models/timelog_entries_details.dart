class TimeLogsEntriesDetails {
  GetTimeLineEntries? getTimeLineEntries;

  TimeLogsEntriesDetails({this.getTimeLineEntries});

  TimeLogsEntriesDetails.fromJson(Map<String, dynamic> json) {
    getTimeLineEntries = json['getTimeLineEntries'] != null
        ? new GetTimeLineEntries.fromJson(json['getTimeLineEntries'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getTimeLineEntries != null) {
      data['getTimeLineEntries'] = this.getTimeLineEntries!.toJson();
    }
    return data;
  }
}

class GetTimeLineEntries {
  List<Data>? data;

  GetTimeLineEntries({this.data});

  GetTimeLineEntries.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? startDate;
  String? endDate;
  String? status;
  Project? project;
  String? description;
  String? loggedTotalSeconds;
  String? orgUserId;
  bool? isFlaggedTimelog;
  Task? task;

  Data(
      {this.id,
        this.startDate,
        this.endDate,
        this.status,
        this.project,
        this.description,
        this.loggedTotalSeconds,
        this.orgUserId,
        this.isFlaggedTimelog,
        this.task});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    project =
    json['project'] != null ? new Project.fromJson(json['project']) : null;
    description = json['description'];
    loggedTotalSeconds = json['logged_total_seconds'];
    orgUserId = json['org_user_id'];
    isFlaggedTimelog = json['is_flagged_timelog'];
    task = json['task'] != null ? new Task.fromJson(json['task']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    data['description'] = this.description;
    data['logged_total_seconds'] = this.loggedTotalSeconds;
    data['org_user_id'] = this.orgUserId;
    data['is_flagged_timelog'] = this.isFlaggedTimelog;
    if (this.task != null) {
      data['task'] = this.task!.toJson();
    }
    return data;
  }
}

class Project {
  String? id;
  String? color;
  String? name;

  Project({this.id, this.color, this.name});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color'] = this.color;
    data['name'] = this.name;
    return data;
  }
}

class Task {
  String? id;
  String? name;
  String? projectId;
  Project? project;

  Task({this.id, this.name, this.projectId, this.project});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    projectId = json['project_id'];
    project =
    json['project'] != null ? new Project.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['project_id'] = this.projectId;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    return data;
  }
}
