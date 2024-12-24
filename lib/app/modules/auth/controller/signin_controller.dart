import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as di;
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/app/global/services/local_storage_service.dart';
import 'package:payrun_mobile/app/global/controller/user_info_controller.dart';
import 'package:payrun_mobile/common/domain/last_input_model.dart';
import 'package:payrun_mobile/common/domain/user_info.dart';
import 'package:payrun_mobile/modules/auth/domain/signin_res.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import '../../../../common/domain/token_model.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/utils.dart';

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

  /// Instance of NetworkClient to handle API requests
  final NetworkClient _networkClient = Get.find<NetworkClient>();

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
  void setLastInputData() {
    final lastInputJson = GetStorage().read(AppString.LAST_INPUT);
    if (lastInputJson != null) {
      Map<String, dynamic> jsonMap = json.decode(lastInputJson);
      LastInput lastInput = LastInput.fromJson(jsonMap);
      emailController.text = lastInput.email ?? "";
    }
  }

  /// Handles the login process with provided [email] and [password].
  /// Saves token info on success and navigates to the main screen.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    isSignInLoading(true); // Start loading
    try {
      // API call to perform login
      di.Response? response =
          await Get.find<ApiService>().makePostApiCall(Api.LOGIN, {
        "email": email,
        "password": password,
        "device_token": Platform.isIOS
            ? GetStorage().read(AppString.IOS_DEVICE_TOKEN)
            : deviceToken,
        "push_notification_platform": Platform.isIOS ? "apns" : "pushy"
      });
      if (response != null) {
        _handleTokenInfo(response);
        final userInfoResponse =
            await Get.find<UserInfoController>().getUserInfo();
        _handleLoginSuccess(response, userInfoResponse);
        await Get.find<UserInfoController>().getOrgSubscriptionInfo();
        // Navigate to the main screen
        Get.offNamed(Routes.MAIN_SCREEN);
      }
    } catch (e) {
      log(e.toString());
    }
    isSignInLoading(false); // End loading
  }

  /// Saves the last input data (email) to local storage.
  void _saveData() {
    LastInput lastInput = LastInput(email: emailController.text);
    String jsonObject = jsonEncode(lastInput.toJson());
    GetStorage().write(AppString.LAST_INPUT, jsonObject);
  }

  // Private helper functions

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
    GetStorage().write(userInfo?.user?.organizationId ?? "", tokenJson);
    GetStorage().write(AppString.LOGGED_IN, true);
    GetStorage()
        .write(AppString.ORGANIZATION_ID, userInfo?.user?.organizationId ?? "");
    // Store the organization user ID in GetStorage.
    GetStorage()
        .write(AppString.ORGANIZATION_USER_ID, userInfo?.user?.orgUserId ?? "");
    // Save last input data and get subscription info
    _saveData();
  }

  void _handleTokenInfo(di.Response response) {
    Get.find<LocalStoreService>()
      ..write(AppString.ACCESS_TOKEN,
          SignInResponse.fromJson(response.data).data?.accessToken)
      ..write(AppString.REFRESH_TOKEN,
          SignInResponse.fromJson(response.data).data?.refreshToken);
  }

  Future<void> _initializeDeviceToken() async {
    try {
      // Set up a listener for the 'deviceToken' method from iOS native side
      _platform.setMethodCallHandler((MethodCall call) async {
        if (call.method == 'deviceToken') {
          final String token = call.arguments ?? ""; // Ensure token is not null
          GetStorage().write(AppString.IOS_DEVICE_TOKEN, token);
          print('''
          token: $token
          saved token: ${GetStorage().read(AppString.IOS_DEVICE_TOKEN)}
          ''');
        }
      });
    } catch (e) {
      print("Failed to receive device token: '${e.toString()}'");
    }
  }
}
