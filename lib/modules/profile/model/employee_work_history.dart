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

  GetOrganizationUserHistory(
      {this.designationHistories, this.employmentHistories});

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
  }
}

class DesignationHistories {
  String? startDate;
  dynamic endDate;
  Designation? designation;

  DesignationHistories(
      {this.startDate, this.endDate, this.designation});

  DesignationHistories.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    designation = json['designation'] != null
        ? Designation.fromJson(json['designation'])
        : null;
  }
}

class Designation {
  String? name;

  Designation({this.name});

  Designation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class EmploymentHistories {
  dynamic employmentStatusId;
  String? startDate;
  dynamic endDate;
  EmploymentStatus? employmentStatus;

  EmploymentHistories(
      {this.employmentStatusId,
      this.startDate,
      this.endDate,
      this.employmentStatus});

  EmploymentHistories.fromJson(Map<String, dynamic> json) {
    employmentStatusId = json['employment_status_id'];
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

  EmploymentStatus({this.name, this.color});

  EmploymentStatus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
  }
}
