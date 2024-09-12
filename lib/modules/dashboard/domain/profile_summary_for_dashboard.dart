class ProfileSummaryForDashboard {
  GetProfileSummaryForDashboard? getProfileSummaryForDashboard;

  ProfileSummaryForDashboard({this.getProfileSummaryForDashboard});

  ProfileSummaryForDashboard.fromJson(Map<String, dynamic> json) {
    getProfileSummaryForDashboard =
    json['getProfileSummaryForDashboard'] != null
        ?  GetProfileSummaryForDashboard.fromJson(
        json['getProfileSummaryForDashboard'])
        : null;
  }
}

class GetProfileSummaryForDashboard {
  String? orgUserId;
  Profile? profile;
  String? totalSchedule;
  String? totalLogged;
  String? progressPercentage;

  GetProfileSummaryForDashboard(
      {this.orgUserId,
        this.profile,
        this.totalSchedule,
        this.totalLogged,
        this.progressPercentage});

  GetProfileSummaryForDashboard.fromJson(Map<String, dynamic> json) {
    orgUserId = json['org_user_id'];
    profile =
    json['profile'] != null ?  Profile.fromJson(json['profile']) : null;
    totalSchedule = json['total_schedule'];
    totalLogged = json['total_logged'];
    progressPercentage = json['progress_percentage'];
  }

}

class Profile {
  String? firstName;
  String? image;

  Profile({this.firstName, this.image});

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    image = json['image'];
  }

}
