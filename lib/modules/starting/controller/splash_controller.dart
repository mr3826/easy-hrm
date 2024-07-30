import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../common/controller/connectivity_controller.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/utils.dart';
import '../../auth/domain/signin_res.dart';
import '../../auth/presentation/controller/signin_controller.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      Get.to(const NetworkErrorPage());
      Get.find<ConnectivityController>().isDialogIsOpened(true);
    } else {
      if (GetStorage().read(AppString.ACCESS_TOKEN) != null) {
        if (checkTokenExpiration().isNegative || checkTokenExpiration() < 1) {
          _getNewToken().then((value) => value == true
              ? Future.delayed(const Duration(milliseconds: 2500), () async {
                  await Get.find<SignInController>().getOrgSubscriptionInfo();
                  chooseScreen();
                })
              : Future.delayed(const Duration(milliseconds: 2500),
                  () => Get.offAndToNamed(Routes.SIGN_IN_SCREEN)));
        } else {
          Future.delayed(const Duration(milliseconds: 2500), () async {
            await Get.find<SignInController>().getOrgSubscriptionInfo();
            chooseScreen();
          });
        }
      } else {
        Future.delayed(
            const Duration(milliseconds: 2500), () => chooseScreen());
      }

      super.onReady();
    }
  }

  chooseScreen() async {
    final box = GetStorage();
    if (box.read(AppString.IS_LOGGED_IN_FIRST_TIME) == true ||
        box.read(AppString.IS_LOGGED_IN_FIRST_TIME) == null) {
      Get.offNamed(Routes.ONBOARD_SCRREN);
    } else if (box.read(AppString.ACCESS_TOKEN) == null) {
      Get.offAndToNamed(Routes.SIGN_IN_SCREEN);
    } else {
      Get.offAndToNamed(Routes.MAIN_SCREEN);
    }
  }

  int checkTokenExpiration() {
    DateTime now = DateTime.now();

    // Specify the target date and time

    DateTime targetDate =
        JwtDecoder.getExpirationDate(GetStorage().read(AppString.ACCESS_TOKEN));

    // Calculate the difference
    Duration difference = targetDate.difference(now);

    return difference.inHours;
  }

  Future<bool> _getNewToken() async {
    try {
      Response response = await NetworkClient().postRequest(Api.REFRESH_TOKEN, {
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID),
        "refreshToken": GetStorage().read(AppString.REFRESH_TOKEN)
      });

      if (response.hasError) {
        logErrorMessage(logName: "refresh token", response: response);
        return false;
      } else {
        logSuccessMessage(logName: "refresh token", response: response);
        GetStorage().write(AppString.ID_TOKEN,
            SignInResponse.fromJson(response.body).data?.idToken ?? "");
        GetStorage().write(AppString.ACCESS_TOKEN,
            SignInResponse.fromJson(response.body).data?.accessToken ?? "");
        GetStorage().write(AppString.REFRESH_TOKEN,
            SignInResponse.fromJson(response.body).data?.refreshToken ?? "");
        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}


void checkIfSubscription() {
  var data = Get.find<SignInController>().orgSubscriptionInfoModel;
  if (data.getOrgSubscriptionInfo?.status =="paused" || data.getOrgSubscriptionInfo?.status =="canceled") {
    Get.find<SignInController>().isSubscriptionExpired(true);
  } else {
    data.getOrgSubscriptionInfo?.subscribedPlan?.planFeatures
        ?.forEach((element) {
      if (element.feature?.identifier == "time_tracking") {
        if (element.isEnabled == true) {
          Get.find<SignInController>().isSubscriptionTimeTrackingIsAllow(true);
        } else {
          Get.find<SignInController>().isSubscriptionTimeTrackingIsAllow(false);
        }
      }
    });
  }
  Get.offNamed(Routes.MAIN_SCREEN);
}