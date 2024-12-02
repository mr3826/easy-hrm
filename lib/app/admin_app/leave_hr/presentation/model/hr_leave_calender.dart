class HrLeaveCalender {
  GetLeavesCalendar? getLeavesCalendar;

  HrLeaveCalender({this.getLeavesCalendar});

  HrLeaveCalender.fromJson(Map<String, dynamic> json) {
    getLeavesCalendar = json['getLeavesCalendar'] != null
        ? new GetLeavesCalendar.fromJson(json['getLeavesCalendar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getLeavesCalendar != null) {
      data['getLeavesCalendar'] = this.getLeavesCalendar!.toJson();
    }
    return data;
  }
}

class GetLeavesCalendar {
  List<LeaveRequests>? leaveRequests;
  String? sTypename;

  GetLeavesCalendar({this.leaveRequests, this.sTypename});

  GetLeavesCalendar.fromJson(Map<String, dynamic> json) {
    if (json['leave_requests'] != null) {
      leaveRequests = <LeaveRequests>[];
      json['leave_requests'].forEach((v) {
        leaveRequests!.add(new LeaveRequests.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveRequests != null) {
      data['leave_requests'] =
          this.leaveRequests!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class LeaveRequests {
  String? formattedDate;
  int? totalApproved;
  int? totalPending;
  int? totalRejected;
  int? totalCancelled;
  int? totalTaken;
  List<OrganizationUsers>? organizationUsers;
  String? sTypename;

  LeaveRequests(
      {this.formattedDate,
        this.totalApproved,
        this.totalPending,
        this.totalRejected,
        this.totalCancelled,
        this.totalTaken,
        this.organizationUsers,
        this.sTypename});

  LeaveRequests.fromJson(Map<String, dynamic> json) {
    formattedDate = json['formatted_date'];
    totalApproved = json['total_approved'];
    totalPending = json['total_pending'];
    totalRejected = json['total_rejected'];
    totalCancelled = json['total_cancelled'];
    totalTaken = json['total_taken'];
    if (json['organization_users'] != null) {
      organizationUsers = <OrganizationUsers>[];
      json['organization_users'].forEach((v) {
        organizationUsers!.add(new OrganizationUsers.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formatted_date'] = this.formattedDate;
    data['total_approved'] = this.totalApproved;
    data['total_pending'] = this.totalPending;
    data['total_rejected'] = this.totalRejected;
    data['total_cancelled'] = this.totalCancelled;
    data['total_taken'] = this.totalTaken;
    if (this.organizationUsers != null) {
      data['organization_users'] =
          this.organizationUsers!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class OrganizationUsers {
  Profile? profile;
  List<Roles>? roles;
  String? id;
  String? leaveId;
  String? sTypename;

  OrganizationUsers(
      {this.profile, this.roles, this.id, this.leaveId, this.sTypename});

  OrganizationUsers.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    id = json['id'];
    leaveId = json['leave_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['leave_id'] = this.leaveId;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Profile {
  String? firstName;
  String? lastName;
  String? image;
  String? sTypename;

  Profile({this.firstName, this.lastName, this.image, this.sTypename});

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
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
