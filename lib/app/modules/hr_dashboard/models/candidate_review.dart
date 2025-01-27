class CandidateReviewModel {
  GetTeamNotes? getTeamNotes;

  CandidateReviewModel({this.getTeamNotes});

  CandidateReviewModel.fromJson(Map<String, dynamic> json) {
    getTeamNotes = json['getTeamNotes'] != null
        ? new GetTeamNotes.fromJson(json['getTeamNotes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getTeamNotes != null) {
      data['getTeamNotes'] = this.getTeamNotes!.toJson();
    }
    return data;
  }
}

class GetTeamNotes {
  List<Data>? data;

  GetTeamNotes({this.data});

  GetTeamNotes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  CandidateReview? candidateReview;
  String? id;
  String? note;
  String? type;
  String? createdAt;
  CreatedBy? createdBy;
  bool? immutable;

  Data(
      {this.candidateReview,
        this.id,
        this.note,
        this.type,
        this.createdAt,
        this.createdBy,
        this.immutable});

  Data.fromJson(Map<String, dynamic> json) {
    candidateReview = json['candidate_review'] != null
        ? new CandidateReview.fromJson(json['candidate_review'])
        : null;
    id = json['id'];
    note = json['note'];
    type = json['type'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    immutable = json['immutable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.candidateReview != null) {
      data['candidate_review'] = this.candidateReview!.toJson();
    }
    data['id'] = this.id;
    data['note'] = this.note;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    data['immutable'] = this.immutable;
    return data;
  }
}

class CandidateReview {
  String? createdAt;
  String? id;
  String? jobApplicationId;
  int? rate;
  String? updatedAt;

  CandidateReview(
      {this.createdAt,
        this.id,
        this.jobApplicationId,
        this.rate,
        this.updatedAt});

  CandidateReview.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    jobApplicationId = json['job_application_id'];
    rate = json['rate'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    data['job_application_id'] = this.jobApplicationId;
    data['rate'] = this.rate;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CreatedBy {
  Profile? profile;

  CreatedBy({this.profile});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? firstName;
  String? lastName;
  String? userId;
  String? image;
  String? id;

  Profile({this.firstName, this.lastName, this.userId, this.image, this.id});

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    userId = json['user_id'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['id'] = this.id;
    return data;
  }
}
