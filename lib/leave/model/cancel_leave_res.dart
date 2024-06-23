class CancelLeaveResponse {
  UpdateLeave? updateLeave;

  CancelLeaveResponse({this.updateLeave});

  CancelLeaveResponse.fromJson(Map<String, dynamic> json) {
    updateLeave = json['updateLeave'] != null
        ? UpdateLeave.fromJson(json['updateLeave'])
        : null;
  }
}

class UpdateLeave {
  String? id;

  UpdateLeave({this.id});

  UpdateLeave.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}
