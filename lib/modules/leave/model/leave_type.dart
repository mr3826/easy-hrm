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
  bool? attachDocumentRequired;
  bool? addNoteRequired;
  List<LeaveStatuses>? leaveStatuses;

  GetLeaveTypesDropdown(
      {this.name,
      this.id,
      this.attachDocumentRequired,
      this.addNoteRequired,
      this.leaveStatuses});

  GetLeaveTypesDropdown.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    attachDocumentRequired = json['attach_document_required'];
    addNoteRequired = json['add_note_required'];
    if (json['leave_statuses'] != null) {
      leaveStatuses = <LeaveStatuses>[];
      json['leave_statuses'].forEach((v) {
        leaveStatuses!.add(new LeaveStatuses.fromJson(v));
      });
    }
  }
}

class LeaveStatuses {
  int? availableNumberOfDays;

  LeaveStatuses({this.availableNumberOfDays});

  LeaveStatuses.fromJson(Map<String, dynamic> json) {
    availableNumberOfDays = json['available_number_of_days'];
  }
}
