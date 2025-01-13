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
