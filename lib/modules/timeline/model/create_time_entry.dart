class CreateTimelineEntryResponse {
  CreateTimelineEntry? createTimelineEntry;

  CreateTimelineEntryResponse({this.createTimelineEntry});

  CreateTimelineEntryResponse.fromJson(Map<String, dynamic> json) {
    createTimelineEntry = json['createTimelineEntry'] != null
        ? CreateTimelineEntry.fromJson(json['createTimelineEntry'])
        : null;
  }
}

class CreateTimelineEntry {
  String? id;
  String? endDate;
  String? startDate;
  String? description;
  String? status;
  String? taskId;

  CreateTimelineEntry(
      {this.id,
      this.endDate,
      this.startDate,
      this.description,
      this.status,
      this.taskId});

  CreateTimelineEntry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    description = json['description'];
    status = json['status'];
    taskId = json['task_id'];
  }
}
