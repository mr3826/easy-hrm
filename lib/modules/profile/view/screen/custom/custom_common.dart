class UserDetails {
  GetOrganizationUserDetails? getOrganizationUserDetails;

  UserDetails({this.getOrganizationUserDetails});

  UserDetails.fromJson(Map<String, dynamic> json) {
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
  String? employeeId;
  String? status;
  Profile? profile;
  User? user;
  Department? department;
  Organization? organization;
  Designation? designation;
  Designation? employmentStatus;

  GetOrganizationUserDetails(
      {this.employeeId,
        this.status,
        this.profile,
        this.user,
        this.department,
        this.organization,
        this.designation,
        this.employmentStatus});

  GetOrganizationUserDetails.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    status = json['status'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    designation = json['designation'] != null
        ? new Designation.fromJson(json['designation'])
        : null;
    employmentStatus = json['employment_status'] != null
        ? new Designation.fromJson(json['employment_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['status'] = this.status;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    if (this.designation != null) {
      data['designation'] = this.designation!.toJson();
    }
    if (this.employmentStatus != null) {
      data['employment_status'] = this.employmentStatus!.toJson();
    }
    return data;
  }
}

class Profile {
  String? id;
  String? firstName;
  String? lastName;
  Null? image;
  String? about;
  String? address;
  String? personalNumber;
  String? emergencyNumber;

  Profile(
      {this.id,
        this.firstName,
        this.lastName,
        this.image,
        this.about,
        this.address,
        this.personalNumber,
        this.emergencyNumber});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    about = json['about'];
    address = json['address'];
    personalNumber = json['personal_number'];
    emergencyNumber = json['emergency_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['about'] = this.about;
    data['address'] = this.address;
    data['personal_number'] = this.personalNumber;
    data['emergency_number'] = this.emergencyNumber;
    return data;
  }
}

class User {
  String? id;
  String? email;

  User({this.id, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}

class Department {
  String? id;
  String? name;
  Null? parent;
  WorkShift? workShift;

  Department({this.id, this.name, this.parent, this.workShift});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    workShift = json['work_shift'] != null
        ? new WorkShift.fromJson(json['work_shift'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
  Null? organizationUser;
  String? name;
  String? id;
  OrganizationSetting? organizationSetting;

  Organization(
      {this.organizationUser, this.name, this.id, this.organizationSetting});

  Organization.fromJson(Map<String, dynamic> json) {
    organizationUser = json['organization_user'];
    name = json['name'];
    id = json['id'];
    organizationSetting = json['organization_setting'] != null
        ? new OrganizationSetting.fromJson(json['organization_setting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organization_user'] = this.organizationUser;
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.organizationSetting != null) {
      data['organization_setting'] = this.organizationSetting!.toJson();
    }
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

class Designation {
  String? id;
  String? name;

  Designation({this.id, this.name});

  Designation.fromJson(Map<String, dynamic> json) {
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
