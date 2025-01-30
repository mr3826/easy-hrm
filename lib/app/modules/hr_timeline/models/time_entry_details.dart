class TimeEntryDetails {
  GetTimeEntryDetails? getTimeEntryDetails;

  TimeEntryDetails({this.getTimeEntryDetails});

  TimeEntryDetails.fromJson(Map<String, dynamic> json) {
    getTimeEntryDetails = json['getTimeEntryDetails'] != null
        ? new GetTimeEntryDetails.fromJson(json['getTimeEntryDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getTimeEntryDetails != null) {
      data['getTimeEntryDetails'] = this.getTimeEntryDetails!.toJson();
    }
    return data;
  }
}

class GetTimeEntryDetails {
  String? id;
  String? startDate;
  String? endDate;
  String? status;
  String? description;
  Project? project;
  dynamic task;
  OrganizationUser? organizationUser;

  GetTimeEntryDetails(
      {this.id,
        this.startDate,
        this.endDate,
        this.status,
        this.description,
        this.project,
        this.task,
        this.organizationUser});

  GetTimeEntryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    description = json['description'];
    project =
    json['project'] != null ? new Project.fromJson(json['project']) : null;
    task = json['task'];
    organizationUser = json['organization_user'] != null
        ? new OrganizationUser.fromJson(json['organization_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['description'] = this.description;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    data['task'] = this.task;
    if (this.organizationUser != null) {
      data['organization_user'] = this.organizationUser!.toJson();
    }
    return data;
  }
}

class Project {
  String? id;
  String? name;
  String? color;

  Project({this.id, this.name, this.color});

  Project.fromJson(Map<String, dynamic> json) {
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

class OrganizationUser {
  String? id;
  List<Roles>? roles;
  Department? department;
  Profile? profile;
  String? userId;

  OrganizationUser(
      {this.id, this.roles, this.department, this.profile, this.userId});

  OrganizationUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['user_id'] = this.userId;
    return data;
  }
}

class Roles {
  String? name;

  Roles({this.name});

  Roles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Department {
  String? id;
  String? name;

  Department({this.id, this.name});

  Department.fromJson(Map<String, dynamic> json) {
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

class Profile {
  String? id;
  String? firstName;
  String? lastName;
  String? image;

  Profile({this.id, this.firstName, this.lastName, this.image});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    return data;
  }
}
