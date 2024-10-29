import 'package:hive/hive.dart';
part 'employee_info.g.dart';


class EmployeeInfo {
  GetOrganizationUsers? getOrganizationUsers;

  EmployeeInfo({this.getOrganizationUsers});

  EmployeeInfo.fromJson(Map<String, dynamic> json) {
    getOrganizationUsers = json['getOrganizationUsers'] != null
        ? new GetOrganizationUsers.fromJson(json['getOrganizationUsers'])
        : null;
  }
}

class GetOrganizationUsers {
  List<Data>? data;

  GetOrganizationUsers({this.data});

  GetOrganizationUsers.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
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

  Data({
    this.id,
    this.profile,
    this.employmentStatus,
    this.designation,
    this.department,
    this.user,
    this.userId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile'] = this.profile?.toJson();
    data['employment_status'] = this.employmentStatus?.toJson();
    data['designation'] = this.designation?.toJson();
    data['department'] = this.department?.toJson();
    data['user'] = this.user?.toJson();
    data['user_id'] = this.userId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    return data;
  }
}

@HiveType(typeId: 2)
class EmploymentStatus extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? color;

  EmploymentStatus({this.name, this.color});

  EmploymentStatus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}
