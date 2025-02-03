import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/app_string.dart';
import '../presentation/model/avaible_leave_type.dart';
import '../presentation/model/download_file.dart';
import '../presentation/model/hr_leave_calender.dart';
import '../presentation/model/hr_leave_record.dart';
import '../presentation/model/leave_details_by_id.dart';

class HrLeaveRemoteDataSource {
  final NetworkClient networkClient;

  HrLeaveRemoteDataSource(this.networkClient);

  Future<HrLeaveCalender?> getLeaveCalender(
      {required Map<String, Map<String, Object>> queryMap}) async {
    try {
      final response = await networkClient.graphRequest(
        queryString: getHrLeaveCalendarList,
        variables: queryMap,
      );
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getLeaveCalender");
        return null;
      }
      return HrLeaveCalender.fromJson(response.data!);
    } catch (e) {
      log('Error in getLeaveCalender: $e');
      return null;
    }
  }

  Future<bool> updateLeave(
      {required String leaveId, required String status}) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: updateLeaveQuery, variables: {
        "inputData": {"leave_id": leaveId, "status": status}
      });
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "updateLeave");
        return false;
      }
      return true;
    } catch (e) {
      log('Error in cancelLeave: $e');
      return false;
    }
  }

  Future<LeaveDetailsById?> getLeaveDetailsById(String leaveId) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: getLeaveDetailsByIdQuery, variables: {
        "queryData": {"leave_id": leaveId}
      });

      print("getLeaveDetailsById:: ${response.data}");
      if (response.hasException) {
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

  ///todo [Download link]
  Future<DownloadFile?> getFileSignUrl(String? fileKey) async {
    final urlPath = '${"files"}/${GetStorage().read(AppString.ORGANIZATION_ID)}/$fileKey';
    try {
      final response = await networkClient.graphRequest(
          queryString: getFileSignUrlQuery,
          variables: {"fileKey": urlPath, "isDownload": true});
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getFileSignUrl");
        return null;
      }
      return DownloadFile.fromJson(response.data!);
    } catch (e) {
      log('Error in getFileSignUrl: $e');
      return null;
    }
  }

  Future<HrLeaveRecorde?> getLeaveRecord(
      Map<String, Map<String, Object>> queryMap) async {
    try {
      var response = await networkClient.graphRequest(
          queryString: getHrLeaveRecordeQuery, variables: queryMap);
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getLeaveRecord");
        return null;
      }
      return HrLeaveRecorde.fromJson(response.data!);
    } catch (e) {
      log('Error in getLeaveRecord: $e');
      return null;
    }
  }

  Future<AvailableLeaveType?> getAvailableLeaveType(
      {required String orgUserId, String? year}) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: getAvailableLeavesTypeQuery, variables: {
        "queryData": {"org_user_id": orgUserId, "start_year": year},
      });

      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getLeaveRecord");
        return null;
      }
      return AvailableLeaveType.fromJson(response.data!);
    } catch (e) {
      log('Error in getLeaveRecord: $e');
      return null;
    }
  }
}