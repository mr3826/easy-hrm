import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/network/network_client.dart';
import '../../../../network/exception_helper.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/app_string.dart';
import '../../domain/leave_details_by_date.dart';
import '../../domain/leave_record_response.dart';
import '../../domain/leave_summary_dashboard.dart';
import '../../domain/workshief_response_by_date.dart';

class LeaveRemoteDataSource {
  final NetworkClient networkClient;

  LeaveRemoteDataSource(this.networkClient);

  Future<List<GetLeaveRecordsForApp>?> getLeaveRecordList(
      {required int limit, required int offset}) async {
    try {
      final response = await networkClient.graphRequest(
        queryString: getLeaveRecordsDataQuery,
        variables: {
          "optionData": {"limit": limit, "offset": offset}
        },
      );

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(exception: response.exception!);
        return null;
      }

      return LeaveRecord.fromJson(response.data!).getLeaveRecordsForApp;
    } catch (e) {
      log('Error in getLeaveRecordList: $e');
      return null;
    }
  }

  Future<LeaveSummaryForDashboard?> getLeaveSummaryForDashboard() async {
    try {
      final response = await networkClient.graphRequest(
        queryString: getLeaveSummaryForDashboardQuery,
      );

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(exception: response.exception!);
        return null;
      }

      return LeaveSummaryForDashboard.fromJson(response.data!);
    } catch (e) {
      log('Error in getLeaveSummaryForDashboard: $e');
      return null;
    }
  }

  Future<LeaveDetailsByDate?> getLeaveRecordByDate(
      {required String startDate, required String endDate}) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: getLeaveDetailsByDateQuery, variables: {
        "queryData": {
          "start_date": "$startDate 00:00:00",
          "end_date": "$endDate 23:59:00"
        }
      });

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(exception: response.exception!);
        return null;
      }

      return LeaveDetailsByDate.fromJson(response.data!);
    } catch (e) {
      log('Error in getLeaveRecordByDate: $e');
      return null;
    }
  }

  Future<WorkShiftResponse?> getWorkShift() async {
    try {
      final response = await networkClient
          .graphRequest(queryString: workShiftQuery, variables: {
        "queryData": {
          "employee_id": GetStorage().read(AppString.ORGANIZATION_USER_ID),
        }
      });

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(exception: response.exception!);
        return null;
      }

      return WorkShiftResponse.fromJson(response.data!);
    } catch (e) {
      log('Error in getWorkShift: $e');
      return null;
    }
  }

  Future<bool> cancelLeave({required String leaveId}) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: cancelLeaveQuery, variables: {
        "inputData": {"leave_id": leaveId, "status": "cancelled"}
      });

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(exception: response.exception!);
        return false;
      }

      return true;
    } catch (e) {
      log('Error in cancelLeave: $e');
      return false;
    }
  }

  Future<bool> removeLeave({required String leaveId}) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: removeLeaveQuery, variables: {
        "inputData": {"leave_id": leaveId}
      });

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(exception: response.exception!);
        return false;
      }

      return true;
    } catch (e) {
      log('Error in removeLeave: $e');
      return false;
    }
  }
}
