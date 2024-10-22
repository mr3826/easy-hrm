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

class Data {
  String? id;
  Profile? profile;
  EmploymentStatus? employmentStatus;
  EmploymentStatus? designation;
  User? user;
  String? userId;

  Data(
      {this.id,
        this.profile,
        this.employmentStatus,
        this.designation,
        this.user,
        this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    employmentStatus = json['employment_status'] != null
        ? new EmploymentStatus.fromJson(json['employment_status'])
        : null;
    designation = json['designation'] != null
        ? new EmploymentStatus.fromJson(json['designation'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    userId = json['user_id'];
  }

}

class Profile {
  String? firstName;
  String? lastName;
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

class EmploymentStatus {
  String? name;
  String? color;

  EmploymentStatus({this.name});

  EmploymentStatus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
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
