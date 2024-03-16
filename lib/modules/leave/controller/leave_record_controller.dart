import 'dart:developer';
import 'package:get/get.dart';
import 'package:payrun_mobile/network/network_client.dart';
import '../../../utils/api_endpoints.dart';
import '../model/leave_record_response.dart';

class LeaveRecordsController extends GetxController with StateMixin {
  @override
  void onInit() {
    getLeaveRecordsData();
    super.onInit();
  }

  List<GetLeaveRecordsForApp>? leaveRecordList;

  //todo
  //do pagination
  getLeaveRecordsData() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: getLeaveRecordsDataQuery, variables: {
      "optionData": {"limit": 50, "offset": 0}
    });
    if (response.hasException) {
      log(response.exception.toString());
    } else {
      leaveRecordList = LeaveRecord.fromJson(response.data!).getLeaveRecordsForApp!;
      print("leaveRecordList:${leaveRecordList?.length}");
    }
    log("getLeaveRecordsData :::::: ${response.data}");
    change(null, status: RxStatus.success());
  }

}

