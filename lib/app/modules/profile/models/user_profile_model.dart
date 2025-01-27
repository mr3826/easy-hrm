class UserProfileModel {
  GetOrganizationUserDetails? getOrganizationUserDetails;

  UserProfileModel({this.getOrganizationUserDetails});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    getOrganizationUserDetails = json['getOrganizationUserDetails'] != null
        ? new GetOrganizationUserDetails.fromJson(
        json['getOrganizationUserDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getOrganizationUserDetails != null) {
      data['getOrganizationUserDetails'] =
          this.getOrganizationUserDetails!.toJson();
    }
    return data;
  }
}

class GetOrganizationUserDetails {
  Profile? profile;
  User? user;
  Department? department;
  String? status;
  String? employeeId;
  Organization? organization;

  GetOrganizationUserDetails(
      {this.profile,
        this.user,
        this.department,
        this.status,
        this.employeeId,
        this.organization});

  GetOrganizationUserDetails.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    status = json['status'];
    employeeId = json['employee_id'];
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    data['status'] = this.status;
    data['employee_id'] = this.employeeId;
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    return data;
  }
}

class Profile {
  String? id;
  String? about;
  String? address;
  String? emergencyNumber;
  String? firstName;
  String? image;
  String? lastName;
  String? personalNumber;

  Profile(
      {this.id,
        this.about,
        this.address,
        this.emergencyNumber,
        this.firstName,
        this.image,
        this.lastName,
        this.personalNumber});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    about = json['about'];
    address = json['address'];
    emergencyNumber = json['emergency_number'];
    firstName = json['first_name'];
    image = json['image'];
    lastName = json['last_name'];
    personalNumber = json['personal_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['about'] = this.about;
    data['address'] = this.address;
    data['emergency_number'] = this.emergencyNumber;
    data['first_name'] = this.firstName;
    data['image'] = this.image;
    data['last_name'] = this.lastName;
    data['personal_number'] = this.personalNumber;
    return data;
  }
}

class User {
  String? email;
  String? id;

  User({this.email, this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }
}

class Department {
  String? name;
  String? id;
  String? parent;
  WorkShift? workShift;

  Department({this.name, this.id, this.parent, this.workShift});

  Department.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    parent = json['parent'];
    workShift = json['work_shift'] != null
        ? new WorkShift.fromJson(json['work_shift'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['parent'] = this.parent;
    if (this.workShift != null) {
      data['work_shift'] = this.workShift!.toJson();
    }
    return data;
  }
}

class WorkShift {
  String? name;
  List<WorkSchedules>? workSchedules;

  WorkShift({this.name, this.workSchedules});

  WorkShift.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['work_schedules'] != null) {
      workSchedules = <WorkSchedules>[];
      json['work_schedules'].forEach((v) {
        workSchedules!.add(new WorkSchedules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.workSchedules != null) {
      data['work_schedules'] =
          this.workSchedules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkSchedules {
  String? day;
  String? endTime;
  String? startTime;
  bool? isHoliday;

  WorkSchedules({this.day, this.endTime, this.startTime, this.isHoliday});

  WorkSchedules.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    endTime = json['end_time'];
    startTime = json['start_time'];
    isHoliday = json['is_holiday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['end_time'] = this.endTime;
    data['start_time'] = this.startTime;
    data['is_holiday'] = this.isHoliday;
    return data;
  }
}

class Organization {
  OrganizationSetting? organizationSetting;
  String? name;
  String? id;

  Organization({this.organizationSetting, this.name, this.id});

  Organization.fromJson(Map<String, dynamic> json) {
    organizationSetting = json['organization_setting'] != null
        ? new OrganizationSetting.fromJson(json['organization_setting'])
        : null;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.organizationSetting != null) {
      data['organization_setting'] = this.organizationSetting!.toJson();
    }
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class OrganizationSetting {
  String? logoKey;
  String? logoIconKey;
  String? language;

  OrganizationSetting({this.logoKey, this.logoIconKey, this.language});

  OrganizationSetting.fromJson(Map<String, dynamic> json) {
    logoKey = json['logo_key'];
    logoIconKey = json['logo_icon_key'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo_key'] = this.logoKey;
    data['logo_icon_key'] = this.logoIconKey;
    data['language'] = this.language;
    return data;
  }
}
