class TimeSheetModel {
  GetUsersTimeSheet? getUsersTimeSheet;

  TimeSheetModel({this.getUsersTimeSheet});

  TimeSheetModel.fromJson(Map<String, dynamic> json) {
    getUsersTimeSheet = json['getUsersTimeSheet'] != null
        ? GetUsersTimeSheet.fromJson(json['getUsersTimeSheet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getUsersTimeSheet != null) {
      data['getUsersTimeSheet'] = getUsersTimeSheet!.toJson();
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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
        ? OrganizationUser.fromJson(json['organization_user'])
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (organizationUser != null) {
      data['organization_user'] = organizationUser!.toJson();
    }
    data['org_user_id'] = orgUserId;
    data['timeline_start_date'] = timelineStartDate;
    data['timeline_end_date'] = timelineEndDate;
    data['total_scheduled_seconds'] = totalScheduledSeconds;
    data['logged_total_seconds'] = loggedTotalSeconds;
    data['is_flagged_timelog'] = isFlaggedTimelog;
    data['total_leaves_seconds'] = totalLeavesSeconds;
    data['balance'] = balance;
    return data;
  }
}

class OrganizationUser {
  String? id;
  void roles;
  Department? department;
  Profile? profile;

  OrganizationUser({this.id, this.roles, this.department, this.profile});

  OrganizationUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roles = json['roles'];
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['roles'] = roles;
    if (department != null) {
      data['department'] = department!.toJson();
    }
    if (profile != null) {
      data['profile'] = profile!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
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
