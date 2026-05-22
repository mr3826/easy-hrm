class LeaveDetailsById {
  GetLeaveDetailsById? getLeaveDetailsById;

  LeaveDetailsById({this.getLeaveDetailsById});

  LeaveDetailsById.fromJson(Map<String, dynamic> json) {
    getLeaveDetailsById = json['getLeaveDetailsById'] != null
        ? GetLeaveDetailsById.fromJson(json['getLeaveDetailsById'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getLeaveDetailsById != null) {
      data['getLeaveDetailsById'] = getLeaveDetailsById!.toJson();
    }
    return data;
  }
}

class GetLeaveDetailsById {
  String? id;
  String? createdAt;
  dynamic type;
  String? description;
  String? totalDuration;
  dynamic totalLeaveMinutes;
  String? status;
  String? startDate;
  OrganizationUser? organizationUser;
  LeaveType? leaveType;
  List<LeaveDetails>? leaveDetails;
  dynamic duration;
  String? endDate;
  List<Files>? files;
  dynamic numberOfDays;

  GetLeaveDetailsById(
      {this.id,
        this.createdAt,
        this.type,
        this.description,
        this.totalDuration,
        this.totalLeaveMinutes,
        this.status,
        this.startDate,
        this.organizationUser,
        this.leaveType,
        this.leaveDetails,
        this.duration,
        this.endDate,
        this.files,
        this.numberOfDays});

  GetLeaveDetailsById.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    type = json['type'];
    description = json['description'];
    totalDuration = json['total_duration'];
    totalLeaveMinutes = json['totalLeaveMinutes'];
    status = json['status'];
    startDate = json['start_date'];
    organizationUser = json['organization_user'] != null
        ? OrganizationUser.fromJson(json['organization_user'])
        : null;
    leaveType = json['leaveType'] != null
        ? LeaveType.fromJson(json['leaveType'])
        : null;
    if (json['leave_details'] != null) {
      leaveDetails = <LeaveDetails>[];
      json['leave_details'].forEach((v) {
        leaveDetails!.add(LeaveDetails.fromJson(v));
      });
    }
    duration = json['duration'];
    endDate = json['end_date'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    numberOfDays = json['number_of_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['type'] = type;
    data['description'] = description;
    data['total_duration'] = totalDuration;
    data['totalLeaveMinutes'] = totalLeaveMinutes;
    data['status'] = status;
    data['start_date'] = startDate;
    if (organizationUser != null) {
      data['organization_user'] = organizationUser!.toJson();
    }
    if (leaveType != null) {
      data['leaveType'] = leaveType!.toJson();
    }
    if (leaveDetails != null) {
      data['leave_details'] =
          leaveDetails!.map((v) => v.toJson()).toList();
    }
    data['duration'] = duration;
    data['end_date'] = endDate;
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    data['number_of_days'] = numberOfDays;
    return data;
  }
}

class OrganizationUser {
  String? id;
  Profile? profile;
  List<Roles>? roles;
  Roles? designation;

  OrganizationUser(
      {this.id, this.profile, this.roles, this.designation});

  OrganizationUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    designation = json['designation'] != null
        ? Roles.fromJson(json['designation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    if (designation != null) {
      data['designation'] = designation!.toJson();
    }
    return data;
  }
}

class Profile {
  dynamic userId;
  String? lastName;
  String? image;
  String? id;
  String? firstName;

  Profile({this.userId, this.lastName, this.image, this.id, this.firstName});

  Profile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    lastName = json['last_name'];
    image = json['image'];
    id = json['id'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['last_name'] = lastName;
    data['image'] = image;
    data['id'] = id;
    data['first_name'] = firstName;
    return data;
  }
}

class Roles {
  String? name;

  Roles({this.name});

  Roles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class LeaveType {
  String? id;
  String? name;
  String? type;
  dynamic calculateAllowanceBy;

  LeaveType({this.id, this.name, this.type, this.calculateAllowanceBy});

  LeaveType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    calculateAllowanceBy = json['calculate_allowance_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['calculate_allowance_by'] = calculateAllowanceBy;
    return data;
  }
}

class LeaveDetails {
  String? id;
  String? leaveId;
  String? date;
  int? leaveSeconds;
  int? scheduleSeconds;

  LeaveDetails(
      {this.id,
        this.leaveId,
        this.date,
        this.leaveSeconds,
        this.scheduleSeconds});

  LeaveDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveId = json['leave_id'];
    date = json['date'];
    leaveSeconds = json['leave_seconds'];
    scheduleSeconds = json['schedule_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_id'] = leaveId;
    data['date'] = date;
    data['leave_seconds'] = leaveSeconds;
    data['schedule_seconds'] = scheduleSeconds;
    return data;
  }
}

class Files {
  String? name;
  String? key;
  String? id;
  int? size;

  Files({this.name, this.key, this.id, this.size});

  Files.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    key = json['key'];
    id = json['id'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['key'] = key;
    data['id'] = id;
    data['size'] = size;
    return data;
  }
}