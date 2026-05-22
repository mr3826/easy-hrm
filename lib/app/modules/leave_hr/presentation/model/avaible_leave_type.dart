class AvailableLeaveType {
  List<GetAvailableLeaveTypes>? getAvailableLeaveTypes;

  AvailableLeaveType({this.getAvailableLeaveTypes});

  AvailableLeaveType.fromJson(Map<String, dynamic> json) {
    if (json['getAvailableLeaveTypes'] != null) {
      getAvailableLeaveTypes = <GetAvailableLeaveTypes>[];
      json['getAvailableLeaveTypes'].forEach((v) {
        getAvailableLeaveTypes!.add(GetAvailableLeaveTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAvailableLeaveTypes != null) {
      data['getAvailableLeaveTypes'] =
          getAvailableLeaveTypes!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['add_note_required'] = addNoteRequired;
    data['attach_document_required'] = attachDocumentRequired;
    data['availableLeave'] = availableLeave;
    data['calculate_allowance_by'] = calculateAllowanceBy;
    data['is_default'] = isDefault;
    data['is_enable'] = isEnable;
    data['leave_type_id'] = leaveTypeId;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}