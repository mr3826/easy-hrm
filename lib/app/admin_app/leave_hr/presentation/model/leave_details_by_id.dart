class LeaveDetailsById {
  GetLeaveDetailsById? getLeaveDetailsById;

  LeaveDetailsById({this.getLeaveDetailsById});

  LeaveDetailsById.fromJson(Map<String, dynamic> json) {
    getLeaveDetailsById = json['getLeaveDetailsById'] != null
        ? new GetLeaveDetailsById.fromJson(json['getLeaveDetailsById'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getLeaveDetailsById != null) {
      data['getLeaveDetailsById'] = this.getLeaveDetailsById!.toJson();
    }
    return data;
  }
}

class GetLeaveDetailsById {
  String? id;
  String? createdAt;
  String? type;
  String? description;
  String? totalDuration;
  String? totalLeaveMinutes;
  String? status;
  String? startDate;
  OrganizationUser? organizationUser;
  LeaveType? leaveType;
  List<LeaveDetails>? leaveDetails;
  String? duration;
  String? endDate;
  List<Files>? files;
  dynamic numberOfDays;
  String? sTypename;

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
        this.numberOfDays,
        this.sTypename});

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
        ? new OrganizationUser.fromJson(json['organization_user'])
        : null;
    leaveType = json['leaveType'] != null
        ? new LeaveType.fromJson(json['leaveType'])
        : null;
    if (json['leave_details'] != null) {
      leaveDetails = <LeaveDetails>[];
      json['leave_details'].forEach((v) {
        leaveDetails!.add(new LeaveDetails.fromJson(v));
      });
    }
    duration = json['duration'];
    endDate = json['end_date'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    numberOfDays = json['number_of_days'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['type'] = this.type;
    data['description'] = this.description;
    data['total_duration'] = this.totalDuration;
    data['totalLeaveMinutes'] = this.totalLeaveMinutes;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    if (this.organizationUser != null) {
      data['organization_user'] = this.organizationUser!.toJson();
    }
    if (this.leaveType != null) {
      data['leaveType'] = this.leaveType!.toJson();
    }
    if (this.leaveDetails != null) {
      data['leave_details'] =
          this.leaveDetails!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    data['end_date'] = this.endDate;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['number_of_days'] = this.numberOfDays;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class OrganizationUser {
  String? id;
  Profile? profile;
  List<Roles>? roles;
  String? designation;
  String? sTypename;

  OrganizationUser(
      {this.id, this.profile, this.roles, this.designation, this.sTypename});

  OrganizationUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    designation = json['designation'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['designation'] = this.designation;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Profile {
  String? userId;
  String? lastName;
  String? image;
  String? id;
  String? firstName;
  String? sTypename;

  Profile(
      {this.userId,
        this.lastName,
        this.image,
        this.id,
        this.firstName,
        this.sTypename});

  Profile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    lastName = json['last_name'];
    image = json['image'];
    id = json['id'];
    firstName = json['first_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Roles {
  String? name;
  String? sTypename;

  Roles({this.name, this.sTypename});

  Roles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class LeaveType {
  String? id;
  String? name;
  String? type;
  String? calculateAllowanceBy;
  String? sTypename;

  LeaveType(
      {this.id,
        this.name,
        this.type,
        this.calculateAllowanceBy,
        this.sTypename});

  LeaveType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    calculateAllowanceBy = json['calculate_allowance_by'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['calculate_allowance_by'] = this.calculateAllowanceBy;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class LeaveDetails {
  String?  id;
  String?  leaveId;
  String? date;
  int? leaveSeconds;
  int? scheduleSeconds;
  String? sTypename;

  LeaveDetails(
      {this.date, this.leaveSeconds, this.scheduleSeconds, this.sTypename,this.id,this.leaveId});

  LeaveDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveId = json['leave_id'];
    date = json['date'];
    leaveSeconds = json['leave_seconds'];
    scheduleSeconds = json['schedule_seconds'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leave_id'] = this.leaveId;
    data['date'] = this.date;
    data['leave_seconds'] = this.leaveSeconds;
    data['schedule_seconds'] = this.scheduleSeconds;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Files {
  String? name;
  String? key;
  String? id;
  String? size;
  String? sTypename;

  Files({this.name, this.key, this.id, this.size, this.sTypename});

  Files.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    key = json['key'];
    id = json['id'];
    size = json['size'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['key'] = this.key;
    data['id'] = this.id;
    data['size'] = this.size;
    data['__typename'] = this.sTypename;
    return data;
  }
}
