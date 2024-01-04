import 'dart:developer';

import 'package:get/get.dart';
import 'package:payrun_mobile/modules/leave/model/leave_type.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';

class ApplyLeaveController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  LeaveTypeDropdown? leaveTypeDropdown;

  List<String?>? leaveType;

  getLeaveType() async {
    final response = await NetworkClient()
        .getGraphQuery(queryString: leaveTypeDropdownQuery);

    if (response.hasException) {
      log("getLeaveType:: ${response.exception.toString()}");
    } else {
      leaveTypeDropdown = LeaveTypeDropdown.fromJson(response.data!);
      leaveType =
          leaveTypeDropdown?.getLeaveTypesDropdown?.map((e) => e.name).toList();
    }
  }

  applyLeave() async {
    final response = await NetworkClient().mutationGraphData(assignLeaveQuery, {
      "inputData": {
        "description": null,
        "end_date": null,
        "start_date": null,
        "status": null,
        "leave_type_id": null,
        "assigned_to": null,
        "files": [
          {"name": null}
        ]
      }
    });
  }

// getUploadPolicy() async {
//   final response = await NetworkClient().getGraphQuery(
//       queryString: queryString);
// }
}
