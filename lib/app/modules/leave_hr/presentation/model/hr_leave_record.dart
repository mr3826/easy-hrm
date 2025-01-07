class HrLeaveRecorde {
  List<GetLeaveRequests>? getLeaveRequests;

  HrLeaveRecorde({this.getLeaveRequests});

  HrLeaveRecorde.fromJson(Map<String, dynamic> json) {
    if (json['getLeaveRequests'] != null) {
      getLeaveRequests = <GetLeaveRequests>[];
      json['getLeaveRequests'].forEach((v) {
        getLeaveRequests!.add(new GetLeaveRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getLeaveRequests != null) {
      data['getLeaveRequests'] =
          this.getLeaveRequests!.map((v) => v.toJson()).toList();
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
        ? new LeaveType.fromJson(json['leaveType'])
        : null;
    if (json['leave_details'] != null) {
      leaveDetails = <LeaveDetails>[];
      json['leave_details'].forEach((v) {
        leaveDetails!.add(new LeaveDetails.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    organizationUser = json['organization_user'] != null
        ? new OrganizationUser.fromJson(json['organization_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['status'] = this.status;
    if (this.leaveType != null) {
      data['leaveType'] = this.leaveType!.toJson();
    }
    if (this.leaveDetails != null) {
      data['leave_details'] =
          this.leaveDetails!.map((v) => v.toJson()).toList();
    }
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.organizationUser != null) {
      data['organization_user'] = this.organizationUser!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['number_of_days'] = this.numberOfDays;
    data['number_of_applications'] = this.numberOfApplications;
    data['application_date'] = this.applicationDate;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_id'] = this.leaveId;
    data['leave_seconds'] = this.leaveSeconds;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['key'] = this.key;
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
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['designation'] = this.designation;
    data['status'] = this.status;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
