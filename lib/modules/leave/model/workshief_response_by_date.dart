class WorkShiftResponse {
  List<GetWorkScheduleForAssignLeave>? getWorkScheduleForAssignLeave;

  WorkShiftResponse({this.getWorkScheduleForAssignLeave});

  WorkShiftResponse.fromJson(Map<String, dynamic> json) {
    if (json['getWorkScheduleForAssignLeave'] != null) {
      getWorkScheduleForAssignLeave = <GetWorkScheduleForAssignLeave>[];
      json['getWorkScheduleForAssignLeave'].forEach((v) {
        getWorkScheduleForAssignLeave!
            .add(GetWorkScheduleForAssignLeave.fromJson(v));
      });
    }
  }
}

class GetWorkScheduleForAssignLeave {
  String? day;
  int? dayOfWeek;
  String? endTime;
  String? id;
  bool? isHoliday;
  String? startTime;

  GetWorkScheduleForAssignLeave(
      {this.day,
      this.dayOfWeek,
      this.endTime,
      this.id,
      this.isHoliday,
      this.startTime});

  GetWorkScheduleForAssignLeave.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    dayOfWeek = json['day_of_week'];
    endTime = json['end_time'];
    id = json['id'];
    isHoliday = json['is_holiday'];
    startTime = json['start_time'];
  }
}
