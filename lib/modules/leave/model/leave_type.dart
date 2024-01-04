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
  String? type;
  String? id;

  GetLeaveTypesDropdown({this.name, this.type, this.id});

  GetLeaveTypesDropdown.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    id = json['id'];
  }
}
