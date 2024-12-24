import 'dart:async';
import 'package:get/get.dart';
import 'local_storage_service.dart';
import '../../../utils/app_string.dart';

class AuthTokenService {
  final LocalStoreService _localStoreService = Get.find<LocalStoreService>();

  /// Store the access token securely and cache it in memory.
  Future<void> storeAccessToken(String token) async {
    await _localStoreService.write(AppString.ACCESS_TOKEN, token);
  }

  /// Retrieve the access token from secure storage.
  Future<String?> getAccessToken() async {
    return await _localStoreService.read(AppString.ACCESS_TOKEN);
  }

  /// Delete the access token from both memory and secure storage.
  Future<void> deleteAccessToken() async {
    await _localStoreService.delete(AppString.ACCESS_TOKEN);
  }
}
