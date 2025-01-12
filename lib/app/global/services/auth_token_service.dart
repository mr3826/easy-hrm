import 'package:get/get.dart';
import '../../../utils/app_string.dart';
import 'local_store_service.dart';

class AuthTokenService {
  final LocalStoreService _localStoreService = Get.find<LocalStoreService>();

  /// Store the access token securely
  Future<void> storeAccessToken(String token) async {
    await _localStoreService.write(AppString.ACCESS_TOKEN, token);
  }

  /// Retrieve the access token securely
  Future<String?> getAccessToken() async {
    return await _localStoreService.read(AppString.ACCESS_TOKEN);
  }

  /// Store the refresh token securely
  Future<void> storeRefreshToken(String refreshToken) async {
    await _localStoreService.write(AppString.REFRESH_TOKEN, refreshToken);
  }

  /// Retrieve the refresh token securely
  Future<String?> getRefreshToken() async {
    return await _localStoreService.read(AppString.REFRESH_TOKEN);
  }

  /// Delete both access and refresh tokens securely
  Future<void> deleteTokens() async {
    await _localStoreService.delete(AppString.ACCESS_TOKEN);
    await _localStoreService.delete(AppString.REFRESH_TOKEN);
  }
}
