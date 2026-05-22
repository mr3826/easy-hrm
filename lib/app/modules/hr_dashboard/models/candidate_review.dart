class CandidateReviewModel {
  GetTeamNotes? getTeamNotes;

  CandidateReviewModel({this.getTeamNotes});

  CandidateReviewModel.fromJson(Map<String, dynamic> json) {
    getTeamNotes = json['getTeamNotes'] != null
        ? GetTeamNotes.fromJson(json['getTeamNotes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getTeamNotes != null) {
      data['getTeamNotes'] = getTeamNotes!.toJson();
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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
        ? CandidateReview.fromJson(json['candidate_review'])
        : null;
    id = json['id'];
    note = json['note'];
    type = json['type'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
    immutable = json['immutable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (candidateReview != null) {
      data['candidate_review'] = candidateReview!.toJson();
    }
    data['id'] = id;
    data['note'] = note;
    data['type'] = type;
    data['createdAt'] = createdAt;
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    data['immutable'] = immutable;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['job_application_id'] = jobApplicationId;
    data['rate'] = rate;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class CreatedBy {
  Profile? profile;

  CreatedBy({this.profile});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_id'] = userId;
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}
