class CandidateDetails {
  GetCandidateDetails? getCandidateDetails;

  CandidateDetails({this.getCandidateDetails});

  CandidateDetails.fromJson(Map<String, dynamic> json) {
    getCandidateDetails = json['getCandidateDetails'] != null
        ? new GetCandidateDetails.fromJson(json['getCandidateDetails'])
        : null;
  }
}

class GetCandidateDetails {
  String? id;
  int? avgRating;
  int? totalReview;
  Candidate? candidate;
  HiringStage? hiringStage;
  HiringStage? job;

  GetCandidateDetails(
      {this.id,
        this.avgRating,
        this.totalReview,
        this.candidate,
        this.hiringStage,
        this.job});

  GetCandidateDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avgRating = json['avg_rating'];
    totalReview = json['total_review'];
    candidate = json['candidate'] != null
        ? new Candidate.fromJson(json['candidate'])
        : null;
    hiringStage = json['hiring_stage'] != null
        ? new HiringStage.fromJson(json['hiring_stage'])
        : null;
    job = json['job'] != null ? new HiringStage.fromJson(json['job']) : null;
  }
}

class Candidate {
  String? avatarKey;
  String? firstName;
  String? id;
  String? email;
  String? lastName;

  Candidate(
      {this.avatarKey, this.firstName, this.id, this.email, this.lastName});

  Candidate.fromJson(Map<String, dynamic> json) {
    avatarKey = json['avatar_key'];
    firstName = json['first_name'];
    id = json['id'];
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
