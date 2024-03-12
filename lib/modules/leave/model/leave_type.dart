class LeaveTypeDropdown {
  List<GetLeaveTypesDropdown>? getLeaveTypesDropdown;

  LeaveTypeDropdown({this.getLeaveTypesDropdown});

  LeaveTypeDropdown.fromJson(Map<String, dynamic> json) {
    if (json['getLeaveTypesDropdown'] != null) {
      getLeaveTypesDropdown = <GetLeaveTypesDropdown>[];
      json['getLeaveTypesDropdown'].forEach((v) {
        getLeaveTypesDropdown!.add(GetLeaveTypesDropdown.fromJson(v));
      });
    }
  }
}

class GetLeaveTypesDropdown {
  String? name;
  String? id;
  String? type;
  bool? attachDocumentRequired;
  bool? addNoteRequired;
  List<LeaveStatuses>? leaveStatuses;
  String? calculateAllowanceBy;
  bool? isEarned;

  GetLeaveTypesDropdown(
      {this.name,
      this.id,
      this.type,
      this.attachDocumentRequired,
      this.addNoteRequired,
      this.leaveStatuses,
      this.calculateAllowanceBy,
      this.isEarned});

  GetLeaveTypesDropdown.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];
    attachDocumentRequired = json['attach_document_required'];
    addNoteRequired = json['add_note_required'];
    calculateAllowanceBy = json['calculate_allowance_by'];
    isEarned = json['is_earned'];
    if (json['leave_statuses'] != null) {
      leaveStatuses = <LeaveStatuses>[];
      json['leave_statuses'].forEach((v) {
        leaveStatuses!.add(LeaveStatuses.fromJson(v));
      });
    }
  }
}

class LeaveStatuses {
  dynamic availableNumberOfDays;
  dynamic availableNumberOfApplications;
  dynamic earnedDays;

  LeaveStatuses(
      {this.availableNumberOfDays,
      this.availableNumberOfApplications,
      this.earnedDays});

  LeaveStatuses.fromJson(Map<String, dynamic> json) {
    availableNumberOfDays = json['available_number_of_days'];
    availableNumberOfApplications = json['available_number_of_applications'];
    earnedDays = json['earned_days'];
  }
}
