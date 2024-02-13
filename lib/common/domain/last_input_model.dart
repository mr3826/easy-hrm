import '../../modules/leave/model/leave_record_response.dart';

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
  String? createdAt;
  List<Files>? files;
  LeaveType? leaveType;
  dynamic numberOfDays;
  String? leaveId;
  String? taskId;
  String? taskName;
  String? projectId;
  String? projectName;
  String? projectColor;

  ModelForDescription(
      {this.status,
      this.description,
      this.timeLId,
      this.startDate,
      this.endDate,
      this.duration,
      this.taskName,
      this.createdAt,
      this.files,
      this.leaveType,
      this.numberOfDays,
      this.leaveId,
      this.taskId,
      this.projectId,
      this.projectName,
      this.projectColor});

  ModelForDescription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    description = json['description'];
    timeLId = json['timeLId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    if (json['files'] != null) {
      files = List<Files>.from(json['files'].map((x) => Files.fromJson(x)));
    }
    leaveType = json['leaveType'] != null
        ? LeaveType.fromJson(json['leaveType'])
        : null;
    numberOfDays = json['numberOfDays'];
    leaveId = json['leaveId'];
    taskName = json['taskName'];
    taskId = json['taskId'];
    projectId = json['projectId'];
    projectName = json['projectName'];
    projectColor = json['projectColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['description'] = description;
    data['timeLId'] = timeLId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['duration'] = duration;
    data['taskName'] = taskName;
    data['createdAt'] = createdAt;
    if (files != null) {
      data['files'] = files!.map((x) => x.toJson()).toList();
    }
    if (leaveType != null) {
      data['leaveType'] = leaveType!.toJson();
    }
    data['numberOfDays'] = numberOfDays;
    data['leaveId'] = leaveId;
    data['projectColor'] = projectColor;
    data['projectName'] = projectName;
    data['projectId'] = projectId;
    data['taskId'] = taskId;
    return data;
  }
}

class Files {
  String? name;
  dynamic size;
  dynamic createdAt;
  String? key;
  String? id;

  Files({this.name, this.size, this.createdAt, this.key, this.id});

  Files.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    size = json['size'];
    createdAt = json['createdAt'];
    key = json['key'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['size'] = size;
    data['createdAt'] = createdAt;
    data['key'] = key;
    data['id'] = id;
    return data;
  }
}

class LeaveType {
  String? type;
  String? leaveId;
  String? leaveName;
  bool? isAddNoteRequired;
  bool? isAttachDocumentRequired;

  LeaveType({
    this.type,
    this.leaveId,
    this.leaveName,
    this.isAddNoteRequired,
    this.isAttachDocumentRequired,
  });

  LeaveType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    leaveId = json['leaveId'];
    leaveName = json['leaveName'];
    isAddNoteRequired = json['isAddNoteRequired'];
    isAttachDocumentRequired = json['isAttachDocumentRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['leaveId'] = leaveId;
    data['leaveName'] = leaveName;
    data['isAddNoteRequired'] = isAddNoteRequired;
    data['isAttachDocumentRequired'] = isAttachDocumentRequired;
    return data;
  }
}
