import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import '../../../modules/profile/model/employee_work_history.dart';
import '../../../modules/profile/model/user_log_history.dart';
import '../../../modules/profile/model/user_profile.dart';
import '../../../network/exception_helper.dart';
import '../../../network/network_client.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/app_string.dart';

class ProfileDataSource {

  final NetworkClient networkClient;
  ProfileDataSource(this.networkClient);

  Future<UserDetails?> getUserProfile({String? orgId}) async {

    try {
      final response = await networkClient
          .graphRequest(queryString: getUserProfileQuery, variables: {
        "orgUserId": orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID)
      });
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getUserProfile");
      } else {
        return UserDetails.fromJson(response.data!);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<UserLogHistory?> getUserLogHistory() async {
    try {
      final response =
          await networkClient.graphRequest(queryString: userLogHistoryQuery);
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getUserLogHistory");
      } else {
        return UserLogHistory.fromJson(response.data!);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }


  Future<EmployeeWorkHistory?> getEmploymentInfo({String ?orgId}) async {
    try {
      final response = await networkClient.graphRequest(
          queryString: getEmploymentInfoQuery, variables: {
        "orgUserId": orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID)});
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getEmploymentInfo");
      } else {
        return EmployeeWorkHistory.fromJson(response.data!);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
