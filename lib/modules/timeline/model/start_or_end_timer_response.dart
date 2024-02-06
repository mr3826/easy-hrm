class StartOrEndTimerResponse {
  StartOrStopTimer? startOrStopTimer;

  StartOrEndTimerResponse({this.startOrStopTimer});

  StartOrEndTimerResponse.fromJson(Map<String, dynamic> json) {
    startOrStopTimer = json['startOrStopTimer'] != null
        ?  StartOrStopTimer.fromJson(json['startOrStopTimer'])
        : null;
  }

}

class StartOrStopTimer {
  String? id;
  String? endDate;
  String? startDate;

  StartOrStopTimer({this.id, this.endDate, this.startDate});

  StartOrStopTimer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    endDate = json['end_date'];
    startDate = json['start_date'];
  }

}
