class HrLeaveRecorde {
  List<GetLeaveRequests>? getLeaveRequests;

  HrLeaveRecorde({this.getLeaveRequests});

  HrLeaveRecorde.fromJson(Map<String, dynamic> json) {
    if (json['getLeaveRequests'] != null) {
      getLeaveRequests = <GetLeaveRequests>[];
      json['getLeaveRequests'].forEach((v) {
        getLeaveRequests!.add(GetLeaveRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getLeaveRequests != null) {
      data['getLeaveRequests'] =
          getLeaveRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetLeaveRequests {
  String? id;
  String? startDate;
  String? endDate;
  String? description;
  String? status;
  LeaveType? leaveType;
  List<LeaveDetails>? leaveDetails;
  List<Files>? files;
  OrganizationUser? organizationUser;

  GetLeaveRequests(
      {this.id,
        this.startDate,
        this.endDate,
        this.description,
        this.status,
        this.leaveType,
        this.leaveDetails,
        this.files,
        this.organizationUser});

  GetLeaveRequests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    status = json['status'];
    leaveType = json['leaveType'] != null
        ? LeaveType.fromJson(json['leaveType'])
        : null;
    if (json['leave_details'] != null) {
      leaveDetails = <LeaveDetails>[];
      json['leave_details'].forEach((v) {
        leaveDetails!.add(LeaveDetails.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    organizationUser = json['organization_user'] != null
        ? OrganizationUser.fromJson(json['organization_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['description'] = description;
    data['status'] = status;
    if (leaveType != null) {
      data['leaveType'] = leaveType!.toJson();
    }
    if (leaveDetails != null) {
      data['leave_details'] =
          leaveDetails!.map((v) => v.toJson()).toList();
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    if (organizationUser != null) {
      data['organization_user'] = organizationUser!.toJson();
    }
    return data;
  }
}

class LeaveType {
  String? id;
  String? name;
  String? type;
  dynamic numberOfDays;
  dynamic numberOfApplications;
  dynamic applicationDate;

  LeaveType(
      {this.id,
        this.name,
        this.type,
        this.numberOfDays,
        this.numberOfApplications,
        this.applicationDate});

  LeaveType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    numberOfDays = json['number_of_days'];
    numberOfApplications = json['number_of_applications'];
    applicationDate = json['application_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['number_of_days'] = numberOfDays;
    data['number_of_applications'] = numberOfApplications;
    data['application_date'] = applicationDate;
    return data;
  }
}

class LeaveDetails {
  String? leaveId;
  int? leaveSeconds;

  LeaveDetails({this.leaveId, this.leaveSeconds});

  LeaveDetails.fromJson(Map<String, dynamic> json) {
    leaveId = json['leave_id'];
    leaveSeconds = json['leave_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leave_id'] = leaveId;
    data['leave_seconds'] = leaveSeconds;
    return data;
  }
}

class Files {
  String? id;
  String? name;
  int? size;
  String? key;

  Files({this.id, this.name, this.size, this.key});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['size'] = size;
    data['key'] = key;
    return data;
  }
}

class OrganizationUser {
  dynamic designation;
  dynamic status;
  Profile? profile;
  Department? department;

  OrganizationUser(
      {this.designation, this.status, this.profile, this.department});

  OrganizationUser.fromJson(Map<String, dynamic> json) {
    designation = json['designation'];
    status = json['status'];
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['designation'] = designation;
    data['status'] = status;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (department != null) {
      data['department'] = department!.toJson();
    }
    return data;
  }
}

class Profile {
  String? id;
  String? firstName;
  String? lastName;
  dynamic image;

  Profile({this.id, this.firstName, this.lastName, this.image});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
    return data;
  }
}

class Department {
  String? id;
  String? name;

  Department({this.id, this.name});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}