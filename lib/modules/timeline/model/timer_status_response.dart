class TimerResponse {
  CheckStartOrStopTimeline? checkStartOrStopTimeline;

  TimerResponse({this.checkStartOrStopTimeline});

  TimerResponse.fromJson(Map<String, dynamic> json) {
    checkStartOrStopTimeline = json['checkStartOrStopTimeline'] != null
        ? CheckStartOrStopTimeline.fromJson(json['checkStartOrStopTimeline'])
        : null;
  }
}

class CheckStartOrStopTimeline {
  String? startDate;

  CheckStartOrStopTimeline({this.startDate});

  CheckStartOrStopTimeline.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
  }
}
