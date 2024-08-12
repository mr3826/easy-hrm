import 'dart:developer';

import 'package:payrun_mobile/network/network_client.dart';

import '../../../../utils/api_endpoints.dart';
import '../../domain/leave_record_response.dart';

class LeaveRemoteDataSource {
  NetworkClient networkClient;

  LeaveRemoteDataSource(this.networkClient);

  Future<List<GetLeaveRecordsForApp>?> getLeaveRecordList(
      {required int offset}) async {
    final response = await networkClient
        .graphRequest(queryString: getLeaveRecordsDataQuery, variables: {
      "optionData": {"limit": 50, "offset": offset}
    });

    print("getLeaveRecordList: ${response.data}");

    if (response.hasException) {
      log(response.exception.toString());
    } else {
      return LeaveRecord.fromJson(response.data!).getLeaveRecordsForApp!;
    }
    return null;
  }
}
