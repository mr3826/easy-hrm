import 'dart:async';

import 'package:get/get.dart';
import 'package:payrun_mobile/modules/timeline/model/start_or_end_timer_response.dart';
import 'package:payrun_mobile/modules/timeline/model/timer_entry_response.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';

class TimelineController extends GetxController {
  StartOrEndTimerResponse? startOrEndTimerResponse;
  TimerEntryResponse? timerEntryResponse;

  startOrEndTimer({required String timerType}) async {
    print("Method Called");
    final response =
        await NetworkClient().mutationGraphData(startOrEndTimerQueryData, {
      "inputData": {"timer_type": timerType}
    });

    if (response.hasException) {
      print(response.exception.toString());
    } else {
      startOrEndTimerResponse =
          StartOrEndTimerResponse.fromJson(response.data!);
    }
  }

  saveTimeEntry({required StartOrStopTimer startOrStopTimer}) async {
    startOrStopTimer.id;
    final response =
        await NetworkClient().mutationGraphData(saveTimerQueryData, {
      "inputData": {
        "timeline_id": startOrStopTimer.id ?? "",
        "end_date": startOrStopTimer.endDate ?? "",
        "start_date": startOrStopTimer.startDate ?? "",
        "task_id": null,
        "description": null
      }
    });

    if (response.hasException) {
      print(response.exception.toString());
    } else {
      timerEntryResponse = TimerEntryResponse.fromJson(response.data!);
    }
  }
}
