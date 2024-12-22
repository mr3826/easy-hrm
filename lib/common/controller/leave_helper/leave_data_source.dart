import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import '../../../modules/profile/model/leave_summary.dart';
import '../../../network/exception_helper.dart';
import '../../../network/network_client.dart';
import '../../../utils/app_string.dart';

class LeaveDataSource {
  final NetworkClient networkClient;
  LeaveDataSource(this.networkClient);

  Future<LeaveSummary?> getLeaveSummary({String? orgId}) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: getLeaveSummaryQuery, variables: {
        "queryData": {
          "org_user_id":
              orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID),
          "start_year": "${DateTime.now().year}"
        }
      });
      print("getLeaveSummary :: ${response.data}");
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getLeaveSummary");
      } else {
        return LeaveSummary.fromJson(response.data!);
      }
    } catch (e) {
      log("getLeaveSummary :: ${e.toString()}");
    }
    return null;
  }



  Future<bool> applyLeave(Map<String, dynamic> inputData) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: updateOrgUserLeaveAvailabilityQuery, variables:inputData

      // {
      //   "inputData": {
      //     "leave_status_id": "61acc2da-670c-4d0f-9c2b-e284105bc5cc",
      //     "available_number_of_days": 1,
      //     "available_number_of_applications": "",
      //     "maximum_consecutive_days": "",
      //   }
      // }
      //

      );

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "applyLeave");
        return false;
      }

      return true;
    } catch (e) {
      log('Error in applyLeave: $e');
      return true;
    }
  }
}
