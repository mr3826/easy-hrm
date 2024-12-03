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

  GetLeavesCalendar({this.leaveRequests});

  GetLeavesCalendar.fromJson(Map<String, dynamic> json) {
    if (json['leave_requests'] != null) {
      leaveRequests = <LeaveRequests>[];
      json['leave_requests'].forEach((v) {
        leaveRequests!.add(new LeaveRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveRequests != null) {
      data['leave_requests'] =
          this.leaveRequests!.map((v) => v.toJson()).toList();
    }
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
  String? formattedLeaveHours;
  List<OrganizationUsers>? organizationUsers;

  LeaveRequests(
      {this.formattedDate,
        this.totalApproved,
        this.totalPending,
        this.totalRejected,
        this.totalCancelled,
        this.totalTaken,
        this.formattedLeaveHours,
        this.organizationUsers});

  LeaveRequests.fromJson(Map<String, dynamic> json) {
    formattedDate = json['formatted_date'];
    totalApproved = json['total_approved'];
    totalPending = json['total_pending'];
    totalRejected = json['total_rejected'];
    totalCancelled = json['total_cancelled'];
    totalTaken = json['total_taken'];
    formattedLeaveHours = json['formatted_leave_hours'];
    if (json['organization_users'] != null) {
      organizationUsers = <OrganizationUsers>[];
      json['organization_users'].forEach((v) {
        organizationUsers!.add(new OrganizationUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formatted_date'] = this.formattedDate;
    data['total_approved'] = this.totalApproved;
    data['total_pending'] = this.totalPending;
    data['total_rejected'] = this.totalRejected;
    data['total_cancelled'] = this.totalCancelled;
    data['total_taken'] = this.totalTaken;
    data['formatted_leave_hours'] = this.formattedLeaveHours;
    if (this.organizationUsers != null) {
      data['organization_users'] =
          this.organizationUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrganizationUsers {
  Profile? profile;
  List<Roles>? roles;
  Null? designation;
  String? leaveId;

  OrganizationUsers({this.profile, this.roles, this.designation, this.leaveId});

  OrganizationUsers.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    designation = json['designation'];
    leaveId = json['leave_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['designation'] = this.designation;
    data['leave_id'] = this.leaveId;
    return data;
  }
}

class Profile {
  String? firstName;
  String? lastName;
  String? image;

  Profile({this.firstName, this.lastName, this.image});

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
