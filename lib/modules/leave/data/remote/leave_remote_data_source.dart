import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/network/network_client.dart';
import '../../../../common/domain/upload_policy.dart';
import '../../../../network/exception_helper.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/app_string.dart';
import '../../domain/leave_details_by_date.dart';
import '../../domain/leave_record_response.dart';
import '../../domain/leave_summary_dashboard.dart';
import '../../domain/leave_type.dart';
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

  Future<LeaveTypeDropdown?> getLeaveTypeDropdown() async {
    try {
      final response = await networkClient
          .graphRequest(queryString: leaveTypeDropdownUpdateQuery, variables: {
        "queryData": {
          "org_user_id": GetStorage().read(AppString.ORGANIZATION_USER_ID),
          "leave_type_id": null
        }
      });

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(exception: response.exception!);
        return null;
      }
      return LeaveTypeDropdown.fromJson(response.data!);
    } catch (e) {
      log('Error in getLeaveTypeDropdown: $e');
      return null;
    }
  }

  Future<bool> applyLeave(Map<String, dynamic> inputData) async {
    try {
      final response = await networkClient.graphRequest(
          queryString: assignLeaveQuery, variables: {"inputData": inputData});

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(exception: response.exception!);
        return false;
      }

      return true;
    } catch (e) {
      log('Error in applyLeave: $e');
      return true;
    }
  }

  Future<bool> getUploadPolicy(
      Map<String, dynamic> inputData, String fileName) async {
    try {
      final response = await networkClient.graphRequest(
          queryString: getUploadPolicyQuery,
          variables: {"queryData": inputData});

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(exception: response.exception!);
        return false;
      }

      UploadPolicyResponse uploadPolicyResponse =
          UploadPolicyResponse.fromJson(response.data!);

      return await uploadFile(
              url: uploadPolicyResponse.getUploadPolicy?.url ?? "",
              fileName: fileName,
              list: uploadPolicyResponse.getUploadPolicy?.policyData);
    } catch (e) {
      log('Error in getUploadPolicy: $e');
      return false;
    }
  }

  Future<bool> uploadFile({
    required String fileName,
    List<PolicyData>? list,
    required String url,
  }) async {
    // Return false immediately if the list is null or the URL is empty
    if (list == null || url.isEmpty) return false;

    try {
      // Prepare form data for the file upload
      FormData formData = FormData({
        for (var data in list) data.name!: data.value!,
      });

      // Add the file to the form data
      formData.files.add(MapEntry(
        "file",
        MultipartFile(
          File(fileName),
          filename:
          "${DateTime.now().millisecondsSinceEpoch}.${fileName.split('.').last}",
        ),
      ));

      // Perform the file upload
      final Response response = await networkClient.post(url, formData);

      // Check the response status and return true if successful
      if (response.statusCode == 200 || response.statusCode == 201|| response.statusCode == 204) {
        print("Upload successful with status: ${response.statusCode}");
        return true;
      } else {
        print("Upload failed with status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      // Handle any exceptions and return false
      print("Exception during upload: $e");
      return false;
    }
  }

}
