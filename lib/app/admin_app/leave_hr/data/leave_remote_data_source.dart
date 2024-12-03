import 'dart:developer';
import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../presentation/model/hr_leave_calender.dart';
import '../presentation/model/leave_details_by_id.dart';

class HrLeaveRemoteDataSource {
  final NetworkClient networkClient;

  HrLeaveRemoteDataSource(this.networkClient);

  Future<HrLeaveCalender?> getLeaveCalender({
    String? startDate,
    String? endDate,
  }) async {
    try {

      final response = await networkClient.graphRequest(
        queryString: getHrLeaveCalendarList,
        variables: {
          "queryData": {
             "startDate": startDate ?? _getDefaultStartDate(),
             "endDate": endDate ?? _getDefaultEndDate(),
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
    } catch (e) {
      log('Error in getLeaveCalender: $e');
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




  Future<LeaveDetailsById?> getLeaveDetailsById(String? leaveId) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: getLeaveDetailsByIdQuery, variables: {
        "queryData": {
          "leave_id": leaveId
        }
      }
      );
      print("getLeaveDetailsById :: ${response.data}");
      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getLeaveDetailsById");
        return null;
      }

      return LeaveDetailsById.fromJson(response.data!);
    } catch (e) {
      log('Error in getLeaveDetailsById: $e');
      return null;
    }
  }
}
