class UpdateTimelogEntry {
  UpdateTimelineEntry? updateTimelineEntry;

  UpdateTimelogEntry({this.updateTimelineEntry});

  UpdateTimelogEntry.fromJson(Map<String, dynamic> json) {
    updateTimelineEntry = json['updateTimelineEntry'] != null
        ? UpdateTimelineEntry.fromJson(json['updateTimelineEntry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (updateTimelineEntry != null) {
      data['updateTimelineEntry'] = updateTimelineEntry!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['org_user_id'] = orgUserId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}
