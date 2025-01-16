
class CandidateActivitiesLogs {
  List<GetLogs>? getLogs;

  CandidateActivitiesLogs({this.getLogs});

  CandidateActivitiesLogs.fromJson(Map<String, dynamic> json) {
    if (json['getLogs'] != null) {
      getLogs = <GetLogs>[];
      json['getLogs'].forEach((v) {
        getLogs!.add(new GetLogs.fromJson(v));
      });
    }
  }
}

class GetLogs {
  String? id;
  String? context;
  String? action;
  String? createdAt;
  int? newNumber;
  String? newText;
  CreatedByUser? createdByUser;
  Job? job;
  Candidate? candidate;
  Null? review;
  List<Files>? files;
  NewHiringStage? newHiringStage;


  GetLogs(
      {this.id,
        this.context,
        this.action,
        this.createdAt,
        this.newNumber,
        this.newText,
        this.createdByUser,
        this.candidate,
        this.newHiringStage,

        this.job,
        this.review,
        this.files});

  GetLogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    context = json['context'];
    action = json['action'];
    createdAt = json['createdAt'];
    newNumber = json['new_number'];
    newText = json['new_text'];
    newHiringStage = json['newHiringStage'] != null
        ? new NewHiringStage.fromJson(json['newHiringStage'])
        : null;
    createdByUser = json['createdByUser'] != null
        ? new CreatedByUser.fromJson(json['createdByUser'])
        : null;
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    candidate = json['candidate'] != null
        ? new Candidate.fromJson(json['candidate'])
        : null;
    review = json['review'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
  }
}
class Job {
  String? id;
  String? title;

  Job({this.id, this.title});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
class CreatedByUser {
  String? id;
  Profile? profile;

  CreatedByUser({this.id, this.profile});

  CreatedByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
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
}

class Candidate {
  String? id;
  String? firstName;
  String? lastName;

  Candidate({this.id, this.firstName, this.lastName});

  Candidate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }
}

class Files {
  String? id;
  String? name;
  String? key;

  Files({this.id, this.name, this.key});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    key = json['key'];
  }
}
class NewHiringStage {
  String? id;
  String? title;

  NewHiringStage({this.id, this.title});

  NewHiringStage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
