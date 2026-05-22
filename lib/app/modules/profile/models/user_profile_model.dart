class UserProfileModel {
  GetOrganizationUserDetails? getOrganizationUserDetails;

  UserProfileModel({this.getOrganizationUserDetails});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    getOrganizationUserDetails = json['getOrganizationUserDetails'] != null
        ? GetOrganizationUserDetails.fromJson(
        json['getOrganizationUserDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getOrganizationUserDetails != null) {
      data['getOrganizationUserDetails'] =
          getOrganizationUserDetails!.toJson();
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
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    status = json['status'];
    employeeId = json['employee_id'];
    organization = json['organization'] != null
        ? Organization.fromJson(json['organization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (department != null) {
      data['department'] = department!.toJson();
    }
    data['status'] = status;
    data['employee_id'] = employeeId;
    if (organization != null) {
      data['organization'] = organization!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['about'] = about;
    data['address'] = address;
    data['emergency_number'] = emergencyNumber;
    data['first_name'] = firstName;
    data['image'] = image;
    data['last_name'] = lastName;
    data['personal_number'] = personalNumber;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
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
        ? WorkShift.fromJson(json['work_shift'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['parent'] = parent;
    if (workShift != null) {
      data['work_shift'] = workShift!.toJson();
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
        workSchedules!.add(WorkSchedules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (workSchedules != null) {
      data['work_schedules'] =
          workSchedules!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['end_time'] = endTime;
    data['start_time'] = startTime;
    data['is_holiday'] = isHoliday;
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
        ? OrganizationSetting.fromJson(json['organization_setting'])
        : null;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (organizationSetting != null) {
      data['organization_setting'] = organizationSetting!.toJson();
    }
    data['name'] = name;
    data['id'] = id;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo_key'] = logoKey;
    data['logo_icon_key'] = logoIconKey;
    data['language'] = language;
    return data;
  }
}
