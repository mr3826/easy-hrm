import 'dart:developer';

import 'package:get/get.dart';
import 'package:payrun_mobile/modules/leave/model/leave_records.dart';
import 'package:payrun_mobile/network/network_client.dart';

import '../../../utils/api_endpoints.dart';

class LeaveRecordsController extends GetxController with StateMixin {
  LeaveRecords? leaveRecords;

  getLeaveRecords() async {
    change(null, status: RxStatus.loading());
    final response =
        await NetworkClient().getGraphQuery(queryString: getLeaveRecordsQuery);
    if (response.hasException) {
      log(response.exception.toString());
    } else {
      leaveRecords = LeaveRecords.fromJson(response.data!);
      log(leaveRecords.toString());
    }
    change(null, status: RxStatus.success());
  }

  @override
  void onInit() {
    getLeaveRecords();
    super.onInit();
  }
}
