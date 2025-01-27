class TimeSheetModel {
  GetUsersTimeSheet? getUsersTimeSheet;

  TimeSheetModel({this.getUsersTimeSheet});

  TimeSheetModel.fromJson(Map<String, dynamic> json) {
    getUsersTimeSheet = json['getUsersTimeSheet'] != null
        ? new GetUsersTimeSheet.fromJson(json['getUsersTimeSheet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getUsersTimeSheet != null) {
      data['getUsersTimeSheet'] = this.getUsersTimeSheet!.toJson();
    }
    return data;
  }
}

class GetUsersTimeSheet {
  List<Data>? data;

  GetUsersTimeSheet({this.data});

  GetUsersTimeSheet.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  OrganizationUser? organizationUser;
  String? orgUserId;
  String? timelineStartDate;
  String? timelineEndDate;
  String? totalScheduledSeconds;
  String? loggedTotalSeconds;
  bool? isFlaggedTimelog;
  String? totalLeavesSeconds;
  String? balance;

  Data(
      {this.organizationUser,
        this.orgUserId,
        this.timelineStartDate,
        this.timelineEndDate,
        this.totalScheduledSeconds,
        this.loggedTotalSeconds,
        this.isFlaggedTimelog,
        this.totalLeavesSeconds,
        this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    organizationUser = json['organization_user'] != null
        ? new OrganizationUser.fromJson(json['organization_user'])
        : null;
    orgUserId = json['org_user_id'];
    timelineStartDate = json['timeline_start_date'];
    timelineEndDate = json['timeline_end_date'];
    totalScheduledSeconds = json['total_scheduled_seconds'];
    loggedTotalSeconds = json['logged_total_seconds'];
    isFlaggedTimelog = json['is_flagged_timelog'];
    totalLeavesSeconds = json['total_leaves_seconds'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.organizationUser != null) {
      data['organization_user'] = this.organizationUser!.toJson();
    }
    data['org_user_id'] = this.orgUserId;
    data['timeline_start_date'] = this.timelineStartDate;
    data['timeline_end_date'] = this.timelineEndDate;
    data['total_scheduled_seconds'] = this.totalScheduledSeconds;
    data['logged_total_seconds'] = this.loggedTotalSeconds;
    data['is_flagged_timelog'] = this.isFlaggedTimelog;
    data['total_leaves_seconds'] = this.totalLeavesSeconds;
    data['balance'] = this.balance;
    return data;
  }
}

class OrganizationUser {
  String? id;
  Null? roles;
  Department? department;
  Profile? profile;

  OrganizationUser({this.id, this.roles, this.department, this.profile});

  OrganizationUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roles = json['roles'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roles'] = this.roles;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
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
