class TimerEntryResponse {
  UpdateTimelineEntry? updateTimelineEntry;

  TimerEntryResponse({this.updateTimelineEntry});

  TimerEntryResponse.fromJson(Map<String, dynamic> json) {
    updateTimelineEntry = json['updateTimelineEntry'] != null
        ? UpdateTimelineEntry.fromJson(json['updateTimelineEntry'])
        : null;
  }
}

class UpdateTimelineEntry {
  String? endDate;
  String? description;
  String? startDate;
  String? status;
  String? taskId;

  UpdateTimelineEntry(
      {this.endDate, this.description, this.startDate, this.status});

  UpdateTimelineEntry.fromJson(Map<String, dynamic> json) {
    endDate = json['end_date'];
    description = json['description'];
    startDate = json['start_date'];
    status = json['status'];
    taskId = json['task_id'];
  }
}
