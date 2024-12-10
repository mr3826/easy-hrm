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
  String? description;
  String? duration;
  String? endDate;
  String? totalDuration;
  dynamic numberOfDays;
  String? id;
  LeaveType? leaveType;
  List<LeaveDetails>? leaveDetails;
  String? startDate;
  String? status;
  String? type;
  String? userId;
  List<Files>? files;
  OrganizationUser? organizationUser;
  String? sTypename;

  GetLeaveRequests(
      {this.description,
        this.duration,
        this.endDate,
        this.totalDuration,
        this.numberOfDays,
        this.id,
        this.leaveType,
        this.leaveDetails,
        this.startDate,
        this.status,
        this.type,
        this.userId,
        this.files,
        this.organizationUser,
        this.sTypename});

  GetLeaveRequests.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    duration = json['duration'];
    endDate = json['end_date'];
    totalDuration = json['total_duration'];
    numberOfDays = json['number_of_days'];
    id = json['id'];
    leaveType = json['leaveType'] != null
        ? new LeaveType.fromJson(json['leaveType'])
        : null;
    if (json['leave_details'] != null) {
      leaveDetails = <LeaveDetails>[];
      json['leave_details'].forEach((v) {
        leaveDetails!.add(new LeaveDetails.fromJson(v));
      });
    }
    startDate = json['start_date'];
    status = json['status'];
    type = json['type'];
    userId = json['user_id'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    organizationUser = json['organization_user'] != null
        ? new OrganizationUser.fromJson(json['organization_user'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['end_date'] = this.endDate;
    data['total_duration'] = this.totalDuration;
    data['number_of_days'] = this.numberOfDays;
    data['id'] = this.id;
    if (this.leaveType != null) {
      data['leaveType'] = this.leaveType!.toJson();
    }
    if (this.leaveDetails != null) {
      data['leave_details'] =
          this.leaveDetails!.map((v) => v.toJson()).toList();
    }
    data['start_date'] = this.startDate;
    data['status'] = this.status;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.organizationUser != null) {
      data['organization_user'] = this.organizationUser!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class LeaveType {
  String? id;
  String? name;
  String? type;

  @override
  String toString() {
    return 'LeaveType{id: $id, name: $name, type: $type, numberOfDays: $numberOfDays, numberOfApplications: $numberOfApplications, maxConsecutiveDays: $maxConsecutiveDays, isDefault: $isDefault, addNoteRequired: $addNoteRequired, applicationDate: $applicationDate, calculateAllowanceBy: $calculateAllowanceBy, organizationId: $organizationId, isEnable: $isEnable, isEarned: $isEarned, leaveStatuses: $leaveStatuses}';
  }

  String? numberOfDays;
  String? numberOfApplications;
  String? maxConsecutiveDays;
  bool? isDefault;
  bool? addNoteRequired;
  String? applicationDate;
  String? calculateAllowanceBy;
  String? organizationId;
  String? isEnable;
  bool? isEarned;
  List<LeaveStatuses>? leaveStatuses;

  LeaveType(
      {this.id,
        this.name,
        this.type,
        this.numberOfDays,
        this.numberOfApplications,
        this.maxConsecutiveDays,
        this.isDefault,
        this.addNoteRequired,
        this.applicationDate,
        this.calculateAllowanceBy,
        this.organizationId,
        this.isEnable,
        this.isEarned,
        this.leaveStatuses});

  LeaveType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    numberOfDays = json['number_of_days'];
    numberOfApplications = json['number_of_applications'];
    maxConsecutiveDays = json['max_consecutive_days'];
    isDefault = json['is_default'];
    addNoteRequired = json['add_note_required'];
    applicationDate = json['application_date'];
    calculateAllowanceBy = json['calculate_allowance_by'];
    organizationId = json['organization_id'];
    isEnable = json['is_enable'];
    isEarned = json['is_earned'];
    if (json['leave_statuses'] != null) {
      leaveStatuses = <LeaveStatuses>[];
      json['leave_statuses'].forEach((v) {
        leaveStatuses!.add(new LeaveStatuses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['number_of_days'] = this.numberOfDays;
    data['number_of_applications'] = this.numberOfApplications;
    data['max_consecutive_days'] = this.maxConsecutiveDays;
    data['is_default'] = this.isDefault;
    data['add_note_required'] = this.addNoteRequired;
    data['application_date'] = this.applicationDate;
    data['calculate_allowance_by'] = this.calculateAllowanceBy;
    data['organization_id'] = this.organizationId;
    data['is_enable'] = this.isEnable;
    data['is_earned'] = this.isEarned;
    if (this.leaveStatuses != null) {
      data['leave_statuses'] =
          this.leaveStatuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveStatuses {
  dynamic availableNumberOfDays;
  dynamic earnedDays;
  dynamic availableNumberOfApplications;
  dynamic totalAvailable;

  LeaveStatuses(
      {this.availableNumberOfDays,
        this.earnedDays,
        this.availableNumberOfApplications,
        this.totalAvailable});

  LeaveStatuses.fromJson(Map<String, dynamic> json) {
    availableNumberOfDays = json['available_number_of_days'];
    earnedDays = json['earned_days'];
    availableNumberOfApplications = json['available_number_of_applications'];
    totalAvailable = json['total_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available_number_of_days'] = this.availableNumberOfDays;
    data['earned_days'] = this.earnedDays;
    data['available_number_of_applications'] =
        this.availableNumberOfApplications;
    data['total_available'] = this.totalAvailable;
    return data;
  }
}

class LeaveDetails {
  String? date;
  dynamic leaveSeconds;
  dynamic scheduleSeconds;
  String? leaveId;

  LeaveDetails({this.date, this.leaveSeconds, this.scheduleSeconds,this.leaveId});

  LeaveDetails.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    leaveId = json['leave_id'];
    leaveSeconds = json['leave_seconds'];
    scheduleSeconds = json['schedule_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['leave_id'] = this.leaveId;
    data['leave_seconds'] = this.leaveSeconds;
    data['schedule_seconds'] = this.scheduleSeconds;
    return data;
  }
}

class Files {
  String? size;
  String? organizationId;
  String? name;
  String? key;
  String? id;
  String? createdAt;
  String? context;

  Files(
      {this.size,
        this.organizationId,
        this.name,
        this.key,
        this.id,
        this.createdAt,
        this.context});

  Files.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    organizationId = json['organization_id'];
    name = json['name'];
    key = json['key'];
    id = json['id'];
    createdAt = json['createdAt'];
    context = json['context'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['organization_id'] = this.organizationId;
    data['name'] = this.name;
    data['key'] = this.key;
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['context'] = this.context;
    return data;
  }
}

class OrganizationUser {
  String? userPosition;
  String? userId;
  String? user;
  String? status;
  List<Roles>? roles;
  Profile? profile;
  String? organizationId;
  String? id;
  String? designation;
  Department? department;

  OrganizationUser(
      {this.userPosition,
        this.userId,
        this.user,
        this.status,
        this.roles,
        this.profile,
        this.organizationId,
        this.id,
        this.designation,
        this.department});

  OrganizationUser.fromJson(Map<String, dynamic> json) {
    userPosition = json['user_position'];
    userId = json['user_id'];
    user = json['user'];
    status = json['status'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    organizationId = json['organization_id'];
    id = json['id'];
    designation = json['designation'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_position'] = this.userPosition;
    data['user_id'] = this.userId;
    data['user'] = this.user;
    data['status'] = this.status;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['organization_id'] = this.organizationId;
    data['id'] = this.id;
    data['designation'] = this.designation;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    return data;
  }
}

class Roles {
  String? userId;
  String? name;
  String? id;

  Roles({this.userId, this.name, this.id});

  Roles.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class Profile {
  String? userId;
  String? personalNumber;
  String? lastName;
  String? image;
  String? id;
  String? firstName;
  String? emergencyNumber;
  String? address;
  String? about;

  Profile(
      {this.userId,
        this.personalNumber,
        this.lastName,
        this.image,
        this.id,
        this.firstName,
        this.emergencyNumber,
        this.address,
        this.about});

  Profile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    personalNumber = json['personal_number'];
    lastName = json['last_name'];
    image = json['image'];
    id = json['id'];
    firstName = json['first_name'];
    emergencyNumber = json['emergency_number'];
    address = json['address'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['personal_number'] = this.personalNumber;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['emergency_number'] = this.emergencyNumber;
    data['address'] = this.address;
    data['about'] = this.about;
    return data;
  }
}

class Department {
  String? name;

  Department({this.name});

  Department.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
