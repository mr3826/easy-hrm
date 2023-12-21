import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/timeline/controller/timer_controller.dart';
import 'package:payrun_mobile/modules/timeline/model/project_dropdown_response.dart';
import 'package:payrun_mobile/modules/timeline/model/start_or_end_timer_response.dart';
import 'package:payrun_mobile/modules/timeline/model/timer_entry_response.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';

class TimelineController extends GetxController {
  @override
  void onInit() {
    getProjectDropdown();
    super.onInit();
  }

  final isLoading = false.obs;
  final taskName = "".obs;
  StartOrEndTimerResponse? startOrEndTimerResponse;
  TimerEntryResponse? timerEntryResponse;
  ProjectDropDownResponse? projectDropDownResponse;

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
      if (startOrEndTimerResponse?.startOrStopTimer?.endDate == null) {
        showSuccessMessage(message: AppString.timerStartedSuccessfulMessage);
        Get.find<TimeCounterController>().start();
      } else {
        Get.find<TimeCounterController>().stop();
      }
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

  getProjectDropdown() async {
    isLoading(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: getProjectDropdownQuery, variables: {
      "queryData": {"searchText": taskSearchController.text},
      "optionData": {"limit": 200}
    });

    if (response.hasException) {
      log("getProjectDropdown", error: response.exception.toString());
    } else {
      projectDropDownResponse =
          ProjectDropDownResponse.fromJson(response.data!);
    }
    isLoading(false);
  }
}
