class UpdateTimelogEntry {
  UpdateTimelineEntry? updateTimelineEntry;

  UpdateTimelogEntry({this.updateTimelineEntry});

  UpdateTimelogEntry.fromJson(Map<String, dynamic> json) {
    updateTimelineEntry = json['updateTimelineEntry'] != null
        ? new UpdateTimelineEntry.fromJson(json['updateTimelineEntry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.updateTimelineEntry != null) {
      data['updateTimelineEntry'] = this.updateTimelineEntry!.toJson();
    }
    return data;
  }
}

class UpdateTimelineEntry {
  String? id;
  String? orgUserId;
  String? startDate;
  String? endDate;

  UpdateTimelineEntry({this.id, this.orgUserId, this.startDate, this.endDate});

  UpdateTimelineEntry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orgUserId = json['org_user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['org_user_id'] = this.orgUserId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
