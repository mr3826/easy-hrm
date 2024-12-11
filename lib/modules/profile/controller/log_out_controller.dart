import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../routes/app_pages.dart';

class LogoutController {
  RxBool isLogoutLoading = false.obs;

  Future<void> logout() async {
    isLogoutLoading(true);
    try {
      await NetworkClient().postRequest(Api.LOGOUT, {
        "refreshToken": GetStorage().read(AppString.REFRESH_TOKEN),
      });

      removeTokenForOrg(Get.find<UserProfileController>()
          .organizationInfo
          ?.getUserOrganizations
          ?.data
          ?.map((e) => e.organization?.id)
          .toList() ??
          []);

    } catch (e) {
      log(e.toString());
    } finally {
      _clearSession();
    }
    isLogoutLoading(false);
  }

  void _clearSession() {
    GetStorage()
      ..remove(AppString.ACCESS_TOKEN)
      ..remove(AppString.LOGGED_IN);
    Get.offAllNamed(Routes.SIGN_IN_SCREEN);
    passwordController.clear();
  }
}

void removeTokenForOrg(List<String?> orgIds) {
  GetStorage box = GetStorage();
  orgIds.map(
    (e) async => await box.remove(e ?? ""),
  );
}
