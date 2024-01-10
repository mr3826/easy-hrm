import 'dart:developer';

import 'package:get/get.dart';
import 'package:payrun_mobile/modules/leave/model/leave_type.dart';

import '../../../network/network_client.dart';
import '../../../utils/api_endpoints.dart';

class UpdateLeaveController extends GetxController {
  @override
  void onInit() {
    getLeaveType();
    super.onInit();
  }

  LeaveTypeDropdown? leaveTypeDropdown;
  List<String?>? leaveType;
  final isLoading = false.obs;

  getLeaveType() async {
    isLoading(false);
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
}
