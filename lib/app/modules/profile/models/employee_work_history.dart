class EmployeeWorkHistory {
  final GetOrganizationUserHistory getOrganizationUserHistory;

  EmployeeWorkHistory({
    GetOrganizationUserHistory? getOrganizationUserHistory,
  }) : getOrganizationUserHistory = getOrganizationUserHistory ?? GetOrganizationUserHistory();

  EmployeeWorkHistory.fromJson(Map<String, dynamic> json)
      : getOrganizationUserHistory = json['getOrganizationUserHistory'] != null
      ? GetOrganizationUserHistory.fromJson(json['getOrganizationUserHistory'])
      : GetOrganizationUserHistory();
}

class GetOrganizationUserHistory {
  final List<DesignationHistories> designationHistories;
  final List<EmploymentHistories> employmentHistories;
  final List<DeptHistories> deptHistories;

  GetOrganizationUserHistory({
    List<DesignationHistories>? designationHistories,
    List<EmploymentHistories>? employmentHistories,
    List<DeptHistories>? deptHistories,
  })  : designationHistories = designationHistories ?? [],
        employmentHistories = employmentHistories ?? [],
        deptHistories = deptHistories ?? [];

  GetOrganizationUserHistory.fromJson(Map<String, dynamic> json)
      : designationHistories = (json['designation_histories'] as List?)?.map((v) => DesignationHistories.fromJson(v)).toList() ?? [],
        employmentHistories = (json['employment_histories'] as List?)?.map((v) => EmploymentHistories.fromJson(v)).toList() ?? [],
        deptHistories = (json['dept_histories'] as List?)?.map((v) => DeptHistories.fromJson(v)).toList() ?? [];
}

class DesignationHistories {
  final String startDate;
  final String endDate;
  final Designation designation;

  DesignationHistories({
    String? startDate,
    String? endDate,
    Designation? designation,
  })  : startDate = startDate ?? '',
        endDate = endDate ?? '',
        designation = designation ?? Designation();

  DesignationHistories.fromJson(Map<String, dynamic> json)
      : startDate = json['start_date'] ?? '',
        endDate = json['end_date'] ?? '',
        designation = json['designation'] != null ? Designation.fromJson(json['designation']) : Designation();
}

class Designation {
  final String id;
  final String name;

  Designation({
    String? id,
    String? name,
  })  : id = id ?? '',
        name = name ?? '';

  Designation.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        name = json['name'] ?? '';
}

class EmploymentHistories {
  final String startDate;
  final String endDate;
  final EmploymentStatus employmentStatus;

  EmploymentHistories({
    String? startDate,
    String? endDate,
    EmploymentStatus? employmentStatus,
  })  : startDate = startDate ?? '',
        endDate = endDate ?? '',
        employmentStatus = employmentStatus ?? EmploymentStatus();

  EmploymentHistories.fromJson(Map<String, dynamic> json)
      : startDate = json['start_date'] ?? '',
        endDate = json['end_date'] ?? '',
        employmentStatus = json['employment_status'] != null ? EmploymentStatus.fromJson(json['employment_status']) : EmploymentStatus();
}

class EmploymentStatus {
  final String name;
  final String color;
  final String id;

  EmploymentStatus({
    String? name,
    String? color,
    String? id,
  })  : name = name ?? '',
        color = color ?? '',
        id = id ?? '';

  EmploymentStatus.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        color = json['color'] ?? '',
        id = json['id'] ?? '';
}

class DeptHistories {
  final Department department;
  final String startDate;
  final String endDate;

  DeptHistories({
    Department? department,
    String? startDate,
    String? endDate,
  })  : department = department ?? Department(),
        startDate = startDate ?? '',
        endDate = endDate ?? '';

  DeptHistories.fromJson(Map<String, dynamic> json)
      : department = json['department'] != null ? Department.fromJson(json['department']) : Department(),
        startDate = json['start_date'] ?? '',
        endDate = json['end_date'] ?? '';
}

class Department {
  final String name;
  final Manager manager;
  final Parent parent;

  Department({
    String? name,
    Manager? manager,
    Parent? parent,
  })  : name = name ?? '',
        manager = manager ?? Manager(),
        parent = parent ?? Parent();

  Department.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        manager = json['manager'] != null ? Manager.fromJson(json['manager']) : Manager(),
        parent = json['parent'] != null ? Parent.fromJson(json['parent']) : Parent();
}

class Manager {
  final Profile profile;

  Manager({Profile? profile}) : profile = profile ?? Profile();

  Manager.fromJson(Map<String, dynamic> json)
      : profile = json['profile'] != null ? Profile.fromJson(json['profile']) : Profile();
}

class Profile {
  final String image;
  final String firstName;
  final String lastName;

  Profile({
    String? image,
    String? firstName,
    String? lastName,
  })  : image = image ?? '',
        firstName = firstName ?? '',
        lastName = lastName ?? '';

  Profile.fromJson(Map<String, dynamic> json)
      : image = json['image'] ?? '',
        firstName = json['first_name'] ?? '',
        lastName = json['last_name'] ?? '';
}

class Parent {
  final String name;

  Parent({String? name}) : name = name ?? '';

  Parent.fromJson(Map<String, dynamic> json) : name = json['name'] ?? '';
}
