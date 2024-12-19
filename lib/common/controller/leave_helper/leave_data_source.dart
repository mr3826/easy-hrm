import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import '../../../modules/profile/model/leave_summary.dart';
import '../../../network/exception_helper.dart';
import '../../../network/network_client.dart';
import '../../../utils/app_string.dart';

class LeaveDataSource{
  final NetworkClient networkClient;
  LeaveDataSource(this.networkClient);


  Future<LeaveSummary?> getLeaveSummary({String? orgId}) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: getLeaveSummaryQuery, variables: {
        "orgUserId": orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID)
      });
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getUserProfile");
      } else {
        return LeaveSummary.fromJson(response.data!);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }










}