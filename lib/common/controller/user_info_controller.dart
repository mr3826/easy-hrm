import 'dart:developer';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/domain/user_info.dart';
import 'package:payrun_mobile/network/network_client.dart';
import '../../modules/auth/domain/org_subscription_Info_model.dart';
import '../../network/exception_helper.dart';
import '../../utils/api_endpoints.dart';

class UserInfoController {
  final NetworkClient _networkClient = Get.find<NetworkClient>();

  RxBool isSubscriptionExpired = false.obs;
  RxBool isSubscriptionTimeTrackingIsAllow = true.obs;
  UserInfo userInfo = UserInfo();

  Future<UserInfo?> getUserInfo() async {
    try {
      final response = await _networkClient.getRequest(Api.USER_INFO);
      if (response.statusCode != 200) return null;
      userInfo = UserInfo.fromJson(response.data);
      return userInfo;
    } catch (e) {
      log("getUserInfo $e");
    }
    return null;
  }

  /// Fetches the organization subscription information
  /// and checks the subscription status.
  Future<void> getOrgSubscriptionInfo() async {
    try {
      final response = await _networkClient.graphRequest(
          queryString: getOrgSubscriptionInfoQuery);
      print("getOrgSubscriptionInfo :: ${response.data}");

      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!,
            methodName: "getOrgSubscriptionInfo");
      } else {
        _checkIfSubscription(OrgSubscriptionInfoModel.fromJson(response.data!));
      }
    } catch (ex) {
      log("getOrgSubscriptionInfo: $ex");
    }
  }

  /// Checks the subscription status and features of an organization.
  ///
  /// This method verifies if the organization's subscription is either
  /// "paused" or "canceled". If so, it sets the [isSubscriptionExpired] flag.
  /// Otherwise, it checks if the "time_tracking" feature is enabled and sets
  /// the [isSubscriptionTimeTrackingIsAllow] flag accordingly.
  /// Finally, it navigates to the MAIN_SCREEN route.
  ///
  /// [data] - The organization's subscription information.
  void _checkIfSubscription(OrgSubscriptionInfoModel data) {
    final GetAnOrganizationSubscription? orgSubscriptionInfo =
        data.getAnOrganizationSubscription;
    try {
      // Check if subscription is not expired (active)
      if (!orgSubscriptionInfo!.status!.contains("active")) {
        isSubscriptionExpired(true);
      } else {
        // Check if "time_tracking" feature is enabled
        orgSubscriptionInfo.plan?.planFeatures?.forEach((feature) {
          if (feature.feature?.identifier == "time_tracking") {
            isSubscriptionTimeTrackingIsAllow(feature.isEnabled ?? false);
          }
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
