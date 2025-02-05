import 'employee_work_history.dart';

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
  String? employeeId;
  String? status;
  String? createdAt;
  String? joinDate;
  Profile? profile;
  User? user;
  Department? department;
  Organization? organization;
  Designation? designation;
  EmploymentStatusData? employmentStatus;
  List<DesignationHistories>? designationHistories;
  List<DeptHistories>? deptHistories;
  List<EmploymentHistories>? employmentHistories;

  GetOrganizationUserDetails(
      {this.employeeId,
        this.status,
        this.createdAt,
        this.profile,
        this.user,
        this.department,
        this.organization,
        this.designation,
        this.employmentStatus});

  GetOrganizationUserDetails.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    status = json['status'];
    createdAt = json['createdAt'];
    createdAt = json['join_date'];
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    organization = json['organization'] != null
        ? Organization.fromJson(json['organization'])
        : null;
    designation = json['designation'] != null
        ? Designation.fromJson(json['designation'])
        : null;
    employmentStatus = json['employment_status'] != null
        ? EmploymentStatusData.fromJson(json['employment_status'])
        : null;
    if (json['designation_histories'] != null) {
      designationHistories = <DesignationHistories>[];
      json['designation_histories'].forEach((v) {
        designationHistories!.add(new DesignationHistories.fromJson(v));
      });
    }
    if (json['dept_histories'] != null) {
      deptHistories = <DeptHistories>[];
      json['dept_histories'].forEach((v) {
        deptHistories!.add(new DeptHistories.fromJson(v));
      });
    }
    if (json['employment_histories'] != null) {
      employmentHistories = <EmploymentHistories>[];
      json['employment_histories'].forEach((v) {
        employmentHistories!.add(new EmploymentHistories.fromJson(v));
      });
    }
  }
}



class Profile {
  String? id;
  String? firstName;
  String? lastName;
  String? image;
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
}

class User {
  String? id;
  String? email;

  User({this.id, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
  }
}

class Department {
  String? id;
  String? name;
  Parent? parent;
  WorkShift? workShift;

  Department({this.id, this.name, this.parent, this.workShift});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // Ensure correct handling of parent
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    // Ensure correct handling of workShift
    workShift = json['work_shift'] != null
        ? WorkShift.fromJson(json['work_shift'])
        : null;
  }
}

class Parent {
  String? name;
  Parent({this.name});

  Parent.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? id;
  OrganizationSetting? organizationSetting;

  Organization({this.name, this.id, this.organizationSetting});

  Organization.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    organizationSetting = json['organization_setting'] != null
        ? OrganizationSetting.fromJson(json['organization_setting'])
        : null;
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
}

class Designation {
  String? id;
  String? name;

  Designation({this.id, this.name});

  Designation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class EmploymentStatusData {
  String? id;
  String? name;
  String? color;

  EmploymentStatusData({this.id, this.name, this.color});

  EmploymentStatusData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }
}
