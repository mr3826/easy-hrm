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
  String? description;
  String? loggedTotalSeconds;
  String? orgUserId;
  bool? isFlaggedTimelog;
  Project? project;
  dynamic task;

  Data(
      {this.id,
        this.startDate,
        this.endDate,
        this.status,
        this.description,
        this.loggedTotalSeconds,
        this.orgUserId,
        this.isFlaggedTimelog,
        this.project,
        this.task});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    description = json['description'];
    loggedTotalSeconds = json['logged_total_seconds'];
    orgUserId = json['org_user_id'];
    isFlaggedTimelog = json['is_flagged_timelog'];
    project =
    json['project'] != null ? new Project.fromJson(json['project']) : null;
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['description'] = this.description;
    data['logged_total_seconds'] = this.loggedTotalSeconds;
    data['org_user_id'] = this.orgUserId;
    data['is_flagged_timelog'] = this.isFlaggedTimelog;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    data['task'] = this.task;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}
