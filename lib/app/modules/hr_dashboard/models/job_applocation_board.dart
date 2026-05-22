class JobApplicationBoard {
  GetJobApplicationBoard? getJobApplicationBoard;

  JobApplicationBoard({this.getJobApplicationBoard});

  JobApplicationBoard.fromJson(Map<String, dynamic> json) {
    getJobApplicationBoard = json['getJobApplicationBoard'] != null
        ? GetJobApplicationBoard.fromJson(json['getJobApplicationBoard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getJobApplicationBoard != null) {
      data['getJobApplicationBoard'] = getJobApplicationBoard!.toJson();
    }
    return data;
  }
}

class GetJobApplicationBoard {
  String? id;
  String? title;
  String? type;
  String? lastDateOfApply;
  String? location;
  String? status;
  Department? department;
  List<HiringStages>? hiringStages;

  GetJobApplicationBoard(
      {this.id,
        this.title,
        this.type,
        this.lastDateOfApply,
        this.location,
        this.status,
        this.department,
        this.hiringStages});

  GetJobApplicationBoard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    lastDateOfApply = json['last_date_of_apply'];
    location = json['location'];
    status = json['status'];
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    if (json['hiring_stages'] != null) {
      hiringStages = <HiringStages>[];
      json['hiring_stages'].forEach((v) {
        hiringStages!.add(HiringStages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['last_date_of_apply'] = lastDateOfApply;
    data['location'] = location;
    data['status'] = status;
    if (department != null) {
      data['department'] = department!.toJson();
    }
    if (hiringStages != null) {
      data['hiring_stages'] =
          hiringStages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Department {
  String? name;

  Department({this.name});

  Department.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class HiringStages {
  String? id;
  String? title;
  int? noOfApplicant;
  List<JobApplications>? jobApplications;

  HiringStages({this.id, this.title,this.jobApplications,this.noOfApplicant});

  HiringStages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    noOfApplicant = json['no_of_applicant'];
    if (json['job_applications'] != null) {
      jobApplications = <JobApplications>[];
      json['job_applications'].forEach((v) {
        jobApplications!.add(JobApplications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['no_of_applicant'] = noOfApplicant;
    if (jobApplications != null) {
      data['job_applications'] =
          jobApplications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobApplications {
  String? id;
  int? priority;
  Candidate? candidate;

  JobApplications({this.id, this.priority, this.candidate});

  JobApplications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priority = json['priority'];
    candidate = json['candidate'] != null
        ? Candidate.fromJson(json['candidate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['priority'] = priority;
    if (candidate != null) {
      data['candidate'] = candidate!.toJson();
    }
    return data;
  }
}

class Candidate {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic avatarKey;

  Candidate({this.id, this.firstName, this.lastName, this.avatarKey,this.email});

  Candidate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatarKey = json['avatar_key'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar_key'] = avatarKey;
    data['email'] = email;
    return data;
  }
}
