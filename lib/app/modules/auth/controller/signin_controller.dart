import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as di;
import 'package:payrun_mobile/common/domain/user_info.dart';
import 'package:payrun_mobile/app/modules/auth/models/signin_res.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import '../../../../common/domain/token_model.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/utils.dart';
import '../../../global/controller/user_info_controller.dart';
import '../../../global/services/api_service.dart';
import '../../../global/services/local_store_service.dart';

/// Controller for managing the sign-in process
class SignInController extends GetxController {
  // Native platform channel for iOS device token
  static const MethodChannel _platform =
      MethodChannel('com.gainhq.payrun/deviceToken');

  // Reactive state variables
  final isSignInLoading = false.obs;

  // Device token for push notifications
  String deviceToken = '';

  @override
  void onInit() async {
    super.onInit();
    await _loadLastInputData(); // Load last input data
    await _initializeDeviceToken(); // Initialize device token
  }

  /// Loads the last entered email from storage
  Future<void> _loadLastInputData() async {
    final lastInput =
        await Get.find<LocalStoreService>().read(AppString.LAST_INPUT);
    emailController.text = lastInput ?? ''; // Assign the last input email
  }

  /// Initializes the device token based on platform
  Future<void> _initializeDeviceToken() async {
    try {
      if (Platform.isIOS) {
        // iOS-specific setup
        _platform.setMethodCallHandler((MethodCall call) async {
          if (call.method == 'deviceToken') {
            final token = call.arguments as String? ?? '';
            Get.find<LocalStoreService>()
                .write(AppString.IOS_DEVICE_TOKEN, token);
          }
        });
      } else {
        // Android-specific setup
        deviceToken = await Pushy.register();
      }
    } catch (e) {
      print('Failed to initialize device token: ${e.toString()}');
    }
  }

  /// Logs in the user with email and password
  Future<bool> loginWithCredentials({
    required String email,
    required String password,
  }) async {
    isSignInLoading(true);

    try {
      // API call for login
      final response = await Get.find<ApiService>().post(
        Api.LOGIN,
        {
          'email': email,
          'password': password,
          'device_token': Platform.isIOS
              ? GetStorage().read(AppString.IOS_DEVICE_TOKEN)
              : deviceToken,
          'push_notification_platform': Platform.isIOS ? 'apns' : 'pushy',
        },
      );

      if (response != null) {
        _handleTokenInfo(response); // Save tokens
        final userInfo = await Get.find<UserInfoController>().getUserInfo();
        _handleLoginSuccess(response, userInfo);
        return true;
      }
    } catch (e) {
      print('Login failed: ${e.toString()}');
    } finally {
      isSignInLoading(false);
    }

    return false;
  }

  /// Saves token information to local storage
  void _handleTokenInfo(di.Response response) {
    final tokens = SignInResponse.fromJson(response.data).data;
    final localStore = Get.find<LocalStoreService>();
    localStore
      ..write(AppString.ACCESS_TOKEN, tokens?.accessToken)
      ..write(AppString.REFRESH_TOKEN, tokens?.refreshToken);
  }

  /// Handles successful login operations
  void _handleLoginSuccess(di.Response response, UserInfo? userInfo) {
    final tokens = SignInResponse.fromJson(response.data).data;
    final tokenModel = TokenModel(
      accessToken: tokens?.accessToken ?? '',
      refreshToken: tokens?.refreshToken ?? '',
    );

    final localStore = Get.find<LocalStoreService>();
    localStore
      ..write<String>(
          userInfo?.user?.organizationId ?? '', jsonEncode(tokenModel.toJson()))
      ..write<String>(
          AppString.ORGANIZATION_ID, userInfo?.user?.organizationId ?? '')
      ..write<String>(
          AppString.ORGANIZATION_USER_ID, userInfo?.user?.orgUserId ?? '')
      ..write<String>(AppString.LAST_INPUT, emailController.text)
      ..write<bool>(AppString.LOGGED_IN, true);
  }
}
