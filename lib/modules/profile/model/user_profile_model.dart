class UserProfileModel {
  GetOrganizationUsers? getOrganizationUsers;

  UserProfileModel({this.getOrganizationUsers});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    getOrganizationUsers = json['getOrganizationUsers'] != null
        ? new GetOrganizationUsers.fromJson(json['getOrganizationUsers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getOrganizationUsers != null) {
      data['getOrganizationUsers'] = this.getOrganizationUsers!.toJson();
    }
    return data;
  }
}

class GetOrganizationUsers {
  List<Data>? data;
  MetaData? metaData;

  GetOrganizationUsers({this.data, this.metaData});

  GetOrganizationUsers.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    metaData = json['metaData'] != null
        ? new MetaData.fromJson(json['metaData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.metaData != null) {
      data['metaData'] = this.metaData!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? joinDate;
  String? employeeId;
  Profile? profile;
  EmploymentStatus? employmentStatus;
  Designation? designation;
  Designation? department;
  User? user;
  String? userId;

  Data(
      {this.id,
        this.joinDate,
        this.employeeId,
        this.profile,
        this.employmentStatus,
        this.designation,
        this.department,
        this.user,
        this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    joinDate = json['join_date'];
    employeeId = json['employee_id'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    employmentStatus = json['employment_status'] != null
        ? new EmploymentStatus.fromJson(json['employment_status'])
        : null;
    designation = json['designation'] != null
        ? new Designation.fromJson(json['designation'])
        : null;
    department = json['department'] != null
        ? new Designation.fromJson(json['department'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['join_date'] = this.joinDate;
    data['employee_id'] = this.employeeId;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.employmentStatus != null) {
      data['employment_status'] = this.employmentStatus!.toJson();
    }
    if (this.designation != null) {
      data['designation'] = this.designation!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['user_id'] = this.userId;
    return data;
  }
}

class Profile {
  String? firstName;
  String? lastName;
  Null? image;

  Profile({this.firstName, this.lastName, this.image});

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    return data;
  }
}

class EmploymentStatus {
  String? id;
  String? name;
  String? color;

  EmploymentStatus({this.id, this.name, this.color});

  EmploymentStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
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

class MetaData {
  int? filteredRows;

  MetaData({this.filteredRows});

  MetaData.fromJson(Map<String, dynamic> json) {
    filteredRows = json['filteredRows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filteredRows'] = this.filteredRows;
    return data;
  }
}
