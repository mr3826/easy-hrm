class HrLeaveCalender {
  GetLeavesCalendar? getLeavesCalendar;

  HrLeaveCalender({this.getLeavesCalendar});

  HrLeaveCalender.fromJson(Map<String, dynamic> json) {
    getLeavesCalendar = json['getLeavesCalendar'] != null
        ? GetLeavesCalendar.fromJson(json['getLeavesCalendar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getLeavesCalendar != null) {
      data['getLeavesCalendar'] = getLeavesCalendar!.toJson();
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
        leaveRequests!.add(LeaveRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaveRequests != null) {
      data['leave_requests'] =
          leaveRequests!.map((v) => v.toJson()).toList();
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
  String? leaveTypeName;
  String? leaveTypeCategory;
  List<OrganizationUsers>? organizationUsers;

  LeaveRequests(
      {this.formattedDate,
        this.totalApproved,
        this.totalPending,
        this.totalRejected,
        this.totalCancelled,
        this.totalTaken,
        this.formattedLeaveHours,
        this.leaveTypeName,
        this.leaveTypeCategory,
        this.organizationUsers});

  LeaveRequests.fromJson(Map<String, dynamic> json) {
    formattedDate = json['formatted_date'];
    totalApproved = json['total_approved'];
    totalPending = json['total_pending'];
    totalRejected = json['total_rejected'];
    totalCancelled = json['total_cancelled'];
    totalTaken = json['total_taken'];
    leaveTypeName = json['leave_type_name'];
    leaveTypeCategory = json['leave_type_category'];
    formattedLeaveHours = json['formatted_leave_hours'];
    if (json['organization_users'] != null) {
      organizationUsers = <OrganizationUsers>[];
      json['organization_users'].forEach((v) {
        organizationUsers!.add(OrganizationUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatted_date'] = formattedDate;
    data['total_approved'] = totalApproved;
    data['total_pending'] = totalPending;
    data['total_rejected'] = totalRejected;
    data['total_cancelled'] = totalCancelled;
    data['total_taken'] = totalTaken;
    data['formatted_leave_hours'] = formattedLeaveHours;
    data['leave_type_name'] = leaveTypeName;
    data['leave_type_category'] = leaveTypeCategory;
    if (organizationUsers != null) {
      data['organization_users'] =
          organizationUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrganizationUsers {
  Profile? profile;
  List<Roles>? roles;
  dynamic designation;
  String? leaveId;

  OrganizationUsers({this.profile, this.roles, this.designation, this.leaveId});

  OrganizationUsers.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    designation = json['designation'];
    leaveId = json['leave_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['designation'] = designation;
    data['leave_id'] = leaveId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
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