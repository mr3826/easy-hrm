import 'dart:developer';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/common/domain/user_info.dart';
import '../../../modules/auth/domain/org_subscription_Info_model.dart';
import '../../../utils/api_endpoints.dart';
import 'package:dio/dio.dart' as dio;

class UserInfoController {
  RxBool isSubscriptionExpired = false.obs;
  RxBool isSubscriptionTimeTrackingIsAllow = true.obs;

  Future<UserInfo?> getUserInfo() async {
    final dio.Response? response =
        await Get.find<ApiService>().get(Api.USER_INFO);
    return UserInfo.fromJson(response?.data);
  }

  /// Fetches the organization subscription information
  /// and checks the subscription status.
  Future<bool> getOrgSubscriptionInfo() async {
    try {
      final QueryResult<Object?> response =
          await Get.find<ApiService>().query(getOrgSubscriptionInfoQuery);
      if (response.data != null) {
        return _checkIfSubscription(
            OrgSubscriptionInfoModel.fromJson(response.data!));
      }
      return true;
    } catch (ex) {
      log("getOrgSubscriptionInfo: $ex");
      return true;
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
  bool _checkIfSubscription(OrgSubscriptionInfoModel data) {
    final GetAnOrganizationSubscription? orgSubscriptionInfo =
        data.getAnOrganizationSubscription;

    // Check if subscription is expired (paused or canceled)
    try {
      if (!orgSubscriptionInfo!.status!.contains("active")) {
        isSubscriptionExpired(true);
        return true;
      } else {
        // Check if "time_tracking" feature is enabled
        orgSubscriptionInfo.plan?.planFeatures?.forEach((feature) {
          if (feature.feature?.identifier == "time_tracking") {
            isSubscriptionTimeTrackingIsAllow(feature.isEnabled ?? false);
          }
        });
      }
      return false;
    } catch (e) {
      isSubscriptionExpired(true);
      log("_checkIfSubscription: $e");
      return true;
    }
  }
}
