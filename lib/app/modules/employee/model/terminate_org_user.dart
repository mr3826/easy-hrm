class TerminateUserModel {
  String orgUserId;
  String terminationTypeEnum;
  String terminationOrResignationDate;
  String? terminationOrResignationReason;

  TerminateUserModel({
    required this.orgUserId,
    required this.terminationTypeEnum,
    required this.terminationOrResignationDate,
    this.terminationOrResignationReason = "",
  });

  @override
  String toString() {
    return 'TerminateUserModel{orgUserId: $orgUserId, terminationTypeEnum: $terminationTypeEnum, terminationOrResignationDate: $terminationOrResignationDate, terminationOrResignationReason: $terminationOrResignationReason}';
  }
}


class TerminateOrgUserRes {
  TerminateOrganizationUser? terminateOrganizationUser;

  TerminateOrgUserRes({this.terminateOrganizationUser});

  TerminateOrgUserRes.fromJson(Map<String, dynamic> json) {
    terminateOrganizationUser = json['terminateOrganizationUser'] != null
        ? new TerminateOrganizationUser.fromJson(
        json['terminateOrganizationUser'])
        : null;
  }
}

class TerminateOrganizationUser {
  String? id;
  String? status;

  TerminateOrganizationUser({this.id, this.status});

  TerminateOrganizationUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

}
