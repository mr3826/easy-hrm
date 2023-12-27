class UserDetails {
  GetOrganizationUserDetails? getOrganizationUserDetails;

  UserDetails({this.getOrganizationUserDetails});

  UserDetails.fromJson(Map<String, dynamic> json) {
    getOrganizationUserDetails = json['getOrganizationUserDetails'] != null
        ? GetOrganizationUserDetails.fromJson(
            json['getOrganizationUserDetails'])
        : null;
  }
}

class GetOrganizationUserDetails {
  Profile? profile;
  User? user;
  Department? department;
  String? status;
  Organization? organization;

  GetOrganizationUserDetails(
      {this.profile,
      this.user,
      this.department,
      this.status,
      this.organization});

  GetOrganizationUserDetails.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    status = json['status'];
    organization = json['organization'] != null
        ? Organization.fromJson(json['organization'])
        : null;
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
}

class User {
  String? email;
  String? id;

  User({this.email, this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
  }
}

class Department {
  String? name;
  String? id;
  Parent? parent;
  WorkShift? workShift;

  Department({this.name, this.id, this.parent, this.workShift});

  Department.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    workShift = json['work_shift'] != null
        ? WorkShift.fromJson(json['work_shift'])
        : null;
  }
}

class Parent {
  String? id;
  String? name;

  Parent({this.id, this.name});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
}

class Organization {
  OrganizationSetting? organizationSetting;
  String? orgName;

  Organization({this.organizationSetting, this.orgName});

  Organization.fromJson(Map<String, dynamic> json) {
    orgName = json['name'];
    organizationSetting = json['organization_setting'] != null
        ? OrganizationSetting.fromJson(json['organization_setting'])
        : null;
  }
}

class OrganizationSetting {
  String? language;
  String? logoKey;

  OrganizationSetting({this.language, this.logoKey});

  OrganizationSetting.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    logoKey = json['logo_key'];
  }
}
