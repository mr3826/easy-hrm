class TimeEntryDetails {
  GetTimeEntryDetails? getTimeEntryDetails;

  TimeEntryDetails({this.getTimeEntryDetails});

  TimeEntryDetails.fromJson(Map<String, dynamic> json) {
    getTimeEntryDetails = json['getTimeEntryDetails'] != null
        ? new GetTimeEntryDetails.fromJson(json['getTimeEntryDetails'])
        : null;
  }
}

class GetTimeEntryDetails {
  String? id;
  String? startDate;
  String? endDate;
  String? status;
  String? description;
  Project? project;
  Task? task;
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
    task = json['task'] != null ? new Task.fromJson(json['task']) : null;
    organizationUser = json['organization_user'] != null
        ? new OrganizationUser.fromJson(json['organization_user'])
        : null;
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

}

class Task {
  String? id;
  String? name;
  String? projectId;
  Project? project;

  Task({this.id, this.name, this.projectId, this.project});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    projectId = json['project_id'];
    project =
    json['project'] != null ? new Project.fromJson(json['project']) : null;
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

}

class Roles {
  String? name;

  Roles({this.name});

  Roles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
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
}
