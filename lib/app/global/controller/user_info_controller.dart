import 'dart:developer';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/enum/user_enum.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/common/domain/user_info.dart';
import '../models/org_subscription_Info_model.dart';
import '../../../utils/api_endpoints.dart';
import 'package:dio/dio.dart' as dio;

class UserInfoController {
  RxBool isSubscriptionTimeTrackingIsAllow = true.obs;
  UserEnum userRole = UserEnum.employee;

  Future<UserInfo?> getUserInfo() async {
    final dio.Response? response =
        await Get.find<ApiService>().get(Api.USER_INFO);
    UserInfo userInfo = UserInfo.fromJson(response?.data);
    print('user role b:$userRole');
    userRole = _getUserRole(userInfo.user?.roles ?? <String>[]);
    print('user role a:$userRole');
    return userInfo;
  }

  /// Fetches the organization subscription information
  /// and checks the subscription status.
  Future<bool> getOrgSubscriptionInfo() async {
    try {
      final QueryResult<Object?> response = await Get.find<ApiService>()
          .gqlCall(queryString: getOrgSubscriptionInfoQuery);
      if (response.data != null) {
        return _checkIfSubscription(
            OrgSubscriptionInfoModel.fromJson(response.data!)
                    .getAnOrganizationSubscription ??
                GetAnOrganizationSubscription());
      }
    } catch (ex) {
      log("getOrgSubscriptionInfo: $ex");
    }
    return false;
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
  bool _checkIfSubscription(GetAnOrganizationSubscription subscriptionInfo) {
    // Check if subscription status is active or trialing
    if (!checkStatus(subscriptionInfo.status ?? "")) {
      return false; // Return early if subscription is not active or trialing
    }
    // If the user is active, check the subscription plan features
    subscriptionInfo.plan?.planFeatures?.forEach((feature) {
      if (feature.feature?.identifier == "time_tracking") {
        isSubscriptionTimeTrackingIsAllow(feature.isEnabled ?? false);
      }
    });
    // Return true if the user is active
    return true;
  }


  bool checkStatus(String status) {
    if (status.isEmpty) return false;
    return ["active", "trialing"].contains(status);
  }

  UserEnum _getUserRole(List<String> roles) {
    if (roles.contains("org_owner")) {
      return UserEnum.owner;
    }

    if (roles.contains("org_dept_head")) {
      return roles.contains("org_hiring_team")
          ? UserEnum.owner
          : UserEnum.dept_head;
    }

    if (roles.contains("org_hiring_team")) {
      return UserEnum.hr_manager;
    }

    return UserEnum.employee;
  }
}
