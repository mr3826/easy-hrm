class AvailableLeaveType {
  List<GetAvailableLeaveTypes>? getAvailableLeaveTypes;

  AvailableLeaveType({this.getAvailableLeaveTypes});

  AvailableLeaveType.fromJson(Map<String, dynamic> json) {
    if (json['getAvailableLeaveTypes'] != null) {
      getAvailableLeaveTypes = <GetAvailableLeaveTypes>[];
      json['getAvailableLeaveTypes'].forEach((v) {
        getAvailableLeaveTypes!.add(new GetAvailableLeaveTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getAvailableLeaveTypes != null) {
      data['getAvailableLeaveTypes'] =
          this.getAvailableLeaveTypes!.map((v) => v.toJson()).toList();
    }
    return data;
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
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add_note_required'] = this.addNoteRequired;
    data['attach_document_required'] = this.attachDocumentRequired;
    data['availableLeave'] = this.availableLeave;
    data['calculate_allowance_by'] = this.calculateAllowanceBy;
    data['is_default'] = this.isDefault;
    data['is_enable'] = this.isEnable;
    data['leave_type_id'] = this.leaveTypeId;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}