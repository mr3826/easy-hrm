class LeaveSummary {
  List<GetOrganizationUsersLeaveSummary>? getOrganizationUsersLeaveSummary;

  LeaveSummary({this.getOrganizationUsersLeaveSummary});

  LeaveSummary.fromJson(Map<String, dynamic> json) {
    if (json['getOrganizationUsersLeaveSummary'] != null) {
      getOrganizationUsersLeaveSummary = <GetOrganizationUsersLeaveSummary>[];
      json['getOrganizationUsersLeaveSummary'].forEach((v) {
        getOrganizationUsersLeaveSummary!
            .add(new GetOrganizationUsersLeaveSummary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getOrganizationUsersLeaveSummary != null) {
      data['getOrganizationUsersLeaveSummary'] = this
          .getOrganizationUsersLeaveSummary!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class GetOrganizationUsersLeaveSummary {
  dynamic allocated;
  String? approved;
  dynamic availableNumberOfApplications;
  String? availableNumberOfDays;
  String? calculateAllowanceBy;
  String? earnedDays;
  bool? isEarned;
  String? leaveStatusId;
  String? leaveTypeId;
  dynamic maximumConsecutiveDays;
  String? name;
  dynamic orgUserId;
  String? pendingReq;
  String? taken;
  String? type;

  GetOrganizationUsersLeaveSummary(
      {this.allocated,
        this.approved,
        this.availableNumberOfApplications,
        this.availableNumberOfDays,
        this.calculateAllowanceBy,
        this.earnedDays,
        this.isEarned,
        this.leaveStatusId,
        this.leaveTypeId,
        this.maximumConsecutiveDays,
        this.name,
        this.orgUserId,
        this.pendingReq,
        this.taken,
        this.type});

  GetOrganizationUsersLeaveSummary.fromJson(Map<String, dynamic> json) {
    allocated = json['allocated'];
    approved = json['approved'];
    availableNumberOfApplications = json['available_number_of_applications'];
    availableNumberOfDays = json['available_number_of_days'];
    calculateAllowanceBy = json['calculate_allowance_by'];
    earnedDays = json['earned_days'];
    isEarned = json['is_earned'];
    leaveStatusId = json['leave_status_id'];
    leaveTypeId = json['leave_type_id'];
    maximumConsecutiveDays = json['maximum_consecutive_days'];
    name = json['name'];
    orgUserId = json['org_user_id'];
    pendingReq = json['pending_req'];
    taken = json['taken'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allocated'] = this.allocated;
    data['approved'] = this.approved;
    data['available_number_of_applications'] =
        this.availableNumberOfApplications;
    data['available_number_of_days'] = this.availableNumberOfDays;
    data['calculate_allowance_by'] = this.calculateAllowanceBy;
    data['earned_days'] = this.earnedDays;
    data['is_earned'] = this.isEarned;
    data['leave_status_id'] = this.leaveStatusId;
    data['leave_type_id'] = this.leaveTypeId;
    data['maximum_consecutive_days'] = this.maximumConsecutiveDays;
    data['name'] = this.name;
    data['org_user_id'] = this.orgUserId;
    data['pending_req'] = this.pendingReq;
    data['taken'] = this.taken;
    data['type'] = this.type;
    return data;
  }
}
