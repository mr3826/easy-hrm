class ApplyLeaveResponse {
  AssignLeave? assignLeave;

  ApplyLeaveResponse({this.assignLeave});

  ApplyLeaveResponse.fromJson(Map<String, dynamic> json) {
    assignLeave = json['assignLeave'] != null
        ? AssignLeave.fromJson(json['assignLeave'])
        : null;
  }

}

class AssignLeave {
  String? id;

  AssignLeave({this.id});

  AssignLeave.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

}
