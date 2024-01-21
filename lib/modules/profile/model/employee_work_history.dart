class EmployeeWorkHistory {
  GetOrganizationUserHistory? getOrganizationUserHistory;

  EmployeeWorkHistory({this.getOrganizationUserHistory});

  EmployeeWorkHistory.fromJson(Map<String, dynamic> json) {
    getOrganizationUserHistory = json['getOrganizationUserHistory'] != null
        ? GetOrganizationUserHistory.fromJson(
        json['getOrganizationUserHistory'])
        : null;
  }

}

class GetOrganizationUserHistory {
  List<DesignationHistories>? designationHistories;
  List<EmploymentHistories>? employmentHistories;
  List<DeptHistories>? deptHistories;

  GetOrganizationUserHistory(
      {this.designationHistories,
        this.employmentHistories,
        this.deptHistories});

  GetOrganizationUserHistory.fromJson(Map<String, dynamic> json) {
    if (json['designation_histories'] != null) {
      designationHistories = <DesignationHistories>[];
      json['designation_histories'].forEach((v) {
        designationHistories!.add(DesignationHistories.fromJson(v));
      });
    }
    if (json['employment_histories'] != null) {
      employmentHistories = <EmploymentHistories>[];
      json['employment_histories'].forEach((v) {
        employmentHistories!.add(EmploymentHistories.fromJson(v));
      });
    }
    if (json['dept_histories'] != null) {
      deptHistories = <DeptHistories>[];
      json['dept_histories'].forEach((v) {
        deptHistories!.add(DeptHistories.fromJson(v));
      });
    }
  }
}

class DesignationHistories {
  String? startDate;
  String? endDate;
  Designation? designation;

  DesignationHistories({this.startDate, this.endDate, this.designation});

  DesignationHistories.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    designation = json['designation'] != null
        ? Designation.fromJson(json['designation'])
        : null;
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

class EmploymentHistories {
  String? startDate;
  String? endDate;
  EmploymentStatus? employmentStatus;

  EmploymentHistories({this.startDate, this.endDate, this.employmentStatus});

  EmploymentHistories.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    employmentStatus = json['employment_status'] != null
        ? EmploymentStatus.fromJson(json['employment_status'])
        : null;
  }
}

class EmploymentStatus {
  String? name;
  String? color;
  String? id;

  EmploymentStatus({this.name, this.color, this.id});

  EmploymentStatus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    id = json['id'];
  }

}

class DeptHistories {
  Department? department;
  String? startDate;
  String? endDate;

  DeptHistories({this.department, this.startDate, this.endDate});

  DeptHistories.fromJson(Map<String, dynamic> json) {
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
  }
}

class Department {
  String? name;
  Manager? manager;
  Parent? parent;

  Department({this.name, this.manager, this.parent});

  Department.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    manager =
    json['manager'] != null ?  Manager.fromJson(json['manager']) : null;
    parent =
    json['parent'] != null ?  Parent.fromJson(json['parent']) : null;
  }
}

class Manager {
  Profile? profile;

  Manager({this.profile});

  Manager.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ?  Profile.fromJson(json['profile']) : null;
  }

}

class Profile {
  String? image;
  String? firstName;
  String? lastName;

  Profile({this.image, this.firstName, this.lastName});

  Profile.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

}

class Parent {
  String? name;

  Parent({this.name});

  Parent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

}
