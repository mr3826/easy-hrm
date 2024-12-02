import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/utils/app_string.dart';

import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../presentation/model/hr_leave_calender.dart';

class HrLeaveRemoteDataSource {
  final NetworkClient networkClient;

  HrLeaveRemoteDataSource(this.networkClient);

  Future<HrLeaveCalender?> getLeaveCalender({
    String? startDate,
    String? endDate,
  }) async {
    try {
      final defaultStartDate = _getDefaultStartDate();
      final defaultEndDate = _getDefaultEndDate();



      //log(GetStorage().read(AppString.ACCESS_TOKEN));

      final response = await networkClient.graphRequest(
        queryString: getHrLeaveCalendarList,
        variables: {
          "queryData": {
            "startDate": startDate ?? defaultStartDate,
            "endDate": endDate ?? defaultEndDate,
          },
        },
      );

      log("getLeaveCalender_response: ${response.data}");

      if (response.hasException) {
        final exceptionMessage = response.exception.toString();
        log("getLeaveCalender exception: $exceptionMessage");
        ExceptionHelper.errorHandler(
          exception: response.exception!,
          methodName: "getLeaveCalender",
        );
        return null;
      }

      return response.data != null
          ? HrLeaveCalender.fromJson(response.data!)
          : null;
    } catch (e, stackTrace) {
      log('Error in getLeaveCalender: $e', stackTrace: stackTrace);
      return null;
    }
  }

  String _getDefaultStartDate() {
    final now = DateTime.now();
    return "${DateTime(now.year, now.month, 1)
        .toIso8601String()
        .split('T')[0]}T00:00:00.000Z";
  }

  String _getDefaultEndDate() {
    final now = DateTime.now();
    return "${DateTime(now.year, now.month + 1, 0)
        .toIso8601String()
        .split('T')[0]}T23:59:59.999Z";
  }




  Future<bool> updateLeave({required String leaveId,String? status}) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: updateLeaveQuery, variables: {
        "inputData": {"leave_id": leaveId, "status": status??"cancelled"}
      });

      print("updateLeave :: ${response.data}");

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(exception: response.exception!,methodName: "updateLeave");
        return false;
      }

      return true;
    } catch (e) {
      log('Error in cancelLeave: $e');
      return false;
    }
  }


























}
