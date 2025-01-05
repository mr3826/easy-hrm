import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as di;
import 'package:payrun_mobile/common/domain/last_input_model.dart';
import 'package:payrun_mobile/common/domain/user_info.dart';
import 'package:payrun_mobile/modules/auth/domain/signin_res.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import '../../../../common/domain/token_model.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/utils.dart';
import '../../../global/controller/user_info_controller.dart';
import '../../../global/services/api_service.dart';
import '../../../global/services/local_store_service.dart';

/// Controller responsible for managing the sign-in process
/// including handling login, subscription status, and last input data.
class SignInController extends GetxController with StateMixin {
  static const MethodChannel _platform =
      MethodChannel('com.gainhq.payrun/deviceToken');

  // Observable variables to track the state
  RxString organizationAvailabilityMessage = "".obs;
  final isLoading = false.obs;
  final isSignInLoading = false.obs;
  RxBool isValue = true.obs;
  String deviceToken = '';

  /// Toggles the value of [isValue]
  void changeVal() {
    isValue.value = !isValue.value;
  }

  @override
  void onInit() async {
    setLastInputData(); // Load last input data when initializing
    if (Platform.isIOS) {
      _initializeDeviceToken();
    } else {
      deviceToken = await Pushy.register();
    }
    super.onInit();
  }

  /// Loads and sets the last input data (email) from storage.
  void setLastInputData() async {
    emailController.text =
        await Get.find<LocalStoreService>().read(AppString.LAST_INPUT);
  }

  Future<bool> loginWithCredentials(
      {required String email, required String password}) async {
    isSignInLoading(true);
    di.Response? response = await Get.find<ApiService>().post(Api.LOGIN, {
      "email": email,
      "password": password,
      "device_token": Platform.isIOS
          ? GetStorage().read(AppString.IOS_DEVICE_TOKEN)
          : deviceToken,
      "push_notification_platform": Platform.isIOS ? "apns" : "pushy"
    });

    isSignInLoading(false);

    if (response != null) {
      _handleTokenInfo(response);
      final UserInfo? userInfoResponse =
          await Get.find<UserInfoController>().getUserInfo();
      _handleLoginSuccess(response, userInfoResponse);
      return true;
    }
    return false;
  }

  void _handleTokenInfo(di.Response response) {
    Get.find<LocalStoreService>()
      ..write(AppString.ACCESS_TOKEN,
          SignInResponse.fromJson(response.data).data?.accessToken)
      ..write(AppString.REFRESH_TOKEN,
          SignInResponse.fromJson(response.data).data?.refreshToken);
  }

  /// Handles login success by saving tokens and navigating to the main screen.
  void _handleLoginSuccess(di.Response response, UserInfo? userInfo) {
    // Save token information
    TokenModel tokenModel = TokenModel(
      accessToken:
          SignInResponse.fromJson(response.data).data?.accessToken ?? "",
      refreshToken:
          SignInResponse.fromJson(response.data).data?.refreshToken ?? "",
    );
    String tokenJson = jsonEncode(tokenModel.toJson());

    // Store tokens in local storage
    Get.find<LocalStoreService>()
      ..write(userInfo?.user?.organizationId ?? "", tokenJson)
      // ..write(AppString.LOGGED_IN, true)
      ..write(AppString.ORGANIZATION_ID, userInfo?.user?.organizationId ?? "")
      ..write(AppString.ORGANIZATION_USER_ID, userInfo?.user?.orgUserId ?? "")
      ..write(AppString.LAST_INPUT, emailController.text);
  }

  Future<void> _initializeDeviceToken() async {
    try {
      // Set up a listener for the 'deviceToken' method from iOS native side
      _platform.setMethodCallHandler((MethodCall call) async {
        if (call.method == 'deviceToken') {
          final String token = call.arguments ?? ""; // Ensure token is not null
          GetStorage().write(AppString.IOS_DEVICE_TOKEN, token);
        }
      });
    } catch (e) {
      print("Failed to receive device token: '${e.toString()}'");
    }
  }
}
