class LastInput {
  String? email;
  String? password;
  String? orgName;

  LastInput({this.email, this.password, this.orgName});

  LastInput.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    orgName = json['org_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['org_name'] = orgName;
    return data;
  }
}

class ModelForDescription {
  String? status;
  String? description;
  String? timeLId;
  String? startDate;
  String? endDate;
  String? duration;
  String? taskName;

  ModelForDescription(
      {this.status,
      this.description,
      this.timeLId,
      this.endDate,
      this.startDate,
      this.duration,
      this.taskName});

  ModelForDescription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    description = json['description'];
    timeLId = json['timeLId'];
    endDate = json['endDate'];
    startDate = json['startDate'];
    duration = json['duration'];
    taskName = json['taskName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['status'] = status;
    data['description'] = description;
    data['timeLId'] = timeLId;
    data['endDate'] = endDate;
    data['startDate'] = startDate;
    data['duration'] = duration;
    data['taskName'] = taskName;

    return data;
  }
}
