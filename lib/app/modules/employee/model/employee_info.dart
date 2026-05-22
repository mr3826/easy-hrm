import 'package:hive/hive.dart';

part 'employee_info.g.dart';

class EmployeeInfo {
  GetOrganizationUsers? getOrganizationUsers;

  EmployeeInfo({this.getOrganizationUsers});

  EmployeeInfo.fromJson(Map<String, dynamic> json) {
    getOrganizationUsers = json['getOrganizationUsers'] != null
        ? GetOrganizationUsers.fromJson(json['getOrganizationUsers'])
        : null;
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
        data!.add(Data.fromJson(v));
      });
    }
    metaData = json['metaData'] != null
        ? MetaData.fromJson(json['metaData'])
        : null;
  }
}

class MetaData {
  int? filteredRows;

  MetaData({this.filteredRows});

  MetaData.fromJson(Map<String, dynamic> json) {
    filteredRows = json['filteredRows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filteredRows'] = filteredRows;
    return data;
  }
}

@HiveType(typeId: 0)
class Data extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  Profile? profile;

  @HiveField(2)
  EmploymentStatus? employmentStatus;

  @HiveField(3)
  EmploymentStatus? designation;

  @HiveField(4)
  EmploymentStatus? department;

  @HiveField(5)
  User? user;

  @HiveField(6)
  String? userId;

  @HiveField(7)
  String? joiningDate;

  Data(
      {this.id,
      this.profile,
      this.employmentStatus,
      this.designation,
      this.department,
      this.user,
      this.userId,
      this.joiningDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    employmentStatus = json['employment_status'] != null
        ? EmploymentStatus.fromJson(json['employment_status'])
        : null;
    designation = json['designation'] != null
        ? EmploymentStatus.fromJson(json['designation'])
        : null;
    department = json['department'] != null
        ? EmploymentStatus.fromJson(json['department'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userId = json['user_id'];
    joiningDate = json['join_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile'] = profile?.toJson();
    data['employment_status'] = employmentStatus?.toJson();
    data['designation'] = designation?.toJson();
    data['department'] = department?.toJson();
    data['user'] = user?.toJson();
    data['user_id'] = userId;
    return data;
  }
}

@HiveType(typeId: 1)
class Profile extends HiveObject {
  @HiveField(0)
  String? firstName;

  @HiveField(1)
  String? lastName;

  @HiveField(2)
  String? image;

  Profile({this.firstName, this.lastName, this.image});

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
    return data;
  }
}

@HiveType(typeId: 2)
class EmploymentStatus extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? color;

  @HiveField(2)
  String? id;

  EmploymentStatus({this.name, this.color, this.id});

  EmploymentStatus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}

@HiveType(typeId: 3)
class User extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? email;

  User({this.id, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    return data;
  }
}
