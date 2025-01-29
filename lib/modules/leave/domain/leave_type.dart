class LeaveTypeDropdown {
  List<GetAvailableLeaveTypes>? getAvailableLeaveTypes;

  LeaveTypeDropdown({this.getAvailableLeaveTypes});

  LeaveTypeDropdown.fromJson(Map<String, dynamic> json) {
    if (json['getAvailableLeaveTypes'] != null) {
      getAvailableLeaveTypes = <GetAvailableLeaveTypes>[];
      json['getAvailableLeaveTypes'].forEach((v) {
        getAvailableLeaveTypes!.add(new GetAvailableLeaveTypes.fromJson(v));
      });
    }
  }
}

class GetAvailableLeaveTypes {
  bool? addNoteRequired;
  bool? attachDocumentRequired;
  String? availableLeave;
  String? calculateAllowanceBy;
  bool? isDefault;
  bool? isEnable;
  String? leaveTypeId;
  String? leaveStatusId;
  String? name;
  String? type;

  GetAvailableLeaveTypes(
      {this.addNoteRequired,
        this.attachDocumentRequired,
        this.availableLeave,
        this.calculateAllowanceBy,
        this.isDefault,
        this.isEnable,
        this.leaveTypeId,
        this.name,
        this.type});

  GetAvailableLeaveTypes.fromJson(Map<String, dynamic> json) {
    addNoteRequired = json['add_note_required'];
    attachDocumentRequired = json['attach_document_required'];
    availableLeave = json['availableLeave'];
    calculateAllowanceBy = json['calculate_allowance_by'];
    isDefault = json['is_default'];
    isEnable = json['is_enable'];
    leaveTypeId = json['leave_type_id'];
    leaveStatusId = json['leave_status_id'];
    name = json['name'];
    type = json['type'];
  }

}
