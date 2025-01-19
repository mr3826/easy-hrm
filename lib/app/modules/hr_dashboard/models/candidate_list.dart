class CandidateList {
  GetCandidates? getCandidates;

  CandidateList({this.getCandidates});

  CandidateList.fromJson(Map<String, dynamic> json) {
    getCandidates = json['getCandidates'] != null
        ? new GetCandidates.fromJson(json['getCandidates'])
        : null;
  }
}

class GetCandidates {
  List<Data>? data;

  GetCandidates({this.data});

  GetCandidates.fromJson(Map<String, dynamic> json) {
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
  int? avgRating;
  Candidate? candidate;
  HiringStage? hiringStage;
  Job? job;

  Data({this.id, this.avgRating, this.candidate, this.hiringStage, this.job});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avgRating = json['avg_rating'];
    candidate = json['candidate'] != null
        ? new Candidate.fromJson(json['candidate'])
        : null;
    hiringStage = json['hiring_stage'] != null
        ? new HiringStage.fromJson(json['hiring_stage'])
        : null;
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
  }
}

class Candidate {
  String? id;
  String? avatarKey;
  String? firstName;
  String? email;
  String? lastName;

  Candidate(
      {this.id, this.avatarKey, this.firstName, this.email, this.lastName});

  Candidate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatarKey = json['avatar_key'];
    firstName = json['first_name'];
    email = json['email'];
    lastName = json['last_name'];
  }
}

class HiringStage {
  String? id;
  String? title;

  HiringStage({this.id, this.title});

  HiringStage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}

class Job {
  String? id;
  String? title;
  String? type;
  Department? department;

  Job({this.id, this.title, this.type, this.department});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }
}

class Department {
  String? name;

  Department({this.name});

  Department.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
