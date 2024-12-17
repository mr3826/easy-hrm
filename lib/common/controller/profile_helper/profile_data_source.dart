import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import '../../../modules/profile/model/user_profile_model.dart';
import '../../../network/exception_helper.dart';
import '../../../network/network_client.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/app_string.dart';

class ProfileDataSource {
  final NetworkClient networkClient;
  ProfileDataSource(this.networkClient);

  Future<UserProfileModel?> getUserProfile({String? orgId}) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: getUserProfileQuery, variables: {
        "orgUserId": orgId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID)
      });
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "getUserProfile");
      } else {
        return UserProfileModel.fromJson(response.data!);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
