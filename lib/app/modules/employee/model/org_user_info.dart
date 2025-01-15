class OrgUserInfo {
  GetOrganizationUserDetails? getOrganizationUserDetails;

  OrgUserInfo({this.getOrganizationUserDetails});

  OrgUserInfo.fromJson(Map<String, dynamic> json) {
    getOrganizationUserDetails = json['getOrganizationUserDetails'] != null
        ? GetOrganizationUserDetails.fromJson(json['getOrganizationUserDetails'])
        : GetOrganizationUserDetails();
  }
}

class GetOrganizationUserDetails {
  String employeeId;
  String status;
  String createdAt;
  Profile profile;
  User user;
  Department department;
  Organization organization;
  Designation designation;
  EmploymentStatus employmentStatus;
  String joinDate;

  GetOrganizationUserDetails({
    this.employeeId = '',
    this.status = '',
    this.createdAt = '',
    Profile? profile,
    User? user,
    Department? department,
    Organization? organization,
    Designation? designation,
    EmploymentStatus? employmentStatus,
    this.joinDate = '',
  })  : profile = profile ?? Profile(),
        user = user ?? User(),
        department = department ?? Department(),
        organization = organization ?? Organization(),
        designation = designation ?? Designation(),
        employmentStatus = employmentStatus ?? EmploymentStatus();

  GetOrganizationUserDetails.fromJson(Map<String, dynamic> json)
      : employeeId = json['employee_id'] ?? '',
        status = json['status'] ?? '',
        createdAt = json['createdAt'] ?? '',
        profile = json['profile'] != null ? Profile.fromJson(json['profile']) : Profile(),
        user = json['user'] != null ? User.fromJson(json['user']) : User(),
        department = json['department'] != null ? Department.fromJson(json['department']) : Department(),
        organization = json['organization'] != null ? Organization.fromJson(json['organization']) : Organization(),
        designation = json['designation'] != null ? Designation.fromJson(json['designation']) : Designation(),
        employmentStatus = json['employment_status'] != null
            ? EmploymentStatus.fromJson(json['employment_status'])
            : EmploymentStatus(),
        joinDate = json['join_date'] ?? '';
}

class Profile {
  String id;
  String firstName;
  String lastName;
  String image;
  String about;
  String address;
  String personalNumber;
  String emergencyNumber;

  Profile({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.image = '',
    this.about = '',
    this.address = '',
    this.personalNumber = '',
    this.emergencyNumber = '',
  });

  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        firstName = json['first_name'] ?? '',
        lastName = json['last_name'] ?? '',
        image = json['image'] ?? '',
        about = json['about'] ?? '',
        address = json['address'] ?? '',
        personalNumber = json['personal_number'] ?? '',
        emergencyNumber = json['emergency_number'] ?? '';
}

class User {
  String id;
  String email;

  User({
    this.id = '',
    this.email = '',
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        email = json['email'] ?? '';
}

class Department {
  String id;
  String name;
  dynamic parent;
  WorkShift workShift;

  Department({
    this.id = '',
    this.name = '',
    this.parent,
    WorkShift? workShift,
  }) : workShift = workShift ?? WorkShift();

  Department.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        name = json['name'] ?? '',
        parent = json['parent'],
        workShift = json['work_shift'] != null
            ? WorkShift.fromJson(json['work_shift'])
            : WorkShift();
}

class WorkShift {
  String name;
  List<WorkSchedules> workSchedules;

  WorkShift({
    this.name = '',
    List<WorkSchedules>? workSchedules,
  }) : workSchedules = workSchedules ?? [];

  WorkShift.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        workSchedules = (json['work_schedules'] as List?)
            ?.map((v) => WorkSchedules.fromJson(v))
            .toList() ??
            [];
}

class WorkSchedules {
  String day;
  String endTime;
  String startTime;
  bool isHoliday;

  WorkSchedules({
    this.day = '',
    this.endTime = '',
    this.startTime = '',
    this.isHoliday = false,
  });

  WorkSchedules.fromJson(Map<String, dynamic> json)
      : day = json['day'] ?? '',
        endTime = json['end_time'] ?? '',
        startTime = json['start_time'] ?? '',
        isHoliday = json['is_holiday'] ?? false;
}

class Organization {
  String name;
  String id;
  OrganizationSetting organizationSetting;

  Organization({
    this.name = '',
    this.id = '',
    OrganizationSetting? organizationSetting,
  }) : organizationSetting = organizationSetting ?? OrganizationSetting();

  Organization.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        id = json['id'] ?? '',
        organizationSetting = json['organization_setting'] != null
            ? OrganizationSetting.fromJson(json['organization_setting'])
            : OrganizationSetting();
}

class OrganizationSetting {
  dynamic logoKey;
  dynamic logoIconKey;
  String language;

  OrganizationSetting({
    this.logoKey,
    this.logoIconKey,
    this.language = '',
  });

  OrganizationSetting.fromJson(Map<String, dynamic> json)
      : logoKey = json['logo_key'],
        logoIconKey = json['logo_icon_key'],
        language = json['language'] ?? '';
}

class Designation {
  String id;
  String name;

  Designation({
    this.id = '',
    this.name = '',
  });

  Designation.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        name = json['name'] ?? '';
}

class EmploymentStatus {
  String id;
  String name;
  String color;

  EmploymentStatus({
    this.id = '',
    this.name = '',
    this.color = '',
  });

  EmploymentStatus.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        name = json['name'] ?? '',
        color = json['color'] ?? '';
}
