import 'dart:developer';

import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/modules/home/view/screen/main_screen.dart';
import 'package:payrun_mobile/modules/leave/model/apply_leave_response.dart';
import 'package:payrun_mobile/modules/leave/model/leave_type.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';

class ApplyLeaveController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    getLeaveType();
  }

  LeaveTypeDropdown? leaveTypeDropdown;

  final isLoading = false.obs;
  final isAssignLeaveLoaderLoading = false.obs;

  List<String?>? leaveType;

  getLeaveType() async {
    isLoading(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: leaveTypeDropdownQuery);

    if (response.hasException) {
      log("getLeaveType:: ${response.exception.toString()}");
    } else {
      leaveTypeDropdown = LeaveTypeDropdown.fromJson(response.data!);
      leaveType =
          leaveTypeDropdown?.getLeaveTypesDropdown?.map((e) => e.name).toList();
    }
    isLoading(false);
  }

  applyLeave() async {
    isAssignLeaveLoaderLoading(true);
    final response = await NetworkClient().mutationGraphData(assignLeaveQuery, {
      "inputData": {
        "description": leaveNoteController.text,
        "end_date": Get.find<DateTimeController>().requestedOutDate.value,
        "start_date": Get.find<DateTimeController>().requestedInDate.value,
        "status": "pending",
        "leave_type_id": Get.find<DateTimeController>().leaveId?.value ?? ""
      }
    });

    if (response.hasException) {
      log("applyLeave${response.exception.toString()}");
    } else {
      print(ApplyLeaveResponse.fromJson(response.data!).assignLeave?.id);
      leaveNoteController.clear();
      Get.off(() => MainScreen(
            routeIndex: 1,
          ));
    }
    isAssignLeaveLoaderLoading(false);
  }

}
